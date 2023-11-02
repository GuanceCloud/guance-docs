# OSS 外部 ID 授权
---

## 外部 ID 授权

1、点击前往授权，进入[控制台](https://signin.aliyun.com/login.htm?callback=https%3A%2F%2Fram.console.aliyun.com%2Foverview%3Fspm%3D5176.21213303.8115314850.3.1b7b53c9cMMP17%26scm%3D20140722.S_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572.S_card0.ID_card%40%40%25E4%25BA%25A7%25E5%2593%2581%40%40590572-RL_RAM-OR_ser-V_3-P0_0#/main)。

2、进入 **RAM 访问控制 > 角色**，选择**创建角色**：

![](img/cn1.png)

3、完成创建角色：

![](img/cn2.png)

4、修改角色的信任策略管理

```
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "<外部ID>"
        }
      },
      "Effect": "Allow",
      "Principal": {
        "RAM": [
          "acs:ram::<被授权的账号ID>:user/<用户名>"
        ]
      }
    }
  ],
  "Version": "1"
}
```

![](img/cn4.png)

5、创建权限

![](img/cn7.png)

6、进入 **RAM 访问控制 > 权限策略**，点击继续编辑信息：

![](img/cn8.png)

7、写入权限名字，点击**确定**：

![](img/cn8-1.png)

8、为角色新增授权。

在**角色 > 权限管理**，点击**新增授权**：

![](img/cn9.png)



