# Scipt install MemGenToolbet from local source
param(
    [Parameter()]
    [Switch]
    $ViaSymLink
)

$moduleName = 'MemGenToolbelt'
$sourceCodePath = Join-Path $PWD $moduleName
$pathDelimeter = $IsWindows ? ';' : ':'

$userModulesPath = $env:PSModulePath.Split($pathDelimeter) | Where-Object { $_ -like "$HOME*" } | Select-Object -First 1

$memGenModulePath = Join-Path $userModulesPath $moduleName 
if (Test-Path $memGenModulePath) {
    Write-Warning "$memGenModulePath folder exits!"
    Remove-Item $memGenModulePath -Recurse
    Write-Host
}

if ($ViaSymLink -eq $true) {
    $path = Join-Path $userModulesPath $moduleName
    New-Item -ItemType SymbolicLink -Path $path -Target $sourceCodePath
    Write-Host "$moduleName symlink creation success!" -ForegroundColor Green
} else {
    Copy-Item -Path $sourceCodePath -Destination $userModulesPath -Recurse
    Write-Host "$moduleName installation success!" -ForegroundColor Green
}

