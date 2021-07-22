#!/bin/bash

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"

######### Params ###########

COMPONENT="application"
STACK="application-instance"
TEMPLATE="application-instance"
PARAMETERS="application-instance"

########## NAT Gateway ########
# Make sure you have the NAT Gateway deployed in the same AZ as your instance!

######### common part #########

TEMPLATE_FILE="$PROJECT/$COMPONENT/templates/$TEMPLATE.yaml"
PARAM_FILE="$PROJECT/$COMPONENT/parameters/$PARAMETERS-$STAGE.json"

deploy="aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --no-fail-on-empty-changeset \
    --parameter-overrides file://$PARAM_FILE \
    --region $REGION \
    --tags Project=$PROJECT Stage=$STAGE Component=$COMPONENT"

echo $deploy

$deploy
