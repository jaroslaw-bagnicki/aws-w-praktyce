Import-Module AWS.Tools.Common
. $PSScriptRoot/Deploy-CFNTemplate.ps1

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