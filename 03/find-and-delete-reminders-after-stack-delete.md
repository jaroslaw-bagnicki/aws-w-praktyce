# Find and delete resource reminders after stack delete

```powershell
Import-Module AWS.Tools.CloudFormation

Get-CFNStackSummary `
| Where-Object StackStatus -eq 'DELETE_COMPLETE' `
| Sort-Object DeletionTime -Descending -OutVariable deletedStacks `
| Select-Object StackName, DeletionTime

# StackName                           DeletionTime
# ---------                           ------------
# website-single-template-website-dev 6/17/2021 7:12:09 AM
# first-website                       6/17/2021 5:16:31 AM

$deletedStacks `
| Where-Object StackName -eq 'website-single-template-website-dev' `
| Select-Object -ExpandProperty StackId `
| Get-CFNStackResourceList -OutVariable deletedStackResources `
| Select-Object LogicalResourceId, ResourceStatus, ResourceType, PhysicalResourceId

# LogicalResourceId ResourceStatus  ResourceType          PhysicalResourceId
# ----------------- --------------  ------------          ------------------
# S3Website         DELETE_SKIPPED  AWS::S3::Bucket       website-single-template-website-dev-s3website-169yyhm8d7sc4
# S3WebsitePolicy   DELETE_COMPLETE AWS::S3::BucketPolicy website-single-template-website-S3WebsitePolicy-10QNNMVJAHWBB

$deletedStackResources `
| Where-Object { $_.ResourceStatus -eq 'DELETE_SKIPPED' -and $_.ResourceType -eq 'AWS::S3::Bucket' } `
| ForEach-Object -Parallel { Remove-S3Bucket -BucketName $_.PhysicalResourceId -DeleteBucketContent -Force }

```