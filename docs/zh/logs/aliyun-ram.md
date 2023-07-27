# 在阿里云中配置观测云 RAM 策略

1、新增授权：

![](img/cn1-ram.png)

2、创建权限策略：

![](img/cn2-ram.png)

3、添加权限策略：

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

4、创建权限策略完成：

![](img/cn4.png)

5、为用户添加授权策略：

![](img/cn5.png)