####################################################################################
# ACCOUNT, REGION, AND TAG CONFIGURATION SETTINGS
####################################################################################
account = "618323728704"
region = "us-east-1"
organization = "r2m2"
application = "create"
environment = "d"
stack_id = "1"
deployment_type = "terraform"
deployment_repo = "https://github.com/r2m2/terraform/lambda"

####################################################################################
# LAMBDA FUNCTION CONFIGURATION SETTINGS 
####################################################################################
source_type = "s3"                                    # deploy from local file or s3 bucket [ file | s3 ]"
source_file = "./lambda_handler.zip"                  # local zip file name if source_type == file 
source_s3_bucket = "r2m2-lambda-d-1"                  # source s3 bucket if source_type == s3
source_s3_key = "create/lambda_handler.zip"           # s3 bucket key (path and filename) if source_type = s3
source_s3_object_version = ""                         # optional s3 object version if s3 bucket is versioned
handler = "lambda_function.lambda_handler.index"      # filename.entrypoint where lambda function execution begins
runtime = "nodejs14.x"                                # lambda function runtime 
memory_size = "128"                                   # memory to allocate at runtime 
timeout = "30"                                        # lambda function timeout
concurrency = "-1"                                    # sets concurrency level (-1 = unlimited)

vpc_subnet_ids = [       # optionally creates EIPs in VPC to allow access to VPC based resources
]
vpc_security_groups = [  # optionally allows VPC based resources to access lambda function from within VPC
]

env_vars = {             # environment variables to be passed to the lambda function
  ENVIRONMENT = "d"
}
publish = "false"       # publish lambda function as a new version - used to backout to previous version(s) [ true | false ]
trace = "false"         # enable / disable x-ray tracing [ true | false ]

####################################################################################
# CLOUDWATCH MONITORING SETTINGS
####################################################################################
monitoring = true                                                          # enable / disable cloudwatch best practice alarms
alarm_notification_arns = "arn:aws:sns:us-east-1:618323728704:r2m2-alarms" # alarm notification endpoint
ok_notification_arns = "arn:aws:sns:us-east-1:618323728704:r2m2-alarms"    # alarm clear notification endpoint
