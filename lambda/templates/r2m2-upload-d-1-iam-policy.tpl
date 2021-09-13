{
    "Version": "2012-10-17",
    "Statement": [
      {
         "Effect" : "Allow",
         "Action" : [
           "kms:Decrypt"
         ],
         "Resource" : [
            "*"
          ]
       },
       {
         "Effect" : "Allow",
         "Action" : [
           "ec2:DescribeNetworkInterfaces",
           "ec2:CreateNetworkInterface",
           "ec2:DeleteNetworkInterface"
         ],
         "Resource" : [
            "*"
         ]
       },
       {
         "Effect": "Allow",
         "Action": "xray:PutTraceSegments",
         "Resource": "*"
       },
       {
         "Effect": "Allow",
         "Action": "logs:CreateLogGroup",
         "Resource": "arn:aws:logs:${region}:${account}:*"
       },
       {
         "Effect": "Allow",
         "Action": [
           "logs:CreateLogStream",
           "logs:PutLogEvents"
         ],
         "Resource": [
            "arn:aws:logs:${region}:${account}:log-group:/aws/lambda/*:*"
         ]
       }
    ]   
}

