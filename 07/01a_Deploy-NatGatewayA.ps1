Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# -------------------- NAT GATEWAYS --------------------

# Set context for 'network' component
Set-MGContext -Project 'memes-generator' -Component 'network' -Stage 'dev'

# Deploy NAT Gateway to first AZ
$natGatewayAStackName = Deploy-MGStack -Stack 'nat-gateway-a' -Template 'nat-gateway' -Params 'nat-gateway-a' -Wait
Save-MGStackOutputs -StackName $natGatewayAStackName
