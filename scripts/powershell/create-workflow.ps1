param([string]$Name)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptDir\common.ps1"
if (-not $Name) {
    Log-Warn "Usage: create-workflow.ps1 -Name `"Workflow Name`""
    Log-Info "Defaulting to 'Custom Workflow'"
    $Name = "Custom Workflow"
}
Check-Root
$slug = $Name.ToLower() -replace '[^a-z0-9]', '-'
$fileName = ".github\workflows\designs\${slug}.md"
$template = ".github\templates\workflow.md"
if (-not (Test-Path ".github\workflows\designs")) {
    New-Item -ItemType Directory -Path ".github\workflows\designs" -Force
}
if (-not (Test-Path $template)) {
    Log-Error "Template $template not found."
    exit 1
}
Copy-Item $template $fileName
(Get-Content $fileName) -replace '\[Workflow Name\]', $Name | Set-Content $fileName
Log-Success "Created Workflow Design at $fileName"
