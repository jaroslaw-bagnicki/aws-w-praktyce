. Join-Path $PSScriptRoot ./DateTimeHelpers

enum Stage {
    dev
    prod
    staging
    test
 }

class Context {
    [string] $Project
    [string] $Component
    [Stage] $Stage

    Context (
        [string] $project,
        [string] $component,
        [Stage] $stage       
    ) {
        $this.Project = $project
        $this.Component = $component
        $this.Stage = $stage
    }
}

Set-Variable -Name MG_CONTEXT -Value $null -Scope Script 

function Set-MGContext {
    param (
        [Parameter(Mandatory, Position=0)]
        [string] $Project,

        [Parameter(Mandatory, Position=1)]
        [string] $Component,

        [Parameter(Mandatory, Position=2)]
        [string] $Stage           
    )

    Set-Variable -Name MG_CONTEXT -Value ([Context]::new($Project, $Component, $Stage)) -Scope Script
    Write-Verbose "[$(Get-Time)] Context was set to Project=$($MG_CONTEXT.Project), Component=$($MG_CONTEXT.Component), Stage=$($MG_CONTEXT.Stage)"
    Get-MGContext
}

function Get-MGContext {
    $ctx = Get-Variable -Name MG_CONTEXT -ValueOnly
    if ($null -eq $ctx) {
        Write-Warning 'Context is not set!'
    } else {
        return [Context]$ctx
    }
}

function Test-MGContext {
    $ctx = Get-Variable -Name MG_CONTEXT -ValueOnly
    if ($null -eq $ctx) {
        throw "Context is not set! Run 'Set-MGContext' first."
    }
}