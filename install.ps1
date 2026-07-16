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

$FontRegistryPaths = @(
  "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts",
  "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
)

$InstalledFontRecords = foreach ($RegistryPath in $FontRegistryPaths) {
  if (Test-Path -LiteralPath $RegistryPath) {
    $FontProperties = Get-ItemProperty -LiteralPath $RegistryPath
    $FontProperties.PSObject.Properties |
      Where-Object { $_.Name -notlike "PS*" } |
      ForEach-Object { "$($_.Name) $($_.Value)" }
  }
}

$InstalledFontText = $InstalledFontRecords -join "`n"
$SourceHanFound = $InstalledFontText -match "Source Han Serif|SourceHanSerifSC|思源宋体"
$SfMonoFound = $InstalledFontText -match "SF Mono|SFMono"

$SourceHanStatus = if ($SourceHanFound) {
  "Detected: Source Han Serif SC"
} else {
  "Not detected: Source Han Serif SC (the theme will use its fallback stack)"
}

$SfMonoStatus = if ($SfMonoFound) {
  "Detected: SF Mono"
} else {
  "Not detected: SF Mono (the theme will use Cascadia Mono or Consolas)"
}

$Message = @"
Claude Paper was installed successfully.

Open Obsidian, then go to:
Settings > Appearance > Themes > Claude Paper

Installed to:
$ThemeFolder

Font check:
$SourceHanStatus
$SfMonoStatus

If a font was installed while Obsidian was open, fully quit and reopen Obsidian.
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
