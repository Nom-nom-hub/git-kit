# Create a PR Plan
param(
    [Parameter(Mandatory=$true)][string]$Name
)

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path
. "$ScriptDir\common.ps1"

Check-Root

$Slug = $Name.ToLower() -replace '[^a-z0-9]', '-'
$Filename = ".github\pr-plans\$Slug.md"
$Template = ".github\templates\pr.md"

if (-not (Test-Path $Template)) {
    Log-Warn "Template not found at $Template. Using default."
    Set-Content -Path $Filename -Value "# PR Plan: $Name"
} else {
    Copy-Item $Template $Filename
}

# Replace placeholders
(Get-Content $Filename) -replace '\[PR Title\]', $Name | Set-Content $Filename

Log-Success "Created PR Plan at $Filename"
Write-Host "Instructions: Edit the file to plan your implementation."
