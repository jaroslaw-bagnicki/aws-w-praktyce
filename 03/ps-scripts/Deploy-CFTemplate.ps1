param(
    [string] $Project,
    [string] $Stage,
    [string] $Region,
    [string] $Component,
    [string] $Stack,
    [string] $Template,
    [string] $Params
)

$TemplatePath = "$Project/$Component/templates/$Template.yaml"
$ParamsPath = "$Project/$Component/templates/$Params-$Stage.json"
$StackName = "$Project-$Component-$Stack-$Stage"

$ParsedParams = ConvertFrom-Json $ParamsPath

$Result = aws cloudformation deploy `
    --template-file $TemplatePath`
    --stack-name $StackName `
    --no-fail-on-empty-changeset `
    --parameter-overrides $ParsedParams `
    --region $Region `
    --tags Project=$Project Stage=$Stage Component=$Component

Write-Output $Result
