# OSS External ID Authorization
---


I. [Go to the console](https://signin.aliyun.com/login.htm?callback=https%3A%2F%2Fram.console.aliyun.com%2Foverview%3Fspm%3D5176.21213303.8115314850.3.1b7b53c9cMMP17%26scm%3D20140722.S_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572.S_card0.ID_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572-RL_RAM-OR_ser-V_3-P0_0#/main).

II. Enter **RAM > Users** and select **Grant Permission**:

![](img/cn1.png)

III. Finish createing the role:

![](img/cn2.png)

IV. Edit policy information:

```
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "<Eexternal ID>"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "RAM": [
          "acs:ram::<Authorizaed ID>:user/<Username>"
        ]
      }
    }
  ],
  "Version": "1"
}
```

![](img/cn4-1.png)

V. Create a Policy:

![](img/cn7.png)

VI. Enter **RAM > Policies** and click to continue creating policy:

![](img/cn8.png)

VII. Enter the policy name and click OK:

![](img/cn8-1.png)

VIII. In **Roles > Permissions** and click **Grant Permission**:

![](img/cn9.png)



