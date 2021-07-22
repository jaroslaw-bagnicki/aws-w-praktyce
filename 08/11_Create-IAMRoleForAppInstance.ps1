Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# --------------------- APPLICATION ---------------------

# Set context for 'application' component
Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Create IAM role for application istance
$stackName = Deploy-MGStack `
    -Stack 'application-permissions' `
    -Template 'application-permissions' `
    -Params 'application-permissions' `
    -Capability 'CAPABILITY_IAM' `
    -Wait

Save-MGStackOutputs -StackName $stackName
