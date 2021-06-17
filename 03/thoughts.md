# Delete CF Stack reminders

```powershell
# List deleted stacks
Get-CFNStackSummary `
| where StackStatus -eq 'DELETE_COMPLETE' -OutVariable deletedStacks `
| select StackName

# StackName
# ---------
# website-single-template-website-dev
# first-website

$deletedStacks `
| where StackName -eq 'website-single-template-website-dev' `
| select -ExpandProperty StackId `
| Get-CFNStackResourceList -OutVariable deletedStackResources `
| select LogicalResourceId, ResourceStatus, ResourceType, PhysicalResourceId

# LogicalResourceId ResourceStatus  ResourceType          PhysicalResourceId
# ----------------- --------------  ------------          ------------------
# S3Website         DELETE_SKIPPED  AWS::S3::Bucket       website-single-template-website-dev-s3website-169yyhm8d7sc4
# S3WebsitePolicy   DELETE_COMPLETE AWS::S3::BucketPolicy website-single-template-website-S3WebsitePolicy-10QNNMVJAHWBB

$deletedStackResources `
| where { $_.ResourceStatus -eq 'DELETE_SKIPPED' -and $_.ResourceType -eq 'AWS::S3::Bucket' } `
| foreach -Parallel { Remove-S3Bucket -BucketName $_.PhysicalResourceId -DeleteBucketContent -Force }

```