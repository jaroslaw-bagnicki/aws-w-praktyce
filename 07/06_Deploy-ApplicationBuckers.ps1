Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

$ErrorActionPreference = 'Stop'

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'

# --------------------- OPERATIONS ---------------------

# Set current context
Set-MGContext -Project 'memes-generator' -Component 'application' -Stage 'dev'

# Deploy Bucket for configuration
$configurationBucketStackName = Deploy-MGStack -Stack 'configuration-bucket' -Template 'bucket' -Params 'configuration-bucket' -Wait
Save-MGStackOutputs -StackName $configurationBucketStackName

# Deploy Bucket for generated Memes
$memesBucketStackName = Deploy-MGStack -Stack 'memes-bucket' -Template 'bucket' -Params 'memes-bucket' -Wait
Save-MGStackOutputs -StackName $memesBucketStackName

# Deploy Bucket for app assets (pictures)
$picturesBucketStackName = Deploy-MGStack -Stack 'pictures-bucket' -Template 'bucket' -Params 'pictures-bucket' -Wait
Save-MGStackOutputs -StackName $picturesBucketStackName