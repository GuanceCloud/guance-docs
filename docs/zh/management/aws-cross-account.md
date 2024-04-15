# AWS 桶授权

进入 **Amazon S3 > 存储桶 > 权限 > 存储桶策略**，点击**编辑**：

![](img/s3-bucket.png)

填入以下 JSON：

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