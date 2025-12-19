param()
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir\common.ps1"
Check-Root
$fileName = ".github\CHARTER.md"
$template = ".github\templates\charter.md"
if (-not (Test-Path $template)) {
    Log-Error "Template $template not found."
    exit 1
}
if (Test-Path $fileName) {
    Log-Warn "$fileName already exists. Skipping."
    exit 0
}
Copy-Item $template $fileName
Log-Success "Created Repository Charter at $fileName"
