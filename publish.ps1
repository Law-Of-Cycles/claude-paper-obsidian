[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

$Owner = "Law-Of-Cycles"
$Repository = "claude-paper-obsidian"
$FullRepository = "$Owner/$Repository"
$ThemeName = "Claude Paper"
$ReviewRepository = "obsidianmd/obsidian-releases"
$ReviewFork = "$Owner/obsidian-releases"
$ReviewBranch = "add-theme-claude-paper"
$ProjectRoot = $PSScriptRoot
$Manifest = Get-Content -LiteralPath (Join-Path $ProjectRoot "manifest.json") -Raw | ConvertFrom-Json
$Version = [string]$Manifest.version

function Refresh-ProcessPath {
  $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
  $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
  $extra = @(
    "C:\Program Files\Git\cmd",
    "C:\Program Files\GitHub CLI"
  ) -join ";"
  $env:Path = "$machinePath;$userPath;$extra"
}

function Install-WingetPackage {
  param(
    [Parameter(Mandatory = $true)][string]$Id,
    [Parameter(Mandatory = $true)][string]$DisplayName
  )

  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "$DisplayName is required and winget is unavailable. Install it, reopen PowerShell, and run this script again."
  }

  Write-Host "Installing $DisplayName..." -ForegroundColor Cyan
  & winget install --id $Id --exact --source winget --accept-source-agreements --accept-package-agreements
  if ($LASTEXITCODE -ne 0) {
    throw "winget could not install $DisplayName."
  }
  Refresh-ProcessPath
}

function Invoke-Checked {
  if ($args.Count -lt 1) {
    throw "Invoke-Checked requires a program name."
  }

  $Program = [string]$args[0]
  $Arguments = @()
  if ($args.Count -gt 1) {
    $Arguments = $args[1..($args.Count - 1)]
  }

  & $Program @Arguments
  if ($LASTEXITCODE -ne 0) {
    throw "$Program failed with exit code $LASTEXITCODE."
  }
}

Write-Host "Claude Paper community publisher" -ForegroundColor Yellow
Write-Host "GitHub account: $Owner"
Write-Host "Repository: $FullRepository"
Write-Host ""

Refresh-ProcessPath

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Install-WingetPackage -Id "Git.Git" -DisplayName "Git"
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  Install-WingetPackage -Id "GitHub.cli" -DisplayName "GitHub CLI"
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "Git is installed but is not visible in this PowerShell session. Reopen PowerShell and run the script again."
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  throw "GitHub CLI is installed but is not visible in this PowerShell session. Reopen PowerShell and run the script again."
}

& gh auth status --hostname github.com *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Host "GitHub authorization is required once. A browser page will open." -ForegroundColor Cyan
  Invoke-Checked gh auth login --hostname github.com --git-protocol https --web
}

Invoke-Checked gh auth setup-git

$AuthenticatedOwner = ((& gh api user --jq ".login") | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or -not $AuthenticatedOwner) {
  throw "Could not read the authenticated GitHub account."
}

if ($AuthenticatedOwner -ine $Owner) {
  throw "GitHub CLI is signed in as '$AuthenticatedOwner'. Sign in as '$Owner' and run the script again."
}

Push-Location $ProjectRoot
try {
  if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot ".git"))) {
    Invoke-Checked git init
  }

  Invoke-Checked git config user.name $Owner
  Invoke-Checked git config user.email "$Owner@users.noreply.github.com"
  Invoke-Checked git add --all

  & git diff --cached --quiet
  if ($LASTEXITCODE -eq 1) {
    Invoke-Checked git commit -m "Release Claude Paper $Version"
  } elseif ($LASTEXITCODE -ne 0) {
    throw "Git could not inspect the staged project files."
  }

  Invoke-Checked git branch -M main

  & gh repo view $FullRepository --json name *> $null
  $RepositoryExists = $LASTEXITCODE -eq 0

  if (-not $RepositoryExists) {
    Write-Host "Creating $FullRepository..." -ForegroundColor Cyan
    Invoke-Checked gh repo create $FullRepository --public --description "An unofficial warm editorial Obsidian theme inspired by Claude's visual language." --source . --remote origin --push
  } else {
    & git remote get-url origin *> $null
    if ($LASTEXITCODE -ne 0) {
      Invoke-Checked git remote add origin "https://github.com/$FullRepository.git"
    } else {
      Invoke-Checked git remote set-url origin "https://github.com/$FullRepository.git"
    }
    Invoke-Checked git push --set-upstream origin main
  }

  & gh release view $Version --repo $FullRepository *> $null
  if ($LASTEXITCODE -ne 0) {
    Write-Host "Creating GitHub release $Version..." -ForegroundColor Cyan
    Invoke-Checked gh release create $Version manifest.json theme.css --repo $FullRepository --title $Version --notes "Claude Paper $Version. Includes matched light and dark modes, Source Han Serif SC Variable typography, SF Mono code, and complete Obsidian styling."
  } else {
    Write-Host "Release $Version already exists. Refreshing its required files..." -ForegroundColor DarkGray
    Invoke-Checked gh release upload $Version manifest.json theme.css --repo $FullRepository --clobber
  }
}
finally {
  Pop-Location
}

& gh repo view $ReviewFork --json name *> $null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Creating the Obsidian releases fork..." -ForegroundColor Cyan
  Invoke-Checked gh repo fork $ReviewRepository "--clone=false"

  $forkReady = $false
  for ($attempt = 0; $attempt -lt 15; $attempt++) {
    Start-Sleep -Seconds 2
    & gh repo view $ReviewFork --json name *> $null
    if ($LASTEXITCODE -eq 0) {
      $forkReady = $true
      break
    }
  }
  if (-not $forkReady) {
    throw "The GitHub fork is still being prepared. Wait one minute and run the script again."
  }
}

$ReviewFolder = Join-Path ([System.IO.Path]::GetTempPath()) "claude-paper-obsidian-review"
$AlreadyPublished = $false
if (Test-Path -LiteralPath $ReviewFolder) {
  Remove-Item -LiteralPath $ReviewFolder -Recurse -Force
}

try {
  Invoke-Checked git clone --depth 1 "https://github.com/$ReviewFork.git" $ReviewFolder
  Push-Location $ReviewFolder
  try {
    Invoke-Checked git remote add upstream "https://github.com/$ReviewRepository.git"
    Invoke-Checked git fetch upstream master --depth 1
    Invoke-Checked git checkout -B $ReviewBranch upstream/master
    Invoke-Checked git config user.name $Owner
    Invoke-Checked git config user.email "$Owner@users.noreply.github.com"

    $DirectoryFile = Join-Path $ReviewFolder "community-css-themes.json"
    $DirectoryData = Get-Content -LiteralPath $DirectoryFile -Raw | ConvertFrom-Json
    $ExistingEntry = $DirectoryData | Where-Object {
      $_.name -eq $ThemeName -or $_.repo -eq $FullRepository
    } | Select-Object -First 1

    if (-not $ExistingEntry) {
      $Content = Get-Content -LiteralPath $DirectoryFile -Raw
      $Trimmed = $Content.TrimEnd()
      if (-not $Trimmed.EndsWith("]")) {
        throw "community-css-themes.json does not end with a JSON array."
      }

      $BeforeClosingBracket = $Trimmed.Substring(0, $Trimmed.Length - 1).TrimEnd()
      $Entry = @"
  {
    "name": "$ThemeName",
    "author": "$Owner",
    "repo": "$FullRepository",
    "screenshot": "screenshot.png",
    "modes": ["dark", "light"]
  }
"@

      if ($BeforeClosingBracket.EndsWith("[")) {
        $Updated = "$BeforeClosingBracket`r`n$Entry`r`n]`r`n"
      } else {
        $Updated = "$BeforeClosingBracket,`r`n$Entry`r`n]`r`n"
      }

      $Utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
      [System.IO.File]::WriteAllText($DirectoryFile, $Updated, $Utf8WithoutBom)
      Invoke-Checked git add community-css-themes.json
      Invoke-Checked git commit -m "Add theme: $ThemeName"
    } else {
      $AlreadyPublished = $true
      Write-Host "The community directory entry already exists." -ForegroundColor DarkGray
    }

    if (-not $AlreadyPublished) {
      Invoke-Checked git push --force "https://github.com/$ReviewFork.git" "$ReviewBranch`:$ReviewBranch"
    }
  }
  finally {
    Pop-Location
  }

  if ($AlreadyPublished) {
    Write-Host "" 
    Write-Host "Claude Paper is already present in the Obsidian community directory." -ForegroundColor Green
    Write-Host "Theme repository: https://github.com/$FullRepository"
    return
  }

  $Head = "${Owner}:$ReviewBranch"
  $PullRequestUrl = ((& gh pr list --repo $ReviewRepository --head $Head --state open --json url --jq ".[0].url") | Out-String).Trim()

  if (-not $PullRequestUrl) {
    $PullRequestBody = @'
# I am submitting a new Community Theme

## Repo URL

Link to my theme: __REPOSITORY_URL__

## Theme checklist

- [x] My repo contains all required files:
  - `manifest.json`
  - `theme.css`
  - `screenshot.png` at 512 by 288 pixels
- [x] I have indicated that both dark and light modes are compatible.
- [x] I have read the developer policies and assessed the theme's adherence.
- [x] I have read the theme guidelines and self-reviewed the theme.
- [x] I have added an MIT license in `LICENSE`.
- [x] The CSS is original to this project and does not copy code from another theme.

Claude Paper is an unofficial community project and includes a clear non-affiliation disclaimer. It does not bundle Anthropic assets or commercial fonts.
'@
    $PullRequestBody = $PullRequestBody.Replace("__REPOSITORY_URL__", "https://github.com/$FullRepository")

    Write-Host "Opening the Obsidian community review request..." -ForegroundColor Cyan
    $PullRequestUrl = ((& gh pr create --repo $ReviewRepository --base master --head $Head --title "Add theme: $ThemeName" --body $PullRequestBody) | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or -not $PullRequestUrl) {
      throw "GitHub could not create the Obsidian review pull request."
    }
  }

  Write-Host "" 
  Write-Host "Published successfully." -ForegroundColor Green
  Write-Host "Theme repository: https://github.com/$FullRepository"
  Write-Host "Obsidian review: $PullRequestUrl"
  Start-Process $PullRequestUrl
}
finally {
  if (Test-Path -LiteralPath $ReviewFolder) {
    Remove-Item -LiteralPath $ReviewFolder -Recurse -Force
  }
}
