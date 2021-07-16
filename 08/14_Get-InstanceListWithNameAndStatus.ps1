Import-Module AWS.Tools.EC2
Import-Module AWS.Tools.RDS

$projectName = "memes-generator"


# --------------------------- Get EC2 instances --------------------------- #
 
Write-Output "`nEC2 instances"
Get-EC2Instance -Filter @{Name="tag:Project";Values=$projectName} `
    | Select-Object -ExpandProperty Instances
    | ForEach-Object {
        [PSCustomObject] @{
            InstanceId = $_.InstanceId
            Name = ($_.Tags.Where({$_.Key -eq "Name"})).Value
            State = $_.State.Name
        }
    }

# --------------------------- Get RDS instances --------------------------- #

Write-Output "`nRDS instances"
Get-RDSDBInstance `
    | Where-Object {$_.TagList.Where({$_.Key -eq "Project"}).Value -eq $projectName}
    | Select-Object DBInstanceIdentifier, DBInstanceStatus