$functionsPath = Join-Path $PSScriptRoot 'functions'

$functions = Get-ChildItem $functionsPath -Name

foreach ($function in $functions) {
    . (Join-Path $functionsPath $function)
}

Export-ModuleMember -Function Deploy-MGStack, Get-MGStackOutputs, Get-MGStackOutputsPath
Export-ModuleMember -Function Set-MGContext, Get-MGContext