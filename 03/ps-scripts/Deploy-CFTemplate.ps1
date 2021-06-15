param(
    [string] $Project,
    [string] $Stage,
    [string] $Region,
    [string] $Component,
    [string] $Stack,
    [string] $Template,
    [string] $Parameters
)

$templatePath = Resolve-Path "$Project/$Component/templates/$Template.yaml"
if (!(Test-Path $templatePath)) {
    Throw "Template file not exist!"
}

$parametersPath = Resolve-Path "$Project/$Component/parameters/$Parameters-$Stage.json"
if (!(Test-Path $parametersPath)) {
    Throw "Parameters file not exist!"
}

$stackName = "$Project-$Component-$Stack-$Stage"

$parameterOverridesArray = Get-Content $parametersPath | ConvertFrom-Json
$parameterOverridesHastable = @{}
$parameterOverridesArray | ForEach-Object { $parameterOverridesHastable[$_.ParameterKey] = $_.ParameterValue }

$temp = @{
    Project = 'website'
    Stage = 'dev'
    Component = 'single-tempalate'
}

$result = aws cloudformation deploy `
    --template-file $templatePath.Path`
    --stack-name $stackName `
    --no-fail-on-empty-changeset `
    --parameter-overrides file://$parametersPath `
    --region $Region `
    --tags Project=$Project Stage=$Stage Component=$Component

Write-Output $result
