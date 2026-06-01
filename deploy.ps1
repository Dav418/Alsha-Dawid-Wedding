$ErrorActionPreference = "Stop"

$pagesBranch = "main"
$customDomain = "alisha-dawid-wedding.vip"
$siteUrl = "https://$customDomain/"

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

function Convert-ToHtmlText {
    param (
        [string]$Value
    )

    return [System.Net.WebUtility]::HtmlEncode($Value)
}

function Get-AppTitle {
    $contentPath = "assets\content\wedding_content.json"

    if (-not (Test-Path $contentPath)) {
        Write-Host ""
        Write-Host "ERROR: $contentPath not found." -ForegroundColor Red
        exit 1
    }

    $content = Get-Content $contentPath -Raw | ConvertFrom-Json

    $partner1First = $content.couple.partner1Name.Split(" ")[0]
    $partner2First = $content.couple.partner2Name.Split(" ")[0]

    return "$partner1First & $partner2First Wedding"
}

function Stop-FlutterProcessesForThisRepo {
    $repoPath = (Get-Location).Path

    Write-Host ""
    Write-Host "==> Checking for running Flutter/Dart processes using this repo" -ForegroundColor Cyan

    $processes = Get-CimInstance Win32_Process |
        Where-Object {
            ($_.Name -eq "dart.exe" -or $_.Name -eq "flutter.exe") -and
            $_.CommandLine -like "*$repoPath*"
        }

    if (-not $processes) {
        Write-Host "No running Flutter/Dart processes found for this repo." -ForegroundColor Green
        return
    }

    Write-Host ""
    Write-Host "Found running Flutter/Dart process(es) for this repo. Stopping them..." -ForegroundColor Yellow

    foreach ($process in $processes) {
        Write-Host "Stopping PID $($process.ProcessId): $($process.Name)" -ForegroundColor Yellow
        Stop-Process -Id $process.ProcessId -Force -ErrorAction SilentlyContinue
    }

    Start-Sleep -Seconds 2
}

function Remove-PathStrict {
    param (
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        return
    }

    Remove-Item $Path -Recurse -Force

    if (Test-Path $Path) {
        Write-Host ""
        Write-Host "ERROR: Failed to remove $Path" -ForegroundColor Red
        Write-Host "Something is probably still locking it. Stop debug mode and try again." -ForegroundColor Yellow
        exit 1
    }
}

function Regenerate-WebFolder {
    $tempPath = Join-Path $env:TEMP "flutter_web_template_$([guid]::NewGuid().ToString("N"))"

    try {
        Run-Command `
            "Generating fresh Flutter web folder in temp directory" `
            "flutter create --platforms=web --project-name alisha_dawid_wedding_website --no-pub `"$tempPath`""

        if (-not (Test-Path "$tempPath\web\index.html")) {
            Write-Host ""
            Write-Host "ERROR: temporary web\index.html was not generated." -ForegroundColor Red
            exit 1
        }

        Write-Host ""
        Write-Host "==> Replacing repo web folder with regenerated web folder" -ForegroundColor Cyan

        Remove-PathStrict "web"

        New-Item -ItemType Directory "web" | Out-Null
        Copy-Item -Path "$tempPath\web\*" -Destination "web" -Recurse -Force
    }
    finally {
        if (Test-Path $tempPath) {
            Remove-Item $tempPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

function Update-WebIndexMetadata {
    param (
        [string]$AppTitle
    )

    $indexPath = "web\index.html"
    $htmlTitle = Convert-ToHtmlText $AppTitle

    if (-not (Test-Path $indexPath)) {
        Write-Host ""
        Write-Host "ERROR: web\index.html was not generated." -ForegroundColor Red
        exit 1
    }

    $indexHtml = Get-Content $indexPath -Raw

    if ($indexHtml -match '<meta name="description" content=".*?">') {
        $indexHtml = $indexHtml -replace '<meta name="description" content=".*?">', "<meta name=`"description`" content=`"$htmlTitle`">"
    }

    if ($indexHtml -match "<title>.*?</title>") {
        $indexHtml = $indexHtml -replace "<title>.*?</title>", "<title>$htmlTitle</title>"
    } else {
        $indexHtml = $indexHtml -replace "</head>", "  <title>$htmlTitle</title>`r`n</head>"
    }

    Set-Content -Path $indexPath -Value $indexHtml -NoNewline
}

function Update-WebManifestMetadata {
    param (
        [string]$AppTitle
    )

    $manifestPath = "web\manifest.json"

    if (-not (Test-Path $manifestPath)) {
        Write-Host ""
        Write-Host "WARNING: web\manifest.json was not generated." -ForegroundColor Yellow
        return
    }

    $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

    $manifest.name = $AppTitle
    $manifest.short_name = "Wedding"

    $manifest |
        ConvertTo-Json -Depth 20 |
        Set-Content -Path $manifestPath -NoNewline
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

$appTitle = Get-AppTitle
$htmlTitle = Convert-ToHtmlText $appTitle

Write-Host ""
Write-Host "Using app title: $appTitle" -ForegroundColor Green

Stop-FlutterProcessesForThisRepo

Run-Command "Cleaning Flutter project" "flutter clean"

Write-Host ""
Write-Host "==> Making sure old generated folders are removed" -ForegroundColor Cyan

Remove-PathStrict "build"
Remove-PathStrict ".dart_tool"
Remove-PathStrict ".flutter-plugins-dependencies"

Regenerate-WebFolder

Write-Host ""
Write-Host "==> Updating regenerated web metadata" -ForegroundColor Cyan

Update-WebIndexMetadata $appTitle
Update-WebManifestMetadata $appTitle

Run-Command "Getting Flutter packages" "flutter pub get"

Run-Command "Running code generation" "dart run build_runner build --delete-conflicting-outputs"

Run-Command "Building Flutter web for custom domain" "flutter build web --release --base-href '/'"

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

$builtIndexHtml = Get-Content "build\web\index.html" -Raw

if ($builtIndexHtml -notlike "*<title>$htmlTitle</title>*") {
    Write-Host ""
    Write-Host "ERROR: build\web\index.html has the wrong browser tab title." -ForegroundColor Red
    Write-Host "Expected:" -ForegroundColor Yellow
    Write-Host "<title>$htmlTitle</title>" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "==> Replacing docs folder" -ForegroundColor Cyan

Remove-PathStrict "docs"

New-Item -ItemType Directory "docs" | Out-Null

Write-Host ""
Write-Host "==> Copying build\web into docs" -ForegroundColor Cyan

Copy-Item -Path "build\web\*" -Destination "docs" -Recurse -Force

Write-Host ""
Write-Host "==> Adding .nojekyll" -ForegroundColor Cyan

New-Item -ItemType File "docs\.nojekyll" -Force | Out-Null

Write-Host ""
Write-Host "==> Adding CNAME for custom domain" -ForegroundColor Cyan

Set-Content -Path "docs\CNAME" -Value $customDomain -NoNewline

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

if (-not (Test-Path "docs\CNAME")) {
    Write-Host ""
    Write-Host "ERROR: docs\CNAME is missing after copy." -ForegroundColor Red
    exit 1
}

$docsIndexHtml = Get-Content "docs\index.html" -Raw

if ($docsIndexHtml -notlike "*<title>$htmlTitle</title>*") {
    Write-Host ""
    Write-Host "ERROR: docs\index.html has the wrong browser tab title after copy." -ForegroundColor Red
    Write-Host "Expected:" -ForegroundColor Yellow
    Write-Host "<title>$htmlTitle</title>" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "==> Adding web and docs folders to Git" -ForegroundColor Cyan

git add -A web docs

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git add -A web docs failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==> Force-adding ignored Flutter web files" -ForegroundColor Cyan

git add -f web docs

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: git add -f web docs failed." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "==> Git status for web and docs" -ForegroundColor Cyan

git status --short web docs

$changes = git status --porcelain web docs

if ([string]::IsNullOrWhiteSpace($changes)) {
    Write-Host ""
    Write-Host "No web/docs changes to deploy." -ForegroundColor Yellow
    Write-Host "Your site may already be up to date." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "==> Committing deploy files" -ForegroundColor Cyan

git commit -m "DEPLOY regenerated Flutter web app for custom domain"

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
Write-Host "Open:" -ForegroundColor Green
Write-Host $siteUrl -ForegroundColor White
Write-Host ""
Write-Host "Hard refresh with Ctrl + F5 if your browser cached the old app." -ForegroundColor Yellow