# External ID Authorization for OSS
---

## External ID Authorization

1. Click to proceed with authorization, and enter the [console](https://signin.aliyun.com/login.htm?callback=https%3A%2F%2Fram.console.aliyun.com%2Foverview%3Fspm%3D5176.21213303.8115314850.3.1b7b53c9cMMP17%26scm%3D20140722.S_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572.S_card0.ID_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572-RL_RAM-OR_ser-V_3-P0_0#/main).

2. Go to **RAM Access Control > Roles**, and select **Create Role**:

![](img/cn1.png)

3. Complete the creation of the role:

![](img/cn2.png)

4. Modify the trust policy for the role

```json
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "<External ID>"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "RAM": [
          "acs:ram::<Authorized Account ID>:user/<Username>"
        ]
      }
    }
  ],
  "Version": "1"
}
```

![](img/cn4.png)

5. Create permissions

![](img/cn7.png)

6. Enter **RAM Access Control > Policies**, and click to continue editing information:

![](img/cn8.png)

7. Enter the permission name, and click **Confirm**:

![](img/cn8-1.png)

8. Add new authorization for the role.

In **Roles > Permissions Management**, click **Add Authorization**:

![](img/cn9.png)