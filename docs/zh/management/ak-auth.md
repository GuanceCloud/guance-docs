# AWS 创建用户及 AK/SK 授权

1、点击前往授权，[进入控制台](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256)，选择 IAM。


2、选择**访问管理 > 用户**，点击**添加用户**。

![](img/ak-auth-1.png)

2.1 进入**步骤 1 > 指定用户详细信息**，开始创建用户：

2.2 在用户详细信息，输入用户名：

![](img/ak-auth-2.png)

2.3 进入**步骤 2 > 设置权限 > 权限选项**，选择**直接附加策略**，点击**创建策略**：

![](img/ak-auth-3.png)

2.3.1 在**编辑策略 > 修改权限 > 策略编辑器**，输入以下内容：

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
				"s3:CreateBucket",
				"s3:ListAllMyBuckets",
				"s3:ListBucket"
			],
			"Resource": "arn:aws-cn:s3:::*"
		}
	]
}
```

**注意**：仅国内站点支持使用 `aws-cn` 配置，海外站点账户需使用 `aws`。

![](img/ak-auth-4.png)

2.3.2 在**查看和创建 > 策略详细信息 > 策略名称**，输入名称来标识此策略，并保存权限：

![](img/ak-auth-5.png)

2.4 回到**创建角色**界面，点击 :octicons-sync-16: 后，出现上一步已创建完成的权限。选中权限：

![](img/ak-auth-6.png)

2.5 完成**创建用户**：

![](img/ak-auth-7.png)

3、创建 AK/SK，选择**访问管理 > 用户**，点击**安全凭证**。滑动界面，选中**创建访问密钥**。

![](img/ak-auth-8.png)

![](img/ak-auth-9.png)

3.1 选择本地代码

![](img/ak-auth-10.png)

3.2 即可生成 AK/SK

![](img/ak-auth-11.png)

这是唯一一次可以查看或下载秘密访问密钥的机会。您以后将无法恢复。但是，您可以随时创建新的访问密钥。