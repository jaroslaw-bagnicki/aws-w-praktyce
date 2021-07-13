Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.SecretsManager

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# Set context for 'data' component
Set-MGContext -Project 'memes-generator' -Component 'data' -Stage 'dev'
$ctx = Get-MGContext

# Get RDS secret names
$secretNames = Get-SECSecretList `
    | Where-Object Name -Like "$($ctx.Project)/$($ctx.Stage)/data/rds/*" `
    | Select-Object -ExpandProperty Name

Write-Output "`nSecret names"
Write-Output "------------"
Write-Output $secretNames

# Get secret values
$values = $secretNames | ForEach-Object {
    Get-SECSecretValue -SecretId $_ `
    | Select-Object -ExpandProperty SecretString `
    | ConvertFrom-Json
}

Write-Output "`nSecret values"
Write-Output "-------------"
Write-Output $values | Format-List