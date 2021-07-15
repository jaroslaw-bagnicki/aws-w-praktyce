#!/bin/bash

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"

######### configuration bucket ###########

COMPONENT="application"
STACK="configuration-bucket"
TEMPLATE="bucket"
PARAMETERS="configuration-bucket"

######### memes bucket ###########

COMPONENT="application"
STACK="memes-bucket"
TEMPLATE="bucket"
PARAMETERS="memes-bucket"

######### application bucket ###########

COMPONENT="application"
STACK="pictures-bucket"
TEMPLATE="bucket"
PARAMETERS="pictures-bucket"

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
