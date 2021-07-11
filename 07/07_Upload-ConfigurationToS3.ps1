Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common
Import

$ErrorActionPreference = 'Stop'
Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

function Get-ParamName([string] $bucketFunction) {
    $ctx = Get-MGContext
    "/$($ctx.Project)/$($ctx.Stage)/$($ctx.Component)/$bucketFunction-bucket/name"
}

function Get-ConfigDirForContext([string] $filename) {
    $ctx = Get-MGContext
    Resolve-Path "./$($ctx.Project)/$($ctx.Component)/config/$filename-$($ctx.Stage)"  
}

# --------------------- OPERATIONS ---------------------

# Set current context
Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Upload server configuration
$ssmParamName = Get-ParamName 'configuration'
$bucketName = Get-SSMParameter -Name $ssmParamName | Select-Object -ExpandProperty Value

$configFilename = '.memesconf'
$configFile = Join-Path Get-ConfigDirForContext "$configFilename-$(ctx.Sage)"

Write-S3Object -BucketName $bucketName -File $configFile -Key "service/$configFilename"
