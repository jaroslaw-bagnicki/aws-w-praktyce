## WEEK 7 HOMEWORK
 - [x] Add S3 buckets for storing: configuration, static assets. (_done: 7/11/21_)  
   - Deployed with script [`06_Deploy-ApplicationBuckers.ps1`](06_Deploy-ApplicationBuckers.ps1)  
   - Log: [`2021-07-11_deploy-app-buckets.log`](logs/2021-07-11_deploy-app-buckets.log)
   - Outputs:
     - [`memes-generator-application-configuration-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-configuration-bucket-dev.json)
     - [`memes-generator-application-memes-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-memes-bucket-dev.json)
     - [`memes-generator-application-pictures-bucket-dev.json`](memes-generator/application/outputs/memes-generator-application-pictures-bucket-dev.json)
 - [x] Upload configuration to S3. (_done: 7/11/21_)  
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
 - [x] Upload assets (pictures) to S3. (_done: 7/11/21_)  
   Uploaded with script: [`08_Upload-PicturesToS3.ps1`](08_Upload-PicturesToS3.ps1). Result:
      ```powershell
      Get-S3Object -BucketName "memes-generator-application-pictures-buc-s3bucket-134kk33me41i4"

      ETag         : "694aeeaa15cb0a176c544fc2c4dafd5e"
      BucketName   : memes-generator-application-pictures-buc-s3bucket-134kk33me41i4
      Key          : Ancient-Aliens.jpg
      LastModified : 7/11/2021 9:05:46 PM
      Owner        : Amazon.S3.Model.Owner
      Size         : 23669
      StorageClass : STANDARD

      ETag         : "74e694f46f8e4a64e5da83f63e1760d8"
      BucketName   : memes-generator-application-pictures-buc-s3bucket-134kk33me41i4
      Key          : Doge.jpg
      LastModified : 7/11/2021 9:05:46 PM
      Owner        : Amazon.S3.Model.Owner
      Size         : 27264
      StorageClass : STANDARD

      ETag         : "b4f01fa3b17e75eed0e506a87b0a95b0"
      BucketName   : memes-generator-application-pictures-buc-s3bucket-134kk33me41i4
      Key          : Left-Exit-12-Off-Ramp.jpg
      LastModified : 7/11/2021 9:05:47 PM
      Owner        : Amazon.S3.Model.Owner
      Size         : 63808
      StorageClass : STANDARD
      ```
 - [x] Update Jumphost EC2 instance. (_done: 7/11/21_)  
    Instance updated with script: [`05_Update-Jumphost.ps1`](05_Update-JumpHost.ps1)  
    ![img](https://i.imgur.com/YlxgFig.png)
 - [x] Deploy database RDS instance. (_done: 7/13/21_)  
      Deployed with script [`09_Deploy-DatabaseInstance.ps1`](09_Deploy-DatabaseInstance.ps1). 
 - [x] Create in database 'app-user'. (_done: 7/13/21_)  
      Db user credentials retrieved from **Secrets Manager** with script [`10_Get-DbUsersCredentials.ps1`](10_Get-DbUsersCredentials.ps1). 
      ![img](https://i.imgur.com/yx2iTO2.png)
 - [x] Create application IAM role. (_done: 7/13/21_)  
      Done with script: [`11_Create-IAMRoleForAppInstance.ps1`](11_Create-IAMRoleForAppInstance.ps1)
 - [x] Deploy lounch template. (_done 7/14/21_)  
     Done with script [`12_Deploy-LaunchTemplate.ps1`](12_Deploy-LaunchTemplate.ps1)
 - [x] Deploy application EC2 instance. (_done 7/14/21_)  
     Done with script [`13_Deploy-AppInstance.ps1`](13_Deploy-AppInstance.ps1)
 - [x] Connect to application instance via **Session Manager**  (_done 7/14/21_)  
     ![img](https://i.imgur.com/KeyaRk8.png)
 - [x] Generate first meme. (_done 7/14/21_)  
     ![img](https://i.imgur.com/NpYSYC2.png)
 - [x] Call application from jumhost. (_done 7/14/21_)  
     ![img](https://i.imgur.com/Cxc7scW.png)

Aditional work:
 - Orphaned S3 buckets were pruned with script: [`04_Remove-OrphanedS3Buckets.ps`](04_Remove-OrphanedS3Buckets.ps1)