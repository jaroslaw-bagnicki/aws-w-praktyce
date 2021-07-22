#!/bin/bash

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"

COMPONENT="application"
PARAM_NAME="/$PROJECT/$STAGE/$COMPONENT/configuration-bucket/name"
BUCKET=$(aws ssm get-parameter --name $PARAM_NAME --output text --query Parameter.Value --region $REGION)

echo "Uploading to configuration bucket: $BUCKET"

APPLICATION="memes-generator" # replace with application name
CONFIG_FILE=".memesconf-$STAGE"
CONFIG_OBJECT=".memesconf"
aws s3 cp "memes-generator/application/config/$CONFIG_FILE" "s3://$BUCKET/service/$CONFIG_OBJECT"
