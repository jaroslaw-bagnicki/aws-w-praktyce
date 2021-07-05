# Scipt install MemGenToolbet from local source

$moduleName = 'MemGenToolbelt'

$delimeter = $IsWindows ? ';' : ':'
$userModulesPath = $env:PSModulePath.Split($delimeter) | Where-Object { $_ -like "$HOME*" } | Select-Object -First 1

$memGenModulePath = Join-Path $userModulesPath $moduleName 
if (Test-Path $memGenModulePath) {
    Write-Warning "$memGenModulePath folder exits!"
    Remove-Item $memGenModulePath -Recurse
    Write-Host
}

Copy-Item -Path ./MemGenToolbelt -Destination $userModulesPath -Recurse
Write-Host "$moduleName installation success!" -ForegroundColor Green
