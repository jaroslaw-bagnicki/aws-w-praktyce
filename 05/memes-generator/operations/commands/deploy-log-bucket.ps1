Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation

Set-DefaultAwsRegion 'eu-east-1'

$stage = "dev"
$project = "memes-generator"
$component = "operations"

$stack = "log-bucket"

$stackName = "$project-$component-$stack-$stage"

$templateFilename = "log-bucket"
$parametersFilename = "log-bucket"

$templatePath = Join-Path $PWD "$project/$component/templates/$templateFilename.yaml"
if (! (Test-Path $templatePath)) {
    throw 'Invalid template path or file not exist!'
}
$templateBody = Get-Content $templatePath -Raw

$parameterPath = Join-Path $PWD "$project/$component/parameters/$parametersFilename-$stage.json"
if (! (Test-Path $parameterPath)) {
    throw 'Invalid parameter path or file not exist!'
}
$parameters = Get-Content $parameterPath | ConvertFrom-Json

$tags = @(
    @{ Key = 'Project'; Value = $project },
    @{ Key = 'Component'; Value = $component },
    @{ Key = 'Stage'; Value = $stage }
)

New-CFNStack `
    -TemplateBody $templateBody `
    -StackName $stackName `
    -Parameter $parameters `
    -Tag $tags
