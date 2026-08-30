param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$FlutterArgs
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path "secrets.json")) {
    Write-Host "ERROR: secrets.json not found." -ForegroundColor Red
    Write-Host "Copy secrets.json.example to secrets.json and add your Google Maps API key." -ForegroundColor Yellow
    exit 1
}

$flutter = if (Get-Command fvm -ErrorAction SilentlyContinue) { "fvm flutter" } else { "flutter" }

if ($FlutterArgs.Count -gt 0) {
    Invoke-Expression "$flutter run -d chrome --dart-define-from-file=secrets.json $($FlutterArgs -join ' ')"
} else {
    Invoke-Expression "$flutter run -d chrome --dart-define-from-file=secrets.json"
}

exit $LASTEXITCODE
