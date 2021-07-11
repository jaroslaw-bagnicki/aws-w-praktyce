Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# --------------------- OPERATIONS ---------------------

# Set context for 'operations' component
Set-MGContext -Project 'memes-generator' -Component 'operations' -Stage 'dev'

# Deploy JumpHost EC2 instace
$jumphostStackName = Deploy-MGStack `
    -Stack 'jumhost' `
    -Template 'jumphost' `
    -Params 'jumphost' `
    -Capability 'CAPABILITY_IAM' `
    -Wait
Save-MGStackOutputs -StackName $jumphostStackName
