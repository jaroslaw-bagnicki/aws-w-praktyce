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

ConvertTo-Json $stackOutputs | Out-File "./stack-outputs.json"
Write-Output "Stack outputs were exported to 'stack-outputs.json' file."

$stackEvents = Get-CFNStackEvent -StackName $stackFullName
ConvertTo-Json $stackEvents | Out-File "./stack-events.json"
Write-Output "Stack outputs were exported to 'stack-events.json' file."
