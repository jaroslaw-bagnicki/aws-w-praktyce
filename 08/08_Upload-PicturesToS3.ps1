Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.S3

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# Set current context
$ctx = Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Get bucket name for configuration files
$paramName = "/$($ctx.Project)/$($ctx.Stage)/$($ctx.Component)/pictures-bucket/name"
$bucketName = Get-SSMParameter $paramName | Select-Object -ExpandProperty Value

# Upload picture
try {
    $tempDir = New-Item -Path . -Name "pitures" -ItemType "directory" -Force

    wget https://imgflip.com/s/meme/Ancient-Aliens.jpg -nv -P $tempDir
    wget https://imgflip.com/s/meme/Left-Exit-12-Off-Ramp.jpg -nv -P $tempDir
    wget https://imgflip.com/s/meme/Doge.jpg -nv -P $tempDir

    Write-Host "Downloaded files:"
    Get-ChildItem $tempDir | Select-Object -ExpandProperty Name

    Write-S3Object -BucketName $bucketName -Folder $tempDir -KeyPrefix /
    Write-Host "[$(Get-Time)] Pictures were successfuly uploaded to bucket: '$bucketName'." -ForegroundColor Green
} catch {
    Write-Error $_.Exception.Message
} finally {
    Remove-Item $tempDir -Recurse -Force
}