Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

Set-DefaultAWSRegion "eu-central-1" -Scope "global"

# --------------------- APPLICATION ---------------------

Set-MGContext -Project "memes-generator" -Component "application" -Stage "dev"

# Create IAM role for application istance
try {
    $stackName = Deploy-MGStack `
        -Stack "application-auto-scaling" `
        -Template "application-auto-scaling" `
        -Params "application-auto-scaling" `
        -Wait
    
    Save-MGStackOutputs -StackName $stackName
} catch {
    Write-Error $_.Exception.Message
}
