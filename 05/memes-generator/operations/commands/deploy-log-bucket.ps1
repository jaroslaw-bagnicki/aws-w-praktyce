Import-Module AWS.Tools.Common
Import-Module AWS.Tools.CloudFormation

Set-DefaultAwsRegion 'eu-east-1'

$stage = "dev"
$project = "memes-generator"
$component = "operations"

$stack = "log-bucket"

$templateFilename = "log-bucket"
$parametersFilename = "log-bucket"

$templatePath = "$project/$component/templates/$templateFilename.yaml"
$parameterPath = "$project/$component/parameters/$parametersFilename-$stage.json"
