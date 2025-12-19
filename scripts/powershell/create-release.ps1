# Create a Release Plan
param(
    [Parameter(Mandatory=$true)][string]$Version
)

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

Check-Root

$Filename = ".github\releases\$Version.md"
$Template = ".github\release-plan.md"

if (Test-Path $Filename) {
    Log-Warn "Plan $Filename already exists."
    exit 0
}

if (-not (Test-Path $Template)) {
    Log-Error "Template $Template not found. Run 'git-kit init'."
    exit 1
}

Copy-Item $Template $Filename
# Replace placeholders
(Get-Content $Filename) -replace '\[VERSION\]', $Version | Set-Content $Filename

Log-Success "Created Release Plan at $Filename"
