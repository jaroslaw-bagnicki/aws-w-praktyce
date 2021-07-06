### HOMEWORK
 - [x] Deploy `log-bucket` stack (_done: 7/2/21_)
    - deploy script: [`memes-generator/operations/commands/deploy-log-bucket.ps1`](memes-generator/operations/commands/Deploy-LogBucket.ps1)
    - output: [`memes-generator/operations/outputs/memes-generator-operations-log-bucket-dev.json`](memes-generator/operations/outputs/memes-generator-operations-log-bucket-dev.json) (used command `Get-CFNStack memes-generator-operations-log-bucket-dev | Select-Object -ExpandProperty Outputs | ConvertTo-Json >> memes-generator-operations-log-bucket-dev.json`)
 - [x] Deploy `network` stack (_done: 7/2/21_)
    - deploy script [`memes-generator/network/commands/Deploy-Network.ps1`](memes-generator/network/commands/Deploy-Network.ps1)
    - output: [`memes-generator/network/outputs/memes-generator-network-network-dev.json`](memes-generator/network/outputs/memes-generator-network-network-dev.json)
 - [x] Deploy `security-groups` stack (_done: 7/2/21_)
    - deploy script [`memes-generator/network/commands/Deploy-SecurityGroups.ps1`](memes-generator/network/commands/Deploy-SecurityGroups.ps1)
    - output: [`memes-generator/network/outputs/memes-generator-network-security-groups-dev.json`](memes-generator/network/outputs/memes-generator-network-security-groups-dev.json)
 - [x] Deploy `nat-gateway` stacks (_done: 7/3/21_)
    - deploy script [`memes-generator/network/commands/Deploy-NatGateway.ps1`](memes-generator/network/commands/Deploy-NatGateway.ps1)
    - output: [`memes-generator/network/outputs/memes-generator-network-nat-gateway-a-dev.json`](memes-generator/network/outputs/memes-generator-network-nat-gateway-a-dev.json)
    - output: [`memes-generator/network/outputs/memes-generator-network-nat-gateway-b-dev.json`](memes-generator/network/outputs/memes-generator-network-nat-gateway-b-dev.json)

All stacks info: [`all-stack-info.json`](all-stacks-info.json).

#### 7/6/21 Update
1. Added [MemGenToolbelt](../toolbelt/README.md) PowerShell module to simplify **Memes Generator** project infrastructure management.
1. Deployed all infrastructure at once via [`Deploy-MemGenIfra.ps1`](./Deploy-MemGenInfra.ps1). Log file: [`deploy_2021-07-06`](deploy_2021-07-06.log)