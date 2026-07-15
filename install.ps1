[CmdletBinding()]
param(
  [string]$VaultPath
)

$ErrorActionPreference = "Stop"
$ThemeName = "Claude Paper"
$ProjectRoot = $PSScriptRoot

if (-not $VaultPath) {
  Add-Type -AssemblyName System.Windows.Forms
  $picker = New-Object System.Windows.Forms.FolderBrowserDialog
  $picker.Description = "Select your Obsidian vault folder"
  $picker.ShowNewFolderButton = $true

  if ($picker.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host "Installation cancelled."
    exit 0
  }

  $VaultPath = $picker.SelectedPath
}

$VaultPath = [System.IO.Path]::GetFullPath($VaultPath)
if (-not (Test-Path -LiteralPath $VaultPath -PathType Container)) {
  throw "Vault folder does not exist: $VaultPath"
}

$ThemeFolder = Join-Path $VaultPath ".obsidian\themes\$ThemeName"
New-Item -ItemType Directory -Path $ThemeFolder -Force | Out-Null

Copy-Item -LiteralPath (Join-Path $ProjectRoot "manifest.json") -Destination $ThemeFolder -Force
Copy-Item -LiteralPath (Join-Path $ProjectRoot "theme.css") -Destination $ThemeFolder -Force

$Message = @"
Claude Paper was installed successfully.

Open Obsidian, then go to:
Settings > Appearance > Themes > Claude Paper

Installed to:
$ThemeFolder
"@

Write-Host $Message -ForegroundColor Green

if (-not $PSBoundParameters.ContainsKey("VaultPath")) {
  [System.Windows.Forms.MessageBox]::Show(
    $Message,
    "Claude Paper installed",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
  ) | Out-Null
}

