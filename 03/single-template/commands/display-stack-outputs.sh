#!/bin/bash

PROJECT="website"
STAGE="dev"
REGION="eu-west-1"

######### single-template ###########

COMPONENT="single-template"
STACK="website"

######### common part #########

outputs="aws cloudformation describe-stacks \
    --stack-name $PROJECT-$COMPONENT-$STACK-$STAGE \
    --output text \
    --query Stacks[].Outputs[] \
    --region $REGION"

echo "$outputs"

$outputs