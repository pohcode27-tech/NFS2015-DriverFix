Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NFS 2015 Driver Check Bypass Patch" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Please enter the full path to NFS16.exe:" -ForegroundColor Yellow
Write-Host "(e.g. D:\Games\Need for Speed\NFS16.exe)" -ForegroundColor Gray
$file = Read-Host "Path"
$file = $file.Trim('"', "'", " ")

if (-not (Test-Path $file)) {
    Write-Host "File not found: $file" -ForegroundColor Red
    Write-Host "Press Enter to exit..."
    Read-Host
    exit
}

if ((Split-Path $file -Leaf) -ne "NFS16.exe") {
    Write-Host "Warning: The file is not named NFS16.exe!" -ForegroundColor Yellow
    Write-Host "Continue anyway? (y/n)" -ForegroundColor Yellow
    $confirm = Read-Host
    if ($confirm -ne "y") { exit }
}

$backup = "$file.backup"

if (-not (Test-Path $backup)) {
    Copy-Item $file $backup
    Write-Host "Backup created: $backup" -ForegroundColor Green
} else {
    Write-Host "Backup already exists: $backup" -ForegroundColor Gray
}

$bytes = [System.IO.File]::ReadAllBytes($file)

# Original: "13.251" -> Patch to: "0.0.00"
$patch = [System.Text.Encoding]::ASCII.GetBytes("0.0.00")
$offset = 1783120  # 0x1B3550

$currentValue = [System.Text.Encoding]::ASCII.GetString($bytes, $offset, 6)
if ($currentValue -eq "0.0.00") {
    Write-Host "Already patched!" -ForegroundColor Yellow
    Write-Host "Press Enter to exit..."
    Read-Host
    exit
}

if ($currentValue -ne "13.251") {
    Write-Host "Unexpected value at offset: $currentValue" -ForegroundColor Red
    Write-Host "This version of the EXE is not supported." -ForegroundColor Red
    Write-Host "Press Enter to exit..."
    Read-Host
    exit
}

for ($i = 0; $i -lt $patch.Length; $i++) {
    $bytes[$offset + $i] = $patch[$i]
}

[System.IO.File]::WriteAllBytes($file, $bytes)
Write-Host ""
Write-Host "Patch successfully applied!" -ForegroundColor Green
Write-Host "Driver check changed to version 0.0.00." -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Enter to exit..."
Read-Host