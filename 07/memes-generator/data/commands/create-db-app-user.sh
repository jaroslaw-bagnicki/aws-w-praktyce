#!/bin/bash

# Commands for jumphost-db (jumphost with additional db tools & permissions)

PROJECT="memes-generator"
STAGE="dev"
REGION="eu-west-1"

MASTERUSER_SECRET_NAME="$PROJECT/$STAGE/data/rds/masteruser-secret"
APP_SECRET_NAME="$PROJECT/$STAGE/data/rds/app-user-secret"

APP_SECRET=$(aws secretsmanager get-secret-value --secret-id $APP_SECRET_NAME --output text --query SecretString --region $REGION)
DB_HOST=$(echo $APP_SECRET | jq '.host' | sed 's|\"||g')
DB_NAME=$(echo $APP_SECRET | jq '.dbname' | sed 's|\"||g')
DB_APP_USER=$(echo $APP_SECRET | jq '.username' | sed 's|\"||g')
DB_APP_PASSWORD=$(echo $APP_SECRET | jq '.password' | sed 's|\"||g')

MASTERUSER_SECRET=$(aws secretsmanager get-secret-value --secret-id $MASTERUSER_SECRET_NAME --output text --query SecretString --region $REGION)
MASTERUSER_PASSWORD=$(echo $MASTERUSER_SECRET | jq '.password' | sed 's|\"||g')

##### create appuser #####

PGPASSWORD=$MASTERUSER_PASSWORD psql -U masteruser -h $DB_HOST -d $DB_NAME -c "CREATE USER $DB_APP_USER WITH ENCRYPTED PASSWORD '$DB_APP_PASSWORD';"
PGPASSWORD=$MASTERUSER_PASSWORD psql -U masteruser -h $DB_HOST -d $DB_NAME -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_APP_USER;"
