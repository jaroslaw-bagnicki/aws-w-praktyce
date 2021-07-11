. Join-Path $PSScriptRoot ./MGContext

function Get-MGStackOutputsPath {
    
    [CmdletBinding()]
    param(
        [switch]
        $CreateIfNotExists
    )

    Test-MGContext
    $ctx = Get-MGContext
    $path = Join-Path $PWD $ctx.Project $ctx.Component 'outputs'
    
    if (Test-Path $path) {
        return $path
    }
    elseif ($CreateIfNotExists) {
        New-Item -ItemType Directory -Force -Path $path
        return $path
    }
    throw "$path path not exist! Try use -CreateIfNotExists switch."
}