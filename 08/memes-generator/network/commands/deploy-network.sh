#!/bin/bash

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"


#########  Params ###########

COMPONENT="network"
STACK="network"
TEMPLATE="network"
PARAMETERS="network"


######### common part #########

TEMPLATE_FILE="$PROJECT/$COMPONENT/templates/$TEMPLATE.yaml"
PARAM_FILE="$PROJECT/$COMPONENT/parameters/$PARAMETERS-$STAGE.json"

PARAMS=$(cat $PARAM_FILE | jq -jr 'map("\(.ParameterKey)=\(.ParameterValue)") | join (" ")')

deploy="aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --no-fail-on-empty-changeset \
    --parameter-overrides $PARAMS \
    --region $REGION \
    --tags Project=$PROJECT Stage=$STAGE Component=$COMPONENT"

echo $deploy

$deploy
