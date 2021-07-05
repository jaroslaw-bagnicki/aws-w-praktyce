Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation
. ./MGContext

function Deploy-MGStack(
    [string] $Stack,
    [string] $Template,
    [string] $Params
) {
    try {
        Test-MGContext
    } catch {
        Write-Error $_.Exception.Message -ErrorAction Stop
    }

    $stage = $MG_CONTEXT.Stage
    $project = $MG_CONTEXT.Project
    $component = $MG_CONTEXT.Component
    
    $stackFullname = "$project-$component-$Stack-$stage"

    $templatePath = Join-Path $PWD "$project/$component/templates/$Template.yaml"
    if (! (Test-Path $templatePath)) {
        Write-Error 'File with template not found!' -ErrorAction Stop
    }
    
    Write-Host "Loading template from: $templatePath ..." -ForegroundColor Blue
    $templateBody = Get-Content $templatePath -Raw
    
    $parameterPath = Join-Path $PWD "$project/$component/parameters/$Params-$stage.json"
    if (! (Test-Path $parameterPath)) {
        Write-Error 'File with parameters not found!' -ErrorAction Stop
    }
    
    Write-Host "Loading parameterss from: $parameterPath ..." -ForegroundColor Blue
    $parameters = Get-Content $parameterPath | ConvertFrom-Json
    
    $tags = @(
        @{
            Key = 'Project'
            Value = $project
        },
        @{
            Key = 'Component'
            Value = $component
        },
        @{
            Key = 'Stage'
            Value = $stage
        }
    )
    
    Write-Host "Creating [$stackFullname] stack ..." -ForegroundColor Blue
    
    try {
        New-CFNStack `
            -StackName $stackFullname `
            -TemplateBody $templateBody `
            -Parameter $parameters `
            -Tag $tags
    
    } catch {
        Write-Error $_.Exception.Message -ErrorAction Stop
    }
    
    Write-Host "Stack created success." -ForegroundColor Green

}
