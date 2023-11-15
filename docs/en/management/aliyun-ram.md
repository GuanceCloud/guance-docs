# 在阿里云中配置观测云 RAM 策略

1. Grant Permission:

![](img/cn1-ram.png)

2. Create Policy:

![](img/cn2-ram.png)

3. Edit policy information:

```
{
  "Version": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "oss:ListBuckets",
        "oss:ListObjects",
        "oss:DeleteObject",
        "oss:PutObject",
        "oss:PutBucket"
      ],
      "Resource": [
        "acs:oss:*:*:*",
        "acs:oss:*:*:*/*"
      ]
    }
  ]
}
```

![](img/cn3.png)

4. Create sucessfully:

![](img/cn4.png)

5. Add Custom Policy sucessfully:

![](img/cn5.png)