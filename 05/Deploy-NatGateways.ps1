Import-Module MemGenToolbelt -Force

Set-MGContext 'memes-generator' 'network' 'dev'
Deploy-MGStack -Stack 'nat-gateway-a' -Template 'nat-gateway' -Params 'nat-gateway-a'
Deploy-MGStack -Stack 'nat-gateway-b' -Template 'nat-gateway' -Params 'nat-gateway-b'