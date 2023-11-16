# AWS Bucket Authorization

Go to **Amazon S3 > Buckets > Permissions > Bucket Policy**, click **Edit**:

![](img/s3-bucket.png)

Fill in the following JSON:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Guanceyun Access",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws-cn:iam::294654068288:root" // 294654068288 Account-ID
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws-cn:s3:::test-bylx", // test-bylx bucket-name
                "arn:aws-cn:s3:::test-bylx/*" // test-bylx bucket-name
            ]
        }
    ]
}
```