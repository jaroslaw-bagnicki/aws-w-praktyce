Function Deploy-CFTemplate(
    [string] $Project,
    [string] $Stage,
    [string] $Region,
    [string] $Component,
    [string] $Stack,
    [string] $Template,
    [string] $Parameters
)
{
    $templatePath = Join-Path $pwd "$Project/$Component/templates/$Template.yaml"
    if (!(Test-Path $templatePath)) {
        Throw "Template file not exist!"
    }
    
    $parametersPath = Join-Path $pwd "$Project/$Component/parameters/$Parameters-$Stage.json"
    if (!(Test-Path $parametersPath)) {
        Throw "Parameters file not exist!"
    }
    
    $stackName = "$Project-$Component-$Stack-$Stage"

    $result = aws cloudformation deploy `
        --template-file $templatePath `
        --stack-name $stackName `
        --no-fail-on-empty-changeset `
        --parameter-overrides file://$parametersPath `
        --region $Region `
        --tags Project=$Project Stage=$Stage Component=$Component | Out-String
    
    Write-Output $result
}
