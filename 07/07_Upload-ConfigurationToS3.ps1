Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.S3

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# Set current context
$ctx = Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Get bucket name for configuration files
$paramName = "/$($ctx.Project)/$($ctx.Stage)/$($ctx.Component)/configuration-bucket/name"
$bucketName = Get-SSMParameter $paramName | Select-Object -ExpandProperty Value

# Upload server configuration
try {
    $filename = '.memesconf'
    $path = Resolve-Path "./$($ctx.Project)/$($ctx.Component)/config/$filename-$($ctx.Stage)" -Relative
    $key = "service/$filename"
    Write-S3Object -BucketName $bucketName -File $path -Key $key
    Write-Host "[$(Get-Time)] File: '$path' was successfuly uploaded to bucket: '$bucketName' under key: '$key'" -ForegroundColor Green
} catch {
    Write-Error $_.Exception.Message
}

# Upload cloudwatch configuration
try {
    $filename, $ext = "cloudwatch-config-memes-generator.json".Split('.')
    $path = Resolve-Path "./$($ctx.Project)/$($ctx.Component)/config/$filename-$($ctx.Stage).$ext" -Relative
    $key = "cloudwatch/$filename.$ext"
    Write-S3Object -BucketName $bucketName -File $path -Key $key
    Write-Host "[$(Get-Time)] File: '$path' was successfuly uploaded to bucket: '$bucketName' under key: '$key'" -ForegroundColor Green
} catch {
    Write-Error $_.Exception.Message
}
