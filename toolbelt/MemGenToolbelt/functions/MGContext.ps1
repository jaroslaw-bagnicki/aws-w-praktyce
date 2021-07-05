enum Stage {
    DEV
    PROD
    STAGING
    TEST
 }

class MGContext {
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

function Set-MGContext(
    [string] $Project,
    [string] $Component,
    [Stage] $Stage
) {
    Set-Variable -Name MG_CONTEXT -Value [MGContext]::new($Project, $Component, $Stage)
}

function Get-MGContext() {
    Get-Variable -Name MG_CONTEXT
}

function Test-MGContext() {
    [MGContext]$context = Get-MGContext
    if ($null -eq $context) {
        throw 'MGContext is not set!'
    }

    $missingValues = @()
    if ($null -eq $context.Project) {
        $missingValues += 'Project'
    }
    if ($null -eq $context.Component) {
        $missingValues += 'Component'
    }
    if ($null -eq $context.Stage) {
        $missingValues += 'Stage'
    }

    if ($missingValues.Length -eq 1) {
        throw "$missingValues[0] property is not set!"
    }
    if ($missingValues.Length -gt 1) {
        throw "($missingValues.Join(', ')) are not set!"
    }
}