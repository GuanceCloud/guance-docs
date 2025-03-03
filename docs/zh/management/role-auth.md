# 使用外部 ID 对 AWS 授权

1、点击前往授权，[进入控制台](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256)。


2、选择 IAM

2.1 在左边栏选择**角色**，点击**创建角色**：

![](img/role-auth-1.png)

2.2 在**步骤 1 > 选择可信实体**，选择**自定义信任策略**：

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws-cn:iam::<授权的账号ID>:user/<用户名>"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "<外部ID>"
                }
            }
        }
    ]
}
```

???+ warning

    在您进行自定义信任策略配置时，需填写{{{ custom_key.brand_name }}}的 AWS ID 及用户名信息。

    ![](img/role.png)

    实际填写信息如下（此为固定配置）：`arn:aws-cn:iam::588271335135:user/guance-s3-bakcuplog`

![](img/role-auth-3.png)

2.3 点击下一步，在**步骤 2 > 添加权限**，点击**创建策略**：

![](img/role-auth-5.png)

2.3.1 在**创建策略 > 指定权限 > 策略编辑器**，输入以下内容：

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws-cn:s3:::<bucket name>",
                "arn:aws-cn:s3:::<bucket name>/*"
            ]
        }
    ]
}
```

![](img/role-auth-7.png)

2.3.2 在**查看和创建 > 策略详细信息 > 策略名称**，输入名称来标识此策略，并保存权限：

![](img/role-auth-9.png)

2.4 回到**创建角色**界面，点击 :octicons-sync-16: 后，出现上一步已创建完成的权限。选中权限：

![](img/role-auth-11.png)

2.5 进入**步骤 3 > 命名、查看和创建 > 角色详细名称 > 角色名称**，填写**角色名称**来标识此角色，点击**创建角色**，即可完成授权。此处的角色名称就是您选择 [AWS S3 > 角色授权 > 填写存档信息](./backup.md#aws)下的 **AWS 角色名称**。


![](img/role-auth-12.png)

