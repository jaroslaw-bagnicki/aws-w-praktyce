Import-Module AWS.Tools.Common
Import-Module MemGenToolbelt -Force

Set-DefaultAWSRegion 'eu-central-1' -Scope 'global'
Set-MGContext -Project 'memes-generator' -Component 'operations' -Stage 'dev'

New-MGKeyPair -KeyName 'jumphost-key'