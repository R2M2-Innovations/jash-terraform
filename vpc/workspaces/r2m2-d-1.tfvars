####################################################################################
# TAG CONFIGURATION SETTINGS
####################################################################################
organization = "r2m2"
environment = "d"
stack_id = "1"
deployment_type = "terraform"
deployment_repo = "https://github.com/r2m2/terraform/vpc"
compliance = "n/a"

####################################################################################
# VPC CONFIGURATION SETTINGS
####################################################################################

# vpc region
region = "us-east-1"

# vpc cidr block
vpc_cidr_block = "10.0.16.0/20"
enable_dns_support = true
enable_dns_hostnames = true

# public subnet settings
public_subnets = [
 "a,10.0.16.0/23,public",
 "b,10.0.18.0/23,public"
]
deploy_nat_gateways = true 

#private subnet settings
private_subnets = [
  "a,10.0.20.0/23,private",
  "b,10.0.22.0/23,private",
  "a,10.0.24.0/23,backend",
  "b,10.0.26.0/23,backend"
]

