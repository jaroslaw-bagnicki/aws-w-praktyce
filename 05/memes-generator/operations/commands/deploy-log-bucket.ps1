Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation

Set-DefaultAwsRegion 'eu-central-1'

$stage = "dev"
$project = "memes-generator"
$component = "operations"

$stack = "log-bucket"

$stackName = "$project-$component-$stack-$stage"

$templateFilename = "log-bucket"
$parametersFilename = "log-bucket"

$templatePath = Join-Path $PWD "$project/$component/templates/$templateFilename.yaml"
if (! (Test-Path $templatePath)) {
    Write-Error 'File with template not found!' -ErrorAction Stop
}

Write-Host "Loading template from: $templatePath ..." -ForegroundColor Blue
$templateBody = Get-Content $templatePath -Raw

$parameterPath = Join-Path $PWD "$project/$component/parameters/$parametersFilename-$stage.json"
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

Write-Host "Creating [$stackName] stack ..." -ForegroundColor Blue

try {
    New-CFNStack `
        -StackName $stackName `
        -TemplateBody $templateBody `
        -Parameter $parameters `
        -Tag $tags

} catch {
    Write-Error $_.Exception.Message -ErrorAction Stop
}

Write-Host "Stack created success." -ForegroundColor Green
