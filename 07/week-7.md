## WEEK 7 HOMEWORK
 - [x] Add S3 buckets for storing: configuration, static assets. (_done: 7/11/21_)  
   - Deployed with script [`06_Deploy-ApplicationBuckers.ps1`](06_Deploy-ApplicationBuckers.ps1)  
   - Log: [`2021-07-11_deploy-app-buckets.log`](logs/2021-07-11_deploy-app-buckets.log)
   - Outputs:
     - [`memes-generator-application-configuration-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-configuration-bucket-dev.json)
     - [`memes-generator-application-memes-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-memes-bucket-dev.json)
     - [`memes-generator-application-pictures-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-pictures-bucket-dev.json)
 - [ ] Upload configuration, and assets to S3.
 - [x] Update Jumphost EC2 instance. (_done: 7/11/21_)  
    Instance updated with script: [`05_Update-Jumphost.ps1`](05_Update-JumpHost.ps1)  
    ![img](https://i.imgur.com/YlxgFig.png)
 - [ ] Deploy database RDS instance.
 - [ ] Create databse users.
 - [ ] Add application IAM role.
 - [ ] Add lounch template.
 - [ ] Deploy application EC2 instance.

Aditional work:
 - Orphaned S3 buckets were pruned with script: [`04_Remove-OrphanedS3Buckets.ps`](04_Remove-OrphanedS3Buckets.ps1)