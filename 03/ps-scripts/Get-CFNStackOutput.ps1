Import-Module AWS.Tools.CloudFormation
function Get-CFNStackOutput(
    [string] $Project,
    [string] $Component,
    [string] $Stack,
    [string] $Stage
)
{
    $stackName = "$Project-$Component-$Stack-$Stage"

    Get-CFNStack -StackName $stackName `
    | Select-Object -ExpandProperty Outputs
}