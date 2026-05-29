$ErrorActionPreference = "Stop"

$repoName = "Alsha-Dawid-Wedding"
$pagesBranch = "main"
$siteUrl = "https://dav418.github.io/$repoName/"

function Run-Command {
    param (
        [string]$Message,
        [string]$Command
    )

    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
    Write-Host $Command -ForegroundColor DarkGray

    Invoke-Expression $Command

    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "FAILED: $Message" -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

Write-Host ""
Write-Host "Starting Flutter web deploy..." -ForegroundColor Green

if (-not (Test-Path "pubspec.yaml")) {
    Write-Host ""
    Write-Host "ERROR: pubspec.yaml not found." -ForegroundColor Red
    Write-Host "Run this script from the root of your Flutter project." -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path ".git")) {
    Write-Host ""
    Write-Host "ERROR: .git folder not found." -ForegroundColor Red
    Write-Host "Run this script from the root of your Git repo." -ForegroundColor Yellow
    exit 1
}

$currentBranch = git branch --show-current

if ($currentBranch -ne $pagesBranch) {
    Write-Host ""
    Write-Host "ERROR: You are on branch '$currentBranch'." -ForegroundColor Red
    Write-Host "GitHub Pages is using branch '$pagesBranch'." -ForegroundColor Yellow
    Write-Host "Switch branch first with:" -ForegroundColor Yellow
    Write-Host "git checkout $pagesBranch" -ForegroundColor White
    exit 1
}

Run-Command "Cleaning Flutter project" "flutter clean"

Run-Command "Getting Flutter packages" "flutter pub get"

Run-Command "Building Flutter web for GitHub Pages" "flutter build web --release --base-href '/$repoName/'"

if (-not (Test-Path "build\web\index.html")) {
    Write-Host ""
    Write-Host "ERROR: build\web\index.html was not created." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "build\web\main.dart.js")) {
    Write-Host ""
    Write-Host "ERROR: build\web\main.dart.js was not created." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==> Replacing docs folder" -ForegroundColor Cyan

if (Test-Path "docs") {
    Remove-Item "docs" -Recurse -Force
}

New-Item -ItemType Directory "docs" | Out-Null

Write-Host ""
Write-Host "==> Copying build\web into docs" -ForegroundColor Cyan

Copy-Item -Path "build\web\*" -Destination "docs" -Recurse -Force

Write-Host ""
Write-Host "==> Adding .nojekyll" -ForegroundColor Cyan

New-Item -ItemType File "docs\.nojekyll" -Force | Out-Null

if (-not (Test-Path "docs\index.html")) {
    Write-Host ""
    Write-Host "ERROR: docs\index.html is missing after copy." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "docs\main.dart.js")) {
    Write-Host ""
    Write-Host "ERROR: docs\main.dart.js is missing after copy." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==> Adding docs folder to Git" -ForegroundColor Cyan

git add -A docs

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git add -A docs failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==> Force-adding ignored Flutter web files" -ForegroundColor Cyan

git add -f docs

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git add -f docs failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==> Git status for docs" -ForegroundColor Cyan

git status --short docs

$changes = git status --porcelain docs

if ([string]::IsNullOrWhiteSpace($changes)) {
    Write-Host ""
    Write-Host "No docs changes to deploy." -ForegroundColor Yellow
    Write-Host "Your site may already be up to date." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "==> Committing deploy files" -ForegroundColor Cyan

git commit -m "DEPLOY updated Flutter web app"

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git commit failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==> Pushing to GitHub" -ForegroundColor Cyan

git push origin $pagesBranch

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git push failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "Deploy pushed successfully." -ForegroundColor Green
Write-Host "Wait 1-2 minutes, then open:" -ForegroundColor Green
Write-Host $siteUrl -ForegroundColor White
Write-Host ""
Write-Host "Hard refresh with Ctrl + F5." -ForegroundColor Yellow