# OSS RAM 授权策略及外部 ID 授权
---

## 外部 ID 授权

1、点击前往授权，进入[控制台](https://signin.aliyun.com/login.htm?spm=5176.3047821.0.0.190b4255trPBie&callback=https%3A%2F%2Felasticsearch.console.aliyun.com%2Fcn-hangzhou%2Finstances%2Fes-cn-2r42gpgs00027a6sb%2Fbase%3Fspm%3Da2cba.elasticsearch_instance_list.c_list.d_name_instance%26resourceGroupId%3D#/main)。

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



