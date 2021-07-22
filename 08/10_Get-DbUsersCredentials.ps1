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

# Interpolate psql command to add app user
$admin = Get-SECSecretValue -SecretId "memes-generator/dev/data/rds/masteruser-secret" `
    | Select-Object -ExpandProperty SecretString `
    | ConvertFrom-Json

$appUser =  Get-SECSecretValue -SecretId "memes-generator/dev/data/rds/app-user-secret" `
    | Select-Object -ExpandProperty SecretString `
    | ConvertFrom-Json

Write-Output "`n"
Write-Output "PGPASSWORD=$($admin.password) psql -U masteruser -h $($admin.host) -d $($admin.dbname) -c ""CREATE USER $($appUser.username) WITH ENCRYPTED PASSWORD '$($appUser.password)';"""
Write-Output "`n"
Write-Output "PGPASSWORD=$($admin.password) psql -U masteruser -h $($admin.host) -d $($admin.dbname) -c ""GRANT ALL PRIVILEGES ON DATABASE $($appUser.dbname) TO $($appUser.username);"""