Import-Module AWS.Tools.EC2
. Join-Path $PSScriptRoot ./MGContext
. Join-Path $PSScriptRoot ./Test-AwsRegionSet
. Join-Path $PSScriptRoot ./DateTimeHelpers

function New-MGKeyPair {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $KeyName
    )

    try {
        Test-AwsRegionSet
        Test-MGContext
    
        $ctx = Get-MGContext
        $keyFullName = "$($ctx.Project)-$($ctx.Stage)-$KeyName"
    
        Write-Host "[$(Get-Time)] Creating [$keyFullName] key pair ..." -ForegroundColor Blue
        $response = New-EC2KeyPair -KeyName $keyFullName
        Write-Host "[$(Get-Time)] Key pair [$($response.KeyName)] created success." -ForegroundColor Green
    
        $keyPath = Join-Path $HOME '.ssh' "$keyFullName.pem"
        $response.KeyMaterial | Out-File -Encoding ascii -FilePath $keyPath
        Write-Host "[$(Get-Time)] Private key was store in: $keyPath" -ForegroundColor Gray

        if ($IsLinux -or $IsMacOS) {
            chmod 400 $keyPath
        }
        
    } catch {
        Write-Error $_.Exception.Message -ErrorAction Stop      
    }
}