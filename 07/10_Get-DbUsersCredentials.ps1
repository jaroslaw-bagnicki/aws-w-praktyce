Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.SecretsManager

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# Set context for 'data' component
Set-MGContext -Project 'memes-generator' -Component 'data' -Stage 'dev'
$ctx = Get-MGContext

# Retrieve 
$secretNames = @(
    "$($ctx.Project)/$($ctx.Stage)/data/rds/masteruser-secret"
    "$($ctx.Project)/$($ctx.Stage)/data/rds/app-user-secret"
)

try {
    $credentials = $secretNames | ForEach-Object {
        Get-SECSecretValue -SecretId $_ | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    }
} catch {
    Write-Error $_.Exception.Message
}

Write-Output $credentials | Format-List