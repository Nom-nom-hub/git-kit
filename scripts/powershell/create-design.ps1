# Create a Design Doc
param(
    [Parameter(Mandatory=$true)][string]$Title
)

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

Check-Root

$Slug = $Title.ToLower() -replace '[^a-z0-9]', '-'
$Filename = ".github\designs\$Slug.md"
$Template = ".github\design-doc.md"

if (-not (Test-Path $Template)) {
    Log-Error "Template $Template not found. Run 'git-kit init'."
    exit 1
}

Copy-Item $Template $Filename
# Replace placeholders
(Get-Content $Filename) -replace '\[TITLE\]', $Title | Set-Content $Filename

Log-Success "Created Design Doc at $Filename"
