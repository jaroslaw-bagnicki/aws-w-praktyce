## WEEK 7 HOMEWORK
 - [x] Add S3 buckets for storing: configuration, static assets. (_done: 7/11/21_)  
   - Deployed with script [`06_Deploy-ApplicationBuckers.ps1`](06_Deploy-ApplicationBuckers.ps1)  
   - Log: [`2021-07-11_deploy-app-buckets.log`](logs/2021-07-11_deploy-app-buckets.log)
   - Outputs:
     - [`memes-generator-application-configuration-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-configuration-bucket-dev.json)
     - [`memes-generator-application-memes-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-memes-bucket-dev.json)
     - [`memes-generator-application-pictures-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-pictures-bucket-dev.json)
 - [x] Upload configuration, and assets to S3.  (_done: 7/11/21_)    
   Uploaded with script: [`07_Upload-ConfigurationToS3.ps1`](07_Upload-ConfigurationToS3.ps1). Result:
      ```powershell
      Get-S3Object -BucketName "memes-generator-application-configuratio-s3bucket-1xjpyqpokw21o"

      ETag         : "a2f0e46631edecbed8437716c6b56ac8"
      BucketName   : memes-generator-application-configuratio-s3bucket-1xjpyqpokw21o
      Key          : cloudwatch/cloudwatch-config-memes-generator.json
      LastModified : 7/11/2021 3:17:07 PM
      Owner        : Amazon.S3.Model.Owner
      Size         : 2541
      StorageClass : STANDARD

      ETag         : "88ef01344c51f70e9709e9e620621f6c"
      BucketName   : memes-generator-application-configuratio-s3bucket-1xjpyqpokw21o
      Key          : service/.memesconf
      LastModified : 7/11/2021 3:16:48 PM
      Owner        : Amazon.S3.Model.Owner
      Size         : 29
      StorageClass : STANDARD
      ```
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