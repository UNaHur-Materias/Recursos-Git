<#
====================================================================================================
🧰 GitHub Repo Initializer & Sync (CLI)

Descripción:
Script de automatización en PowerShell (PS1) diseñado para agilizar la creación de repositorios
en organizaciones de GitHub y su inmediata vinculación con proyectos locales.

Ideal para docentes o administradores que necesitan inicializar rápidamente estructuras de trabajo,
exámenes o plantillas de código, garantizando que el entorno local y el remoto queden perfectamente
sincronizados en un solo paso, sin lidiar con comandos manuales repetitivos.

----------------------------------------------------------------------------------------------------

Funcionalidades principales:
- Creación interactiva de repositorios dentro de una organización específica.
- Configuración dinámica de visibilidad (Público / Privado).
- Conversión automatizada a Repositorio Plantilla (Template) mediante parches a la API de GitHub.
- Validación previa de la existencia de la ruta local para evitar ejecuciones fallidas.
- Inicialización inteligente de Git local (rama 'main') si el directorio no está versionado.
- Limpieza automática de remotos previos (`origin`) para prevenir conflictos de vinculación.
- Automatización del flujo completo de despliegue inicial (Add, Commit y Push Upstream).

----------------------------------------------------------------------------------------------------

Prerequisitos:
- Sistema operativo: Windows con PowerShell 5.1 o superior.
- GitHub CLI (`gh`) instalado en el sistema.
- Sesión de GitHub activa y autenticada en la consola con los permisos necesarios para 
  crear repositorios en la organización destino. Se resuelve previamente ejecutando:
    gh auth login
- Git instalado y configurado globalmente en la máquina.

----------------------------------------------------------------------------------------------------

Notas:
- Si la carpeta local está completamente vacía, Git no podrá realizar el primer commit, lo que
  provocará una advertencia en el paso final del Push, aunque el repositorio remoto se creará igual.
- El script sobrescribe de manera segura el remote `origin` local si este ya existía.
- La conversión a template (`is_template=true`) utiliza un comando directo de la API de GitHub, 
  por lo que requiere conexión a internet estable y alcances (scopes) de token adecuados.

----------------------------------------------------------------------------------------------------

Versión: 1.0.0
Fecha: 2026-05-18
Autor: Mauricio

====================================================================================================
#>

# 1. Solicitar los datos básicos
$miOrganizacion = Read-Host "Ingrese nombre de la orga"
$miRepo = Read-Host "Ingrese nombre del repo"
$rutaLocal = Read-Host "Ingrese la ruta de la carpeta local (ej: C:\REPO\mi-proyecto)"

# 2. Menú interactivo para la Visibilidad
Write-Host "`nElija la visibilidad del repo:" -ForegroundColor Cyan
Write-Host "1. Privado (Recomendado para exámenes)"
Write-Host "2. Público"
$opcionVis = Read-Host "Seleccione una opción (1 o 2)"
$visibilidad = if ($opcionVis -eq "2") { "public" } else { "private" }

# 3. Menú interactivo para definir si es Plantilla
Write-Host "`n¿Desea que el repositorio sea una plantilla (Template)?" -ForegroundColor Cyan
Write-Host "1. Sí"
Write-Host "2. No"
$opcionTemp = Read-Host "Seleccione una opción (1 o 2)"
$esTemplate = if ($opcionTemp -eq "1") { $true } else { $false }

# 4. Validar que la carpeta local exista antes de hacer nada en GitHub
if (-not (Test-Path $rutaLocal)) {
    Write-Error "La ruta local '$rutaLocal' no existe. Ejecución abortada."
    exit
}

# 5. Construir la ruta destino de GitHub
$target = "$miOrganizacion/$miRepo"

Write-Host "`n----------------------------------------------------------" -ForegroundColor Cyan
Write-Host "1. Creando repositorio en GitHub: $target ($visibilidad)..." -ForegroundColor Cyan

# 6. Ejecutar la creación en GitHub (guardamos la URL de retorno que nos da gh cli)
$urlRemota = gh repo create $target --$visibilidad --confirm 2>$null

# 7. Validar si el comando de GitHub fue exitoso
if ($LASTEXITCODE -eq 0) {
    Write-Host "¡Repositorio en GitHub creado con éxito!" -ForegroundColor Green
    Write-Host "URL Remota: $urlRemota" -ForegroundColor Gray
    
    # 8. Si el usuario eligió que sea template, aplicar el parche vía API
    if ($esTemplate) {
        Write-Host "Configurando el repositorio como plantilla..." -ForegroundColor Cyan
        gh api -X PATCH "repos/$target" -f is_template=true | Out-Null
    }

    Write-Host "`n2. Configurando entorno local en: $rutaLocal" -ForegroundColor Cyan
    
    # Cambiar de directorio a la carpeta del proyecto local
    Set-Location $rutaLocal

    # Inicializar Git local si no está inicializado ya
    if (-not (Test-Path ".git")) {
        git init -b main
        Write-Host "Repositorio Git local inicializado (rama 'main')." -ForegroundColor Gray
    }

    # Vincular con el repositorio remoto de GitHub
    # Si ya existía un origen, lo removemos para evitar conflictos y agregamos el nuevo
    git remote remove origin 2>$null
    git remote add origin "$urlRemota.git"
    Write-Host "Origen remoto configurado a: $urlRemota.git" -ForegroundColor Gray

    # Preparar archivos, hacer primer commit y subir (Push)
    Write-Host "`n3. Ejecutando primer Commit y Push..." -ForegroundColor Cyan
    
    git add .
    git commit -m "Commit de $miRepo"
    
    # Primer push estableciendo la rama remota de seguimiento (upstream)
    git push -u origin main

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n[ÉXITO] Todo configurado y sincronizado correctamente en local y remoto." -ForegroundColor Green
    } else {
        Write-Warning "`n[ALERTA] El repo se creó pero falló el Push (puede que la carpeta local esté vacía)."
    }

} else {
    Write-Error "No se pudo crear el repositorio en GitHub. Verifique permisos o si el nombre ya existe."
}

Write-Host "----------------------------------------------------------" -ForegroundColor Cyan