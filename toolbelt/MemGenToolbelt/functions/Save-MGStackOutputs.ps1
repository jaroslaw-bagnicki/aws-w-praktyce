Import-Module AWS.Tools.CloudFormation
. Join-Path $PSScriptRoot ./DateTimeHelpers

function Save-MGStackOutputs {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $StackName
    )

    $outputsDirPath = Get-MGStackOutputsPath -CreateIfNotExist
    $outputsFilePath = Join-Path $outputsDirPath "$StackName.json"

    Get-CFNStack -StackName $StackName `
        | Select-Object -ExpandProperty Outputs `
        | ConvertTo-Json `
        | Out-File $outputsFilePath

    $relativePath = Resolve-Path -Path  $outputsFilePath -Relative
    Write-Host "[$(Get-Time)] [$StackName] stack outputs were exported to: $relativePath" -ForegroundColor Gray
}