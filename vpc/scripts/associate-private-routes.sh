#!/bin/sh

VPC_ID=$1
REGION=$2
PROFILE='ht'

# get all NAT gateways in vpc 
NAT_GATEWAYS=(`aws ec2 describe-nat-gateways --filter "Name=vpc-id,Values=${VPC_ID}" --query 'NatGateways[*].[NatGatewayId]' --profile ${PROFILE} --region ${REGION} --output text`)

for NAT_GATEWAY in ${NAT_GATEWAYS[@]}
do
  NAT_GATEWAY_ID=${NAT_GATEWAY}
	
	# get NAT gateway subnet id 
  NAT_GATEWAY_SUBNET_ID=(`aws ec2 describe-nat-gateways --filter "Name=nat-gateway-id,Values=${NAT_GATEWAY_ID}" --query 'NatGateways[*].[SubnetId]' --profile ${PROFILE}  --region ${REGION} --output text`)

	# get NAT gateway AZ 
  NAT_GATEWAY_AZ=(`aws ec2 describe-subnets --subnet-ids ${NAT_GATEWAY_SUBNET_ID} --query 'Subnets[*].[AvailabilityZone]' --profile ${PROFILE}  --region ${REGION} --output text`)

	#get all subnets in AZ
	SUBNETS=(`aws ec2 describe-subnets --filter "Name=vpc-id,Values=${VPC_ID}" "Name=availability-zone,Values=${NAT_GATEWAY_AZ}" --query 'Subnets[*].[SubnetId]' --profile ${PROFILE}  --region ${REGION} --output text`)

	for SUBNET in ${SUBNETS[@]}
  do
    # test for public or private subnet 
	  PUBLIC_SUBNET=(`aws ec2 describe-subnets --subnet-ids ${SUBNET} --query 'Subnets[*].[MapPublicIpOnLaunch]' --profile ${PROFILE}  --region ${REGION} --output text`)

		# if subnet is private add route table association to NAT gateway in same AZ
		if [ ${PUBLIC_SUBNET} == "False" ]
    then
	    echo "associating private subnet ${SUBNET} route table to nat gateway ${NAT_GATEWAY_ID}"
		  ROUTE_TABLE_ID=(`aws ec2 describe-route-tables --filter "Name=route.nat-gateway-id,Values=${NAT_GATEWAY_ID}" --query 'RouteTables[*].[RouteTableId]' --profile ${PROFILE}  --region ${REGION} --output text`)
		  aws ec2 associate-route-table --subnet-id ${SUBNET} --route-table-id ${ROUTE_TABLE_ID} --profile ${PROFILE}  --region ${REGION} > /dev/null
    fi
  done
done

