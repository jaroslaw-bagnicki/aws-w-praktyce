#!/bin/bash

PROJECT="website"
STAGE="dev"
REGION="eu-central-1"

######### single-template ###########

COMPONENT="single-template"
STACK="website"

######### common part #########

outputs="aws cloudformation describe-stacks \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --output yaml \
    --query Stacks[].Outputs[] \
    --region $REGION"

# echo "$outputs"

$outputs