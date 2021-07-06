Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# --------------------- OPERATIONS ---------------------

# Set context for 'operations' component
Set-MGContext -Project 'memes-generator' -Component 'operations' -Stage 'dev'

# Deploy Log Bucket
$logBucketStackName = Deploy-MGStack -Stack 'log-bucket' -Template 'log-bucket' -Params 'log-bucket'
Save-MGStackOutputs -StackName $logBucketStackName


# -------------------- NETWORK BASE --------------------

# Set context for 'network' component
Set-MGContext -Project 'memes-generator' -Component 'network' -Stage 'dev'

# Deploy Network
$natGatewayAStackName = Deploy-MGStack -Stack 'network' -Template 'network' -Params 'network'
Save-MGStackOutputs -StackName $natGatewayAStackName

# Deploy Security Groups
$natGatewayAStackName = Deploy-MGStack -Stack 'security-groups' -Template 'security-groups' -Params 'security-groups' -ErrorAction Stop
Save-MGStackOutputs -StackName $natGatewayAStackName


# -------------------- NAT GATEWAYS --------------------

# Set context for 'network' component
Set-MGContext -Project 'memes-generator' -Component 'network' -Stage 'dev'

# Deploy NAT Gateway to first AZ
$natGatewayAStackName = Deploy-MGStack -Stack 'nat-gateway-a' -Template 'nat-gateway' -Params 'nat-gateway-a'
Save-MGStackOutputs -StackName $natGatewayAStackName

# # Deploy NAT Gateway to second AZ
$natGatewayBStackName = Deploy-MGStack -Stack 'nat-gateway-b' -Template 'nat-gateway' -Params 'nat-gateway-b'
Save-MGStackOutputs -StackName $natGatewayBStackName