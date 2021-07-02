### HOMEWORK
 - [x] Deploy stack `log-bucket` stack (_done: 7/2/21_)
    - deploy script: [`memes-generator/operations/commands/deploy-log-bucket.ps1`](memes-generator/operations/commands/deploy-log-bucket.ps1)
    - output: [`memes-generator/operations/outputs/memes-generator-operations-log-bucket-dev.json`](memes-generator/operations/outputs/memes-generator-operations-log-bucket-dev.json) (used command `Get-CFNStack memes-generator-operations-log-bucket-dev | Select-Object -ExpandProperty Outputs | ConvertTo-Json >> memes-generator-operations-log-bucket-dev.json`)