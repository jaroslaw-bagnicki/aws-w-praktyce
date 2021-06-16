Import-Module AWS.Tools.Common
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

$stackOutputs = Get-CFNStackOutput `
    -Project $projectName  `
    -Component $componentName `
    -Stack $stackName `
    -Stage $stage

Write-Output $stackOutputs