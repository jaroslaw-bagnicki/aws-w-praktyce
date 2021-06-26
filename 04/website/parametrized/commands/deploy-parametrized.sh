#!/bin/bash

PROJECT="website"
STAGE="dev"
REGION="eu-central-1"


######### log bucket ###########

COMPONENT="parametrized"
STACK="log-bucket"
TEMPLATE="log-bucket"
PARAMETERS="log-bucket"

######### website ###########

COMPONENT="parametrized"
STACK="website"
TEMPLATE="website"
PARAMETERS="website"


######### common part #########

TEMPLATE_FILE="$PROJECT/$COMPONENT/templates/$TEMPLATE.yaml"
PARAM_FILE="$PROJECT/$COMPONENT/parameters/$PARAMETERS-$STAGE.json"

deploy="aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --capabilities CAPABILITY_NAMED_IAM \
    --no-fail-on-empty-changeset \
    --parameter-overrides file://$PARAM_FILE \
    --region $REGION \
    --tags Project=$PROJECT Stage=$STAGE Component=$COMPONENT"

echo $deploy

$deploy