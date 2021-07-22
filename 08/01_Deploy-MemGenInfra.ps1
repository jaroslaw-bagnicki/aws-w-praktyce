Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# --------------------- OPERATIONS ---------------------

# Set context for 'operations' component
Set-MGContext -Project 'memes-generator' -Component 'operations' -Stage 'dev'

# Deploy Log Bucket
$logBucketStackName = Deploy-MGStack -Stack 'log-bucket' -Template 'log-bucket' -Params 'log-bucket' -Wait
Save-MGStackOutputs -StackName $logBucketStackName


# -------------------- NETWORK BASE --------------------

# Set context for 'network' component
Set-MGContext -Project 'memes-generator' -Component 'network' -Stage 'dev'

# Deploy Network
$networkStackName = Deploy-MGStack -Stack 'network' -Template 'network' -Params 'network' -Wait
Save-MGStackOutputs -StackName $networkStackName

# Deploy Security Groups
$securityGroupsStackName = Deploy-MGStack -Stack 'security-groups' -Template 'security-groups' -Params 'security-groups' -Wait
Save-MGStackOutputs -StackName $securityGroupsStackName
