#!/bin/bash

PROJECT="website"
STAGE="dev"
REGION="eu-west-1"

######### Artifact bucket #########

COMPONENT="nested"
STACK="artifact"
TEMPLATE="artifact-bucket"
PARAMETERS="artifact-bucket"

# Deploy

TEMPLATE_FILE="$PROJECT/$COMPONENT/templates/$TEMPLATE.yaml"
PARAM_FILE="$PROJECT/$COMPONENT/parameters/$PARAMETERS-$STAGE.json"

PARAMS=$(cat "$PARAM_FILE" | jq -jr 'map("\(.ParameterKey)=\(.ParameterValue)") | join (" ")')

deploy="aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --no-fail-on-empty-changeset \
    --parameter-overrides $PARAMS \
    --region $REGION \
    --tags Project=$PROJECT Stage=$STAGE Component=$COMPONENT"

echo $deploy

$deploy

######### Nested #########

COMPONENT="nested"
STACK="nested"
TEMPLATE="root"
PARAMETERS="root"

######### common part #########

# Get artifact bucket name
PARAM_NAME="/$PROJECT/$STAGE/$COMPONENT/artifact-bucket/bucket-name"
S3_FOR_TEMPLATES=$(aws ssm get-parameter --name $PARAM_NAME --output text --query Parameter.Value --region $REGION)

echo "$S3_FOR_TEMPLATES"

# Package the nested template

TEMPLATE_FILE="$PROJECT/$COMPONENT/templates/$TEMPLATE.yaml"
TEMPLATE_PACKAGED="$PROJECT/$COMPONENT/templates/$TEMPLATE-packaged.yaml"

package="aws cloudformation package \
     --template-file $TEMPLATE_FILE \
     --output-template $TEMPLATE_PACKAGED \
     --s3-bucket $S3_FOR_TEMPLATES"

echo $package

$package

# Deploy

PARAM_FILE="$PROJECT/$COMPONENT/parameters/$PARAMETERS-$STAGE.json"

PARAMS=$(cat "$PARAM_FILE" | jq -jr 'map("\(.ParameterKey)=\(.ParameterValue)") | join (" ")')

deploy="aws cloudformation deploy \
    --template-file $TEMPLATE_PACKAGED \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --no-fail-on-empty-changeset \
    --parameter-overrides $PARAMS \
    --region $REGION \
    --tags Project=$PROJECT Stage=$STAGE Component=$COMPONENT"

echo $deploy

$deploy