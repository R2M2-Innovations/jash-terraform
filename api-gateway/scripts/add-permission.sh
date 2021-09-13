#!/bin/sh

FUNCTION_NAME='sky_uk-normalize_mediainfo_svc-d-1'
DESCRIPTION='1ozkq2m2ki-permit'
SOURCE_ARN="arn:aws:execute-api:us-west-2:716878819946:1ozkq2m2ki/*/*/*"
PROFILE='comcast'
REGION='us-west-2'

aws lambda add-permission \
--function-name ${FUNCTION_NAME} \
--statement-id ${DESCRIPTION} \
--principal apigateway.amazonaws.com \
--action lambda:InvokeFunction \
--source-arn ${SOURCE_ARN} \
--profile ${PROFILE} \
--region ${REGION}

