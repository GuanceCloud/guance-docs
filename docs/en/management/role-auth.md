# Use External ID to Authorize AWS

I. [Go to the console](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256).


II. Choose IAM.

i. Choose **Roles** and click **Create role**:

![](img/role-auth-1.png)

ii. In **Step 1 > Select trusted entity** and select **Custom trust policy**:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws-cn:iam::<Aauthorized ID>:user/<Username>"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "<Eexternal ID>"
                }
            }
        }
    ]
}
```

???+ warning

    When you configure **Custom trust policy**, hyou need to fill in AWS ID of Guance and user name: `arn:aws-cn:iam::<Aauthorized ID>:user/<Username>`

    The actual filling information is as follows (this is a fixed configuration): `arn:aws-cn:iam::588271335135:user/guance-s3-bakcuplog`

![](img/role-auth-3.png)

iii. Click **Step 2 > Add permissions** and **Create policy**:

![](img/role-auth-5.png)

(i). In **Create policy > Specify permissions > Policy editor**, fill in the following content:

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

(ii). In **Review and cretae > Policy details > Policy name**, enter a meaningful name to identify this policy:

![](img/role-auth-9.png)

iv. Back to the page **Create role**. Click :octicons-sync-16: and then the Permission that has been created in the previous step appears. Select it:

![](img/role-auth-11.png)

v. Enter **Step 3 > Name, review and create > Role details > Role name**, enter a meaningful name to identify the role. Click **Create** to finish the authorization. The role name here is the **AWS Role name** under [AWS S3 > Role authorization > Fill in archive information](./backup.md#aws).


![](img/role-auth-12.png)

