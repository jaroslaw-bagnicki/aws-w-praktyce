Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# ----------------------- DATA -----------------------

# Set context for 'data' component
Set-MGContext -Project 'memes-generator' -Component 'data' -Stage 'dev'

# Deploy Log Bucket
$stackName = Deploy-MGStack -Stack 'database' -Template 'database' -Params 'database' -Wait
Save-MGStackOutputs -StackName $stackName
