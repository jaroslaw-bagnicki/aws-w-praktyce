Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

Set-DefaultAWSRegion "eu-central-1" -Scope "global"

# --------------------- APPLICATION ---------------------

# Set context for "application" component
Set-MGContext -Project "memes-generator" -Component "application" -Stage "dev"

# Create IAM role for application istance
try {
    $stackName = Deploy-MGStack `
        -Stack "application-instance" `
        -Template "application-instance" `
        -Params "application-instance" `
        -Wait
    
    Save-MGStackOutputs -StackName $stackName
} catch {
    Write-Error $_.Exception.Message
}
