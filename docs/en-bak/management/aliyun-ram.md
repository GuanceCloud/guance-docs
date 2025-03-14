# Configure Guance RAM Policy in Alibaba Cloud

I. Grant Permission:

![](img/cn1-ram.png)

II. Create Policy:

![](img/cn2-ram.png)

III. Edit policy information:

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

IV. Create sucessfully:

![](img/cn4.png)

V. Add Custom Policy sucessfully:

![](img/cn5.png)