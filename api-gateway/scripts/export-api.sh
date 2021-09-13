#!/bin/sh

API_ID='00uct77hae'
STAGE_NAME='test'
EXPORT_TYPE='oas30'
OUTPUT_FILE=${API_ID}-${STAGE_NAME}.${EXPORT_TYPE}
PROFILE='comcast'
REGION='us-west-2'

aws apigateway get-export --parameters extensions='integrations' --rest-api-id ${API_ID} --stage-name ${STAGE_NAME} --export-type ${EXPORT_TYPE} ${OUTPUT_FILE} --profile ${PROFILE} --region ${REGION}
