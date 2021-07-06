Import-Module AWS.Tools.CloudFormation

function Save-MGStackOutputs {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $StackName
    )

    $outputsPaths = Get-MGStackOutputsPath -CreareIfNotExist
    $filePath = Join-Path $outputsPaths $StackName '.json'

    Get-CFNStack -StackName $StackName | Select-Object Outputs | ConvertTo-Json >> $filePath
    
    Write-Host "'$natGatewayAStackName' stack outputs were exported to: $natGatewayAOutputsPath" -ForegroundColor Gray
}