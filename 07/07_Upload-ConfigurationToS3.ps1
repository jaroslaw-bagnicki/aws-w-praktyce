Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.S3

$ErrorActionPreference = 'Stop'
Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# Set current context
$ctx = Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Get bucket name for configuration files
$paramName = "/$($ctx.Project)/$($ctx.Stage)/$($ctx.Component)/configuration-bucket/name"
$bucketName = Get-SSMParameter $paramName | Select-Object -ExpandProperty Value

# Upload server configuration
$filename = '.memesconf'
$path = Resolve-Path "./$($ctx.Project)/$($ctx.Component)/config/$filename-$($ctx.Stage)"
Write-S3Object -BucketName $bucketName -File $path -Key "service/$filename"

# Upload cloudwatch configuration
$filename, $ext = "cloudwatch-config-memes-generator.json".Split('.')
$path = Resolve-Path "./$($ctx.Project)/$($ctx.Component)/config/$filename-$($ctx.Stage).$ext"
Write-S3Object -BucketName $bucketName -File $path -Key "cloudwatch/$filename.$ext"
