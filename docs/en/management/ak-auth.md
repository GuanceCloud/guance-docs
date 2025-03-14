# Create AWS User and AK/SK Authorization

1. Click to proceed with authorization, [enter the console](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256), and select IAM.


2. Select **Access Management > Users**, then click **Add user**.

![](img/ak-auth-1.png)

2.1 Enter **Step 1 > Specify user details**, and start creating the user:

2.2 In user details, enter the username:

![](img/ak-auth-2.png)

2.3 Enter **Step 2 > Set permissions > Permissions options**, select **Attach existing policies directly**, and click **Create policy**:

![](img/ak-auth-3.png)

2.3.1 In **Edit policy > Modify permissions > Policy editor**, input the following content:

```json
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

**Note**: The `aws-cn` configuration is supported only for domestic sites; overseas accounts must use `aws`.

![](img/ak-auth-4.png)

2.3.2 In **Review and create > Policy details > Policy name**, enter a name to identify this policy and save the permissions:

![](img/ak-auth-5.png)

2.4 Return to the **Create role** interface, click :octicons-sync-16:, and the permissions created in the previous step will appear. Select the permissions:

![](img/ak-auth-6.png)

2.5 Complete **Create user**:

![](img/ak-auth-7.png)

3. To create AK/SK, select **Access Management > Users**, click **Security credentials**, scroll down, and select **Create access key**.

![](img/ak-auth-8.png)

![](img/ak-auth-9.png)

3.1 Choose local code

![](img/ak-auth-10.png)

3.2 Generate AK/SK

![](img/ak-auth-11.png)

This is the only time you can view or download the secret access key. You cannot recover it later. However, you can always create new access keys.