Import-Module MemGenToolbelt -Force

# Set context for 'network' component
Set-MGContext 'memes-generator' 'network' 'dev'

# Deploy NAT Gateway to first AZ
$natGatewayAStackName = Deploy-MGStack -Stack 'nat-gateway-a' -Template 'nat-gateway' -Params 'nat-gateway-a'
Save-MGStackOutputs -Name $natGatewayAStackName

# Deploy NAT Gateway to second AZ
$natGatewayBStackName = Deploy-MGStack -Stack 'nat-gateway-b' -Template 'nat-gateway' -Params 'nat-gateway-b'
Save-MGStackOutputs -Name $natGatewayBStackName