Import-Module AWS.Tools.S3

$orphanedBuckets = Get-S3Bucket | Where-Object {
    $stackIdTag = Get-S3BucketTagging $_.BucketName | Where-Object Key -eq 'aws:cloudformation:stack-id'
    $_.BucketName -like "memes-generator-*" -and $null -eq $stackIdTag
}

$orphanedBuckets | Remove-S3Bucket -DeleteBucketContent -Force
