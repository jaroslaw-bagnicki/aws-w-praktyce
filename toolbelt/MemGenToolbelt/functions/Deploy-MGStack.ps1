Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation
. Join-Path $PSScriptRoot ./MGContext
. Join-Path $PSScriptRoot ./Test-AwsRegionSet

function Deploy-MGStack {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string] $Stack,

        [Parameter(Mandatory, Position=1)]
        [string] $Template,

        [Parameter(Mandatory, Position=2)]
        [string] $Params
    )

    try {
        Test-AwsRegionSet
        Test-MGContext
        $context = Get-MGContext

        $stage = $context.Stage
        $project = $context.Project
        $component = $context.Component
        
        $stackFullname = "$project-$component-$Stack-$stage"

        $templatePath = Join-Path $PWD "$project/$component/templates/$Template.yaml"
        if (! (Test-Path $templatePath)) {
            throw "File with template ($templatePath) not found!"
        }
    
        $templateBody = Get-Content $templatePath -Raw
        Write-Host "Template loaded from: $templatePath" -ForegroundColor Gray
        
        $parameterPath = Join-Path $PWD "$project/$component/parameters/$Params-$stage.json"
        if (! (Test-Path $parameterPath)) {
            throw "File with parameters ($parameterPath) not found!"
        }
    
        $parameters = Get-Content $parameterPath | ConvertFrom-Json
        Write-Host "Parameters loaded from: $parameterPath ..." -ForegroundColor Gray
    
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
    
        $stackId = New-CFNStack `
            -StackName $stackFullname `
            -TemplateBody $templateBody `
            -Parameter $parameters `
            -Tag $tags

        $stackInfo = Get-CFNStack -StackName $stackId
        $stackName = $stackInfo.StackName
        $status = $stackInfo.StackStatus

        while ($status.Value -like '*IN_PROGRESS') {
            Start-Sleep -Seconds 1
            $currStatus = Get-CFNStack -StackName $stackId | Select-Object -ExpandProperty StackStatus
            if ($currStatus -ne $status) {
                $status = $currStatus
                Write-Host $status;
            }
        } 

        if ($status.Value -like '*FAILD') {
            throw 'Deploying stack failed'
        }
    
        Write-Host "Stack [$stackName] created success." -ForegroundColor Green
        return $stackName

    } catch {
        Write-Error $_.Exception.Message -ErrorAction Stop
    }
}
