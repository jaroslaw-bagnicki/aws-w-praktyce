## WEEK 6 HOMEWORK
 - [x] Create EC2 KeyPair via [`New-MGKeyPair`](../toolbelt/MemGenToolbelt/functions/New-MGKeyPair.ps1) cmdlet.
 - [x] Deploy **JumpHost** stack via PS script [`Deploy-JumpHost.ps1`](Deploy-JumpHost.ps1). Log: [`jumphost_deploy2021-07-06.log`](jumphost_deploy2021-07-06.log)
 - [x] Log into instance via **SSH**.
 - [x] Log into EC2 instance via **SSM Session Manager**. 

### Additional homework
*Remark: **AWS Tools for Powershell** was used instead of **AWS CLI***
```powershell
# Get EC2 instance ids and public IPs for all istances
Get-EC2Instance | select -ExpandProperty Instances | select InstanceId, PublicIpAddress
InstanceId          PublicIpAddress
----------          ---------------
i-0e02a46340f9893da 
i-07836433eff136ab7 
i-0c4f0431e8047015d 18.159.206.160

# Get EC2 instance state
Get-EC2Instance i-0c4f0431e8047015d | select -ExpandProperty Instances | select -ExpandProperty State
Code Name
---- ----
16   running

# Or for detailed status
Get-EC2InstanceStatus i-0c4f0431e8047015d | select InstanceState, Status, SystemStatus | ConvertTo-Json -Depth 3
{
  "InstanceState": {
    "Code": 16,
    "Name": {
      "Value": "running"
    }
  },
  "Status": {
    "Details": [
      {
        "ImpairedSince": "0001-01-01T00:00:00",
        "Name": "reachability",
        "Status": "passed"
      }
    ],****
    "Status": {
      "Value": "ok"
    }
  },
  "SystemStatus": {
    "Details": [
      {
        "ImpairedSince": "0001-01-01T00:00:00",
        "Name": "reachability",
        "Status": "passed"
      }
    ],
    "Status": {
      "Value": "ok"
    }
  }
}

# Stop EC2 instance
Stop-EC2Instance i-0c4f0431e8047015d
CurrentState                   InstanceId          PreviousState
------------                   ----------          -------------
Amazon.EC2.Model.InstanceState i-0c4f0431e8047015d Amazon.EC2.Model.InstanceState

# Get EC2 instance by tag "Name"
Get-EC2Instance -Filter @{Name="tag:Name"; Values="memes-generator-dev-operations-jumphost-instance"} | select -ExpandProperty Instances | select InstanceId, PublicIpAddress
InstanceId          PublicIpAddress
----------          ---------------
i-0c4f0431e8047015d 54.93.175.135

#  Get EC2 instances by tag "Project" and "Stage"
Get-EC2Instance -Filter @{Name="tag:Project"; Values="memes-generator"}, @{Name="tag:Stage"; Values="dev"} | select -ExpandProperty Instances
InstanceId          InstanceType Platform PrivateIpAddress PublicIpAddress SecurityGroups                            SubnetId                 VpcId
----------          ------------ -------- ---------------- --------------- --------------                            --------                 -----
i-0c4f0431e8047015d t2.micro              10.0.37.148      54.93.175.135   {memes-generator-dev-network-jumphost-sg} subnet-058d1df75d27a9eca vpc-0aada1ee5ac4ff832
```

### Additional Remarks
1. SSM User don't have access to ec2-user home folder:
![](https://i.imgur.com/WAdYqhM.png)
2. Recreation EC2 KeyPair with same name no cause it replacement on instance. To restore SSH access manual replacemnt need to be done. ([AWS docs: Add or replace a key pair for your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#replacing-key-pair))
3. Login via SSH can be simplified by levareaging SSH config file. [more](https://github.com/jaroslaw-bagnicki/toolbox/blob/main/cheatsheets/ssh.md#config-file)
   