# Configure <<< custom_key.brand_name >>> IAM Policy in Huawei Cloud

Huawei Cloud's permission management policy is based on "user groups" as the basic permission unit, meaning: create a user group, associate permission sets and accounts with the user group, then add users to the user group so that all users under the user group obtain the corresponding permissions.


1. Log in to the console, hover over the account in the top-right corner, and click “Unified Identity Authentication”.

Click “User Groups” in the left-hand menu and create a user group.

![](img/obs-ak.png)


2. Create a custom permission policy, click to create a custom policy at “Permission Management > Permissions”.

Choose the JSON view configuration method and paste the provided JSON content here.

![](img/obs-ak-1.png)

```
{
    "Version": "1.1",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "obs:object:GetObject",
                "obs:object:AbortMultipartUpload",
                "obs:object:DeleteObject",
                "obs:bucket:HeadBucket",
                "obs:object:PutObject",
                "obs:bucket:ListBucketMultipartUploads",
                "obs:object:ListMultipartUploadParts",
                "obs:bucket:ListBucket"
            ]
        }
    ]
}
```


![](img/obs-ak-2.png)


3. Authorize the user group, select the custom permission policy created in step two.

**Note**: It takes 15-30 minutes for the authorization to take effect.

![](img/obs-ak-3.png)


![](img/obs-ak-4.png)

4. Create a user and add this user to the corresponding permission user group.


![](img/obs-ak-5.png)


4.1 Fill in the user name and other required fields (check “Access Key”)

![](img/obs-ak-6.png)

4.2 Add to the user group created in step one

**Note**: If a user is associated with multiple user groups, the user's permissions are the union of all user group permission policies.

![](img/obs-ak-7.png)

4.3 After successfully creating the user, download the access key from the pop-up box.

**Note**: This key can only be downloaded once. If you cancel, it will not be possible to view/download this key later. You can set up to 2 access keys in “User > Security Settings”.

![](img/obs-ak-8.png)