#!/bin/bash

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"


#########  Params ###########

# NAT Gateway A
COMPONENT="network"
STACK="nat-gateway-a"
TEMPLATE="nat-gateway"
PARAMETERS="nat-gateway-a"

# NAT Gateway B
COMPONENT="network"
STACK="nat-gateway-b"
TEMPLATE="nat-gateway"
PARAMETERS="nat-gateway-b"


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

######## delete stack ##########

delete="aws cloudformation delete-stack \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --region $REGION"

echo $delete

$delete
