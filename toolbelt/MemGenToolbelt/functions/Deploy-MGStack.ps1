Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation
. Join-Path $PSScriptRoot ./MGContext
. Join-Path $PSScriptRoot ./Test-AwsRegionSet
. Join-Path $PSScriptRoot ./DateTimeHelpers

function Deploy-MGStack {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string] $Stack,

        [Parameter(Mandatory, Position=1)]
        [string] $Template,

        [Parameter(Mandatory, Position=2)]
        [string] $Params,

        [Parameter(Position=3)]
        [string[]] $Capability,

        [Parameter()]
        [switch] $Update,

        [Parameter()]
        [switch] $Wait
    )

    try {
        Test-AwsRegionSet
        Test-MGContext
        $context = Get-MGContext

        $stage = $context.Stage
        $project = $context.Project
        $component = $context.Component
        
        $stackFullname = "$project-$component-$Stack-$stage"

        Write-Host "[$(Get-Time)] $($Update ? 'Updating' : 'Creating') [$stackFullname] stack ..." -ForegroundColor Blue

        $templatePath = Join-Path $PWD "$project/$component/templates/$Template.yaml"
        if (! (Test-Path $templatePath)) {
            throw "File with template ($templatePath) not found!"
        }
    
        $templateBody = Get-Content $templatePath -Raw
        $templateRelativePath = Resolve-Path -Path  $templatePath -Relative
        Write-Verbose "[$(Get-Time)] Template loaded from: $templateRelativePath"
        
        $parametersPath = Join-Path $PWD "$project/$component/parameters/$Params-$stage.json"
        if (! (Test-Path $parametersPath)) {
            throw "File with parameters ($parametersPath) not found!"
        }
    
        $parameters = Get-Content $parametersPath | ConvertFrom-Json
        $parametersRelativePath = Resolve-Path -Path  $parametersPath -Relative
        Write-Verbose "[$(Get-Time)] Parameters loaded from: $parametersRelativePath"
    
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

        $parameters = @{
            StackName = $stackFullname
            TemplateBody = $templateBody
            Parameter = $parameters
            Tag = $tags         
        }

        if ($Capability) {
            $parameters.Capability = $Capability 
        }

        if ($Update) {
            $stackId = Update-CFNStack @parameters
        } else {
            $stackId = New-CFNStack @parameters
        }

        $stackInfo = Get-CFNStack -StackName $stackId
        $stackName = $stackInfo.StackName
        $status = $stackInfo.StackStatus

        $cfnAction = $Update ? 'update' : 'create'
        if ($Wait) {
            while ($status.Value -like '*IN_PROGRESS') {
                Start-Sleep -Seconds 1
                $status = Get-CFNStack -StackName $stackId | Select-Object -ExpandProperty StackStatus
            } 
    
            if ($status.Value -like '*FAILD') {
                throw 'Deploying stack failed'
            }

            Write-Host "[$(Get-Time)] Stack [$stackName] with all resources $cfnAction success." -ForegroundColor Green
            return $stackName
        }

        Write-Host "[$(Get-Time)] Stack [$stackName] $cfnAction success. Resources creation in progress." -ForegroundColor Green
        return $stackName

    } catch {
        Write-Error $_.Exception.Message -ErrorAction Stop
    }
}
