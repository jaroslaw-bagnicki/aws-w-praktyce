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

$stackFullName = "$projectName-$componentName-$stackName-$stage"

Write-Host "`nCurrent stack name: $stackFullName" -ForegroundColor Magenta

# DEPLOY STACK

Write-Host "`nDeploying stack: $stackFullName ..." -ForegroundColor Green
Deploy-CFNTemplate `
    -Region $regions `
    -Project $projectName  `
    -Component $componentName `
    -Stack $stackName `
    -Stage $stage `
    -Template $templateFilename `
    -Parameters $parametersFilename `
| Write-Output

# GET STACK OUTPUT

Write-Host "`nGetting stack outputs ..." -ForegroundColor Green
Get-CFNStack -StackName $stackFullName `
| Select-Object -ExpandProperty Outputs -OutVariable stackOutputs

ConvertTo-Json $stackOutputs | Out-File "./stack-outputs.json"
Write-Output "`nStack outputs were exported to 'stack-outputs.json' file."

# GET STACK EVENTS

Write-Host "`nGetting stack events ..." -ForegroundColor Green
$stackEvents = Get-CFNStackEvent -StackName $stackFullName
ConvertTo-Json $stackEvents | Out-File "./stack-events.json"
Write-Output "Stack events were exported to 'stack-events.json' file."
