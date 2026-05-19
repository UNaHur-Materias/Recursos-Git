<#
====================================================================================================
🧰 RepoTracert Single:
Analizador de  Metricas y Contribución de repositorios

Descripción:
Script de auditoría y análisis métrico en PowerShell (PS1) diseñado para la extracción profunda 
de datos del historial de Git y su posterior consolidación en reportes analíticos de Excel (CSV).

La herramienta clona repositorios de forma local y temporal para inspeccionar minuciosamente el
impacto de cada commit sin consumir cuotas de la API de GitHub (evitando Rate Limits). Está
especialmente orientado a la evaluación del trabajo en equipo, permitiendo auditar la distribución
del esfuerzo, el tamaño de los aportes y la autoría real del código fuente.

----------------------------------------------------------------------------------------------------

Funcionalidades principales:
- Clonado automatizado y transparente en el directorio temporal del sistema (`$env:TEMP`).
- Extracción del mapa de autoría, hashes de confirmación y descriptores de commits.
- Medición volumétrica del impacto mediante el cálculo estricto de líneas añadidas y eliminadas.
- Análisis de metadatos del mensaje de confirmación (conteo exacto de caracteres).
- Algoritmo de distribución porcentual: calcula el peso específico de cada commit y de cada 
  autor sobre el volumen total de mutaciones (`additions + deletions`) del repositorio.
- Exportación estructurada en formato CSV con codificación UTF-8 para compatibilidad nativa 
  en Excel con caracteres especiales (acentos, eñes).
- Rutina de limpieza automática que remueve todo rastro del código clonado al finalizar.

----------------------------------------------------------------------------------------------------

Prerequisitos:
- Sistema operativo: Windows con PowerShell 5.1 o superior.
- Git instalado y accesible desde las variables de entorno del sistema (PATH).
- Permisos de lectura sobre el repositorio a auditar. Si el repositorio es privado, la sesión 
  local de Git o GitHub CLI debe estar previamente autenticada (`gh auth login`).
- Espacio temporal disponible en disco proporcional al tamaño del repositorio analizado.

----------------------------------------------------------------------------------------------------

Notas:
- El "Porcentaje de Aporte" es relativo al total de líneas modificadas históricamente en el proyecto.
- Los archivos binarios o cambios de formato masivos (ej: linters, configuraciones iniciales) 
  pueden alterar las métricas de líneas, por lo que se recomienda una lectura contextualizada.
- Si un estudiante realiza commits utilizando múltiples correos o nombres diferentes, Git los
  procesará como autores independientes según conste en el log del commit.

----------------------------------------------------------------------------------------------------

Versión: 1.0.0
Fecha: 2026-05-19
Autor: Mauricio

====================================================================================================
#>

# 1. Solicitar la URL del repositorio y ruta de guardado
$repoUrl = Read-Host "Ingrese la URL del repositorio de GitHub"
$inputPath = Read-Host "Ingrese la ruta donde guardar el CSV (ej: C:\unq\reporte.csv)"

# Si el usuario no ingresó nada, asignamos un nombre por defecto
if ([string]::IsNullOrWhiteSpace($inputPath)) { $inputPath = "reporte_metricas.csv" }

# Si el usuario no le puso la extensión .csv, se la agregamos automáticamente
if ($inputPath -notlike "*.csv") { $inputPath += ".csv" }

# RESOLUCIÓN INMUNE A ERRORES: Convierte cualquier entrada en ruta absoluta real basándose en la ubicación actual
$currentDir = (Get-Location).ProviderPath
$outputPath = [System.IO.Path]::Combine($currentDir, $inputPath)
$outputPath = [System.IO.Path]::GetFullPath($outputPath)

$tempFolder = Join-Path $env:TEMP "repo_analizer_$(Get-Random)"

Write-Host "`n[1/4] Clonando repositorio en carpeta temporal..." -ForegroundColor Cyan
git clone --quiet $repoUrl $tempFolder


if ($LASTEXITCODE -ne 0) {
    Write-Error "No se pudo clonar el repositorio. Verifique la URL o sus permisos."
    exit
}

Set-Location $tempFolder

Write-Host "[2/4] Extrayendo historial de commits y cambios..." -ForegroundColor Cyan
# Obtenemos hash, autor, fecha y mensaje separados por un delimitador especial
$commits = git log --pretty=format:"%H|%an|%s"

# Listas para almacenar los datos procesados
$reporteCommits = [System.Collections.Generic.List[PSCustomObject]]::new()
$lineasPorAutor = @{}
$totalLineasGlobal = 0

Write-Host "[3/4] Procesando impacto y métricas de código..." -ForegroundColor Cyan
foreach ($line in $commits) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line.Split('|')
    $hash = $parts[0]
    $autor = $parts[1]
    $mensaje = $parts[2]

    # Obtener líneas agregadas y eliminadas en ESTE commit específico
    $stats = git show --numstat --pretty=format:"" $hash
    $lineasAgregadas = 0
    $lineasEliminadas = 0

    foreach ($s in $stats) {
        if ($s -match "^(\d+)\s+(\d+)\s+(.+)$") {
            $lineasAgregadas += [int]$Matches[1]
            $lineasEliminadas += [int]$Matches[2]
        }
    }

    $totalCambiosCommit = $lineasAgregadas + $lineasEliminadas
    $caracteresMensaje = $mensaje.Length

    # Acumular para el cálculo de porcentajes posterior
    if (-not $lineasPorAutor.ContainsKey($autor)) { $lineasPorAutor[$autor] = 0 }
    $lineasPorAutor[$autor] += $totalCambiosCommit
    $totalLineasGlobal += $totalCambiosCommit

    # Guardar registro temporal del commit
    $reporteCommits.Add([PSCustomObject]@{
        Hash               = $hash
        Autor              = $autor
        Mensaje            = $mensaje
        CaracteresMensaje  = $caracteresMensaje
        LineasAgregadas    = $lineasAgregadas
        LineasEliminadas   = $lineasEliminadas
        TotalCambiosCommit = $totalCambiosCommit
        PorcentajeAporte   = 0 # Se calcula en el siguiente paso
    })
}

# [4/4] Calcular porcentajes finales y exportar
Write-Host "[4/4] Calculando porcentajes de aporte y exportando a CSV..." -ForegroundColor Cyan
foreach ($commit in $reporteCommits) {
    if ($totalLineasGlobal -gt 0) {
        # Porcentaje del commit actual respecto al total del repositorio
        $porcentaje = ($commit.TotalCambiosCommit / $totalLineasGlobal) * 100
        $commit.PorcentajeAporte = [Math]::Round($porcentaje, 2)
    }
}

# Exportar con codificación UTF8 para evitar problemas con eñes o acentos en Excel
$reporteCommits | Export-Csv -Path $outputPath -NoTypeInformation -Delimiter "," -Encoding UTF8

# Limpieza del directorio temporal
Set-Location $env:USERPROFILE
Remove-Item -Recurse -Force $tempFolder -ErrorAction SilentlyContinue

Write-Host "`n[ÉXITO] Reporte generado correctamente en: $outputPath" -ForegroundColor Green