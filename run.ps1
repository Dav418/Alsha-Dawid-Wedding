param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$FlutterArgs
)

$ErrorActionPreference = "Stop"

$python = if (Get-Command python -ErrorAction SilentlyContinue) {
    "python"
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    "py -3"
} else {
    "python3"
}

Invoke-Expression "$python scripts/merge_dart_defines.py"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$flutter = if (Get-Command fvm -ErrorAction SilentlyContinue) { "fvm flutter" } else { "flutter" }

if ($FlutterArgs.Count -gt 0) {
    Invoke-Expression "$flutter run -d chrome --dart-define-from-file=dart_defines.json $($FlutterArgs -join ' ')"
} else {
    Invoke-Expression "$flutter run -d chrome --dart-define-from-file=dart_defines.json"
}

exit $LASTEXITCODE
