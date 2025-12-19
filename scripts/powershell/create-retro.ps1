param()
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir\common.ps1"
Check-Root
$date = Get-Date -Format "yyyy-MM-dd"
$fileName = ".github\retros\${date}.md"
$template = ".github\templates\retro.md"
if (-not (Test-Path ".github\retros")) {
    New-Item -ItemType Directory -Path ".github\retros" -Force
}
if (-not (Test-Path $template)) {
    Log-Error "Template $template not found."
    exit 1
}
Copy-Item $template $fileName
Log-Success "Created Retrospective at $fileName"
