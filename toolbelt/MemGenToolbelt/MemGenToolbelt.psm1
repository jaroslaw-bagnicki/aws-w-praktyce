$functionsPath = Join-Path $PSScriptRoot 'functions'

$functions = Get-ChildItem $functionsPath -Name

foreach ($function in $functions) {
    . ($functionsPath + $function)
}