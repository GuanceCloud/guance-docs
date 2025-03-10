# Authorize AWS Using External ID

1. Click to proceed with authorization, [enter the console](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26state%3DhashArgsFromTB_eu-north-1_f2d9c316b93c0026&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=N4VDaEVnh2s2dWnL79Hzyqja2aWFGDoE1FbHXWk6G1M&code_challenge_method=SHA-256).


2. Select IAM

2.1 In the left sidebar, select **Roles**, and click **Create role**:

![](img/role-auth-1.png)

2.2 In **Step 1 > Select trusted entity**, choose **Custom trust policy**:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws-cn:iam::<Authorized Account ID>:user/<Username>"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "<External ID>"
                }
            }
        }
    ]
}
```

???+ warning

    When configuring the custom trust policy, you need to fill in <<< custom_key.brand_name >>>'s AWS ID and username information.

    ![](img/role.png)

    The actual information to be filled in (this is a fixed configuration): `arn:aws-cn:iam::588271335135:user/guance-s3-bakcuplog`

![](img/role-auth-3.png)

2.3 Click Next, in **Step 2 > Add permissions**, click **Create policy**:

![](img/role-auth-5.png)

2.3.1 In **Create policy > Specify permissions > Policy editor**, enter the following content:

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

2.3.2 In **Review and create > Policy details > Policy name**, enter a name to identify this policy, and save the permissions:

![](img/role-auth-9.png)

2.4 Return to the **Create role** interface, click :octicons-sync-16:, and the permissions created in the previous step will appear. Select the permissions:

![](img/role-auth-11.png)

2.5 Enter **Step 3 > Name, review, and create > Role detailed name > Role name**, fill in the **Role name** to identify this role, click **Create role** to complete the authorization. This role name is the **AWS Role Name** you choose under [AWS S3 > Role Authorization > Fill in Archive Information](./backup.md#aws).

![](img/role-auth-12.png)