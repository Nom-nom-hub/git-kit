param()
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir\common.ps1"
Check-Root
$fileName = ".github\releases\notes.md"
$template = ".github\templates\notes.md"
if (-not (Test-Path ".github\releases")) {
    New-Item -ItemType Directory -Path ".github\releases" -Force
}
if (-not (Test-Path $template)) {
    Log-Error "Template $template not found."
    exit 1
}
Copy-Item $template $fileName
Log-Success "Created Release Notes template at $fileName"
