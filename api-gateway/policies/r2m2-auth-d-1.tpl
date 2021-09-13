"x-amazon-apigateway-policy": {
  "Version": "2012-10-17",
  "Statement": [
    { 
      "Effect": "Allow",
      "Principal": "*",
      "Action": "execute-api:Invoke",
      "Resource": "arn:aws:execute-api:${region}:${account}:*/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "0.0.0.0/0"
        }   
      }   
    }
  ]   
}
