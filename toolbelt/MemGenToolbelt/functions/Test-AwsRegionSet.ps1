Import-Module AWS.Tools.Common

function Test-AwsRegionSet {
    $currentRegion = Get-DefaultAWSRegion
    if ($null -eq $currentRegion) {
        throw "AWS region is not set! Run 'Set-DefaultAWSRegion' command to set it."
    }
}