Import-Module MemGenToolbelt -Force
Import-Module AWS.Tools.Common

Set-DefaultAWSRegion "eu-central-1" -Scope "global"

# --------------------- NETWORK ---------------------

Set-MGContext -Project "memes-generator" -Component "network" -Stage "dev"

# Create IAM role for application istance
try {
    $stackName = Deploy-MGStack `
        -Stack "load-balancing" `
        -Template "load-balancing" `
        -Params "load-balancing" `
        -Wait
    
    Save-MGStackOutputs -StackName $stackName
} catch {
    Write-Error $_.Exception.Message
}
