<#
====================================================================================================
🧰 RepoTracert Masivo:
Analizador de  Metricas y Contribución de repositorios de manera masiva

Descripción:
Script de auditoría y análisis métrico masivo en PowerShell (PS1) diseñado para la extracción 
profunda de datos del historial de Git y su posterior consolidación en reportes individuales 
en formato CSV (valores separados por comas).

La herramienta automatiza el procesamiento en cascada de múltiples repositorios pertenecientes a 
una organización mediante una URL base y una lista de sufijos. Clona cada repositorio de forma 
local y temporal para inspeccionar detalladamente el impacto de cada commit sin consumir cuotas de 
la API de GitHub (evitando Rate Limits). Está especialmente orientado a la evaluación docente en 
entornos educativos (comisiones de alumnos), permitiendo auditar de manera descentralizada pero 
secuencial la distribución del esfuerzo, el tamaño de los aportes y la autoría real del código fuente.

----------------------------------------------------------------------------------------------------

Funcionalidades principales:
- Gestión masiva y automatizada: procesa listas de repositorios parametrizadas por sufijos en un solo lote.
- Arquitectura 100% nativa: sin dependencias de módulos de terceros, garantizando inmunidad total 
  ante bloqueos de antivirus (AMSI / Windows Defender).
- Clonado secuencial y transparente en el directorio temporal del sistema (`$env:TEMP`).
- Extracción del mapa de autoría, hashes acortados (7 caracteres) y descriptores de commits.
- Medición volumétrica de impacto mediante el cálculo de líneas añadidas y eliminadas por commit.
- Análisis de metadatos del mensaje de confirmación (conteo exacto de caracteres del mensaje).
- Algoritmo de distribución porcentual: calcula el peso específico de cada commit sobre el volumen 
  total de mutaciones (`additions + deletions`) acumuladas de ese repositorio específico.
- Exportación distribuida: genera un archivo `.csv` independiente por cada sufijo procesado, guardándolos 
  automáticamente con codificación UTF-8 en el directorio relativo actual para apertura directa en Excel.
- Rutina de limpieza automática que remueve todo rastro del código clonado tras finalizar cada ciclo.

----------------------------------------------------------------------------------------------------

Prerequisitos:
- Sistema operativo: Windows con PowerShell 5.1 o superior.
- Git instalado y accesible desde las variables de entorno del sistema (PATH).
- Permisos de lectura sobre los repositorios a auditar. Si son privados, la sesión local de 
  Git debe estar previamente autenticada (ej: mediante `gh auth login`).
- Espacio temporal disponible en disco proporcional al tamaño de los repositorios analizados.

----------------------------------------------------------------------------------------------------

Notas:
- El script guarda los reportes resultantes utilizando el nombre del sufijo (ej: `F1-grupo1.csv`) 
  en la misma carpeta desde donde se invoca la consola de ejecución.
- El "Porcentaje de Aporte" es relativo al total de líneas modificadas históricamente en el proyecto.
- Los archivos binarios o cambios de formato masivos (ej: linters, configuraciones iniciales) 
  pueden alterar las métricas de líneas, por lo que se recomienda una lectura contextualizada.
- Si un estudiante realiza commits utilizando múltiples correos o nombres diferentes, Git los
  procesará como autores independientes según conste en el log de confirmación.

----------------------------------------------------------------------------------------------------

Versión: 2.1.0
Fecha: 2026-05-19
Autor: Mauricio

====================================================================================================
#>


# 1. Solicitar los datos masivos de entrada
$orgaBase   = Read-Host "Ingrese el nombre de la organización (ej: obj1-unahur-2026s1)"
$urlBase = "https://github.com/" + "$orgaBase"

$ejercicio = Read-Host "Ingrese el nombre del ejercicio (ej: F1_2024)"
$sufijosIn = Read-Host "Ingrese los sufijos de los repos separados por comas (ej: grupo1, grupo2)"

# Limpiar y procesar la lista de sufijos ingresada
$listaSufijos = $sufijosIn.Split(',').ForEach({ $_.Trim() }) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

if ($listaSufijos.Count -eq 0) {
    Write-Error "No se ingresaron sufijos válidos. Ejecución abortada."
    exit
}

# Asegurar que la URL base termine con barra diagonal para evitar errores de concatenación
if (-not $urlBase.EndsWith("/")) { $urlBase += "/" }

# Capturar la ruta de la carpeta actual desde donde se ejecuta el script
$currentDir = (Get-Location).ProviderPath

# --- BUCLE DE PROCESAMIENTO EN CASCADA ---
foreach ($sufijo in $listaSufijos) {
    
    # Construir la URL del repositorio actual
    $repoUrl = "$urlBase"+ "$ejercicio" + "-" + "$sufijo"

    if (-not $repoUrl.EndsWith(".git")) { $repoUrl += ".git" }

    Write-Host "El repo actual es: $repoUrl" -ForegroundColor Cyan
    
    # Definir la ruta absoluta del CSV de salida para este repositorio específico
    $outputFileName = "$sufijo.csv"
    $outputPath = [System.IO.Path]::Combine($currentDir, $outputFileName)

    Write-Host "`n==========================================================" -ForegroundColor Yellow
    Write-Host "PROCESANDO: $sufijo" -ForegroundColor Yellow
    Write-Host "URL REMOTA: $repoUrl" -ForegroundColor Gray
    Write-Host "DESTINO:    $outputFileName" -ForegroundColor Gray
    Write-Host "==========================================================" -ForegroundColor Yellow

    # Crear una carpeta temporal aleatoria para este ciclo
    $tempFolder = Join-Path $env:TEMP "repo_analizer_$(Get-Random)"

    Write-Host "[1/4] Clonando repositorio de forma temporal..." -ForegroundColor Cyan
    git clone --quiet $repoUrl $tempFolder 2>$null

    if ($LASTEXITCODE -ne 0) {
        Write-Warning "No se pudo clonar el repositorio '$sufijo'. Verifique URL o permisos. Saltando..."
        continue
    }

    # Guardar ubicación original y mudarse a la carpeta temporal del repo clonado
    $originalDir = Get-Location
    Set-Location $tempFolder

    Write-Host "[2/4] Extrayendo historial de commits..." -ForegroundColor Cyan
    $commits = git log --pretty=format:"%H|%an|%s" 2>$null

    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($commits)) {
        Write-Warning "El repositorio '$sufijo' no tiene commits válidos. Saltando..."
        Set-Location $originalDir
        Remove-Item -Recurse -Force $tempFolder -ErrorAction SilentlyContinue
        continue
    }

    # Listas e inicializadores para las métricas del repo actual
    $reporteCommits = [System.Collections.Generic.List[PSCustomObject]]::new()
    $lineasPorAutor = @{}
    $totalLineasGlobal = 0

    Write-Host "[3/4] Analizando impacto de líneas..." -ForegroundColor Cyan
    foreach ($line in $commits) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $parts = $line.Split('|')
        $hash = $parts[0]
        $autor = $parts[1]
        $mensaje = $parts[2]

        # Obtener estadísticas de líneas de este commit específico
        $stats = git show --numstat --pretty=format:"" $hash 2>$null
        $lineasAgregadas = 0
        $lineasEliminadas = 0

        foreach ($s in $stats) {
            if ($s -match "^(\d+)\s+(\d+)\s+(.+)$") {
                $lineasAgregadas += [int]$Matches[1]
                $lineasEliminadas += [int]$Matches[2]
            }
        }

        $totalCambiosCommit = $lineasAgregadas + $lineasEliminadas

        # Acumular totales para el cálculo porcentual posterior
        if (-not $lineasPorAutor.ContainsKey($autor)) { $lineasPorAutor[$autor] = 0 }
        $lineasPorAutor[$autor] += $totalCambiosCommit
        $totalLineasGlobal += $totalCambiosCommit

        # Guardar objeto temporal de datos
        $reporteCommits.Add([PSCustomObject]@{
            Hash               = $hash.Substring(0,7)
            Autor              = $autor
            Mensaje            = $mensaje
            CaracteresMensaje  = $mensaje.Length
            LineasAgregadas    = $lineasAgregadas
            LineasEliminadas   = $lineasEliminadas
            TotalCambiosCommit = $totalCambiosCommit
            PorcentajeAporte   = 0
        })
    }

    # Calcular los porcentajes finales de aporte sobre este repositorio
    foreach ($commit in $reporteCommits) {
        if ($totalLineasGlobal -gt 0) {
            $porcentaje = ($commit.TotalCambiosCommit / $totalLineasGlobal) * 100
            $commit.PorcentajeAporte = [Math]::Round($porcentaje, 2)
        }
    }

    Write-Host "[4/4] Exportando datos a CSV..." -ForegroundColor Cyan
    # Exportar de manera nativa con codificación segura para caracteres en español
    $reporteCommits | Export-Csv -Path $outputPath -NoTypeInformation -Delimiter "," -Encoding UTF8

    # Regresar al directorio original y limpiar rastro temporal de código
    Set-Location $originalDir
    Remove-Item -Recurse -Force $tempFolder -ErrorAction SilentlyContinue
    
    Write-Host "[ÉXITO] Archivo generado en: .\$outputFileName" -ForegroundColor Green
}

Write-Host "`n[PROCESO TERMINADO] Todos los repositorios procesados correctamente." -ForegroundColor Green