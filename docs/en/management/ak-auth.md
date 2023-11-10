# Create Users in AWS and Generate AK/SK

1. [Go to the console](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256) and choose **IAM**.


2. Enter **Access management > Users**, click **Add users**。

![](img/ak-auth-1.png)

2.1 Enter **Step 1 > Specify user details** to start creating a user:

2.2 Enter your **User name** in **User details**.

![](img/ak-auth-2.png)

2.3 In **Step 2 > Set permissions > Permissions options**, select **Attach policies directly** and the click **Create policy**:

![](img/ak-auth-3.png)

2.3.1 In **Edit policy > Modify permissions > Policy editor**, input the following cntent:

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

![](img/ak-auth-4.png)

2.3.2 In **Review and create > Policy details > Policy name**, enter a meaningful name to identify this policy:

![](img/ak-auth-5.png)

2.4 Back to **Create users** page and click :octicons-sync-16:  and then the Permission that has been created in the previous step appears. Select it:

![](img/ak-auth-6.png)

2.5 The user has been successfully created:

![](img/ak-auth-7.png)

1. Create AK/SK: enter **Access management > Users** and click **Security credentials**. Slide the interface and select **Create access key**。

![](img/ak-auth-8.png)

![](img/ak-auth-9.png)

3.1 Choose **Local code**:

![](img/ak-auth-10.png)

3.2 Then AK/SK would be generated:

![](img/ak-auth-11.png)

This is the only time that the secret acess key can be viewed or downloaded. You cannot recover it later. However, you can create a new access key any time.