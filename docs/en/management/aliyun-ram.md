# Configure <<< custom_key.brand_name >>> RAM Policy in Alibaba Cloud

1. Add Authorization:

![](img/cn1-ram.png)

2. Create Permission Policy:

![](img/cn2-ram.png)

3. Add Permission Policy:

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

4. Complete Creating Permission Policy:

![](img/cn4.png)

5. Add Authorization Policy to User:

![](img/cn5.png)