#!/bin/sh

aws apigateway update-deployment --rest-api-id 0ebq7nnsba --deployment-id xg4z6p --patch-operations op='replace' --profile cloudswarm --region us-west-2
