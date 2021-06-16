Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation
. $PSScriptRoot/Deploy-CFNTemplate.ps1
. $PSScriptRoot/Get-CFNStackOutput.ps1

$regions = Get-DefaultAWSRegion
$projectName = 'website'
$componentName = 'single-template'
$stackName = 'website'
$stage = 'dev'
$templateFilename = 'website'
$parametersFilename = 'website'


$deployResult = Deploy-CFNTemplate `
    -Region $regions `
    -Project $projectName  `
    -Component $componentName `
    -Stack $stackName `
    -Stage $stage `
    -Template $templateFilename `
    -Parameters $parametersFilename

Write-Output $deployResult

$stackFullName = "$projectName-$componentName-$stackName-$stage"

$stackOutputs = Get-CFNStack -StackName $stackFullName `
| Select-Object -ExpandProperty Outputs

Write-Output $stackOutputs
ConvertTo-Json $stackOutputs >> "./stack-outputs.json"

$stackEvents = Get-CFNStackEvent -StackName $stackFullName
Write-Output $stackEvents
ConvertTo-Json $stackEvents >> "./stack-events.json"
Write-Output "Stack events were exported to 'events.log' file."
