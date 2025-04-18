# 成员管理
---

<<< custom_key.brand_name >>>支持通过成员管理对当前工作空间的全部成员进行统一管理，包括设置角色权限、邀请成员并为成员设置权限、配置团队、设置 SSO 单点登录等。

> 仅工作空间 Owner、Administrator 以及被授权了**成员管理**权限的自定义角色可对成员进行统一管理。更多角色说明，可参考 [角色管理](role-management.md)。

![](img/8.member_10.png)

## 成员相关操作

![](img/8.member_3.png)

### 搜索成员

支持通过搜索和快捷筛选快速获取相关的成员列表。

- 搜索：支持搜索成员的邮箱、姓名、昵称及登录类型；    
- 快捷筛选：支持筛选成员的角色、团队及登录类型。

### 批量操作 {#batch}

点击用户名旁的 icon :material-crop-square:，您可以批量修改权限、批量删除。

**注意**：仅 Owner 和 Administrator 可以进行批量操作。


### 删除成员
     
选择需要删除的成员，点击右侧 :fontawesome-regular-trash-can: 按钮即可。  

仅 Owner 和 Administrator 可以删除成员，Owner 这一角色本身无法删除，可通过将当前 Owner 降级为 Administrator 后，对其进行删除。

### 编辑成员 {#edit}

选择需要修改的成员，点击右侧编辑按钮，即可<u>为成员设置昵称、配置角色和团队</u>。

**注意**：仅 Owner 可使用备注功能。

### 邀请成员

您可以邀请<<< custom_key.brand_name >>>的注册用户成为工作空间内的新成员。

> <<< custom_key.brand_name >>>目前支持从两个入口邀请成员。更多信息，可参考 [邀请入口与邀请记录](./invite-member.md)。

### 成员详情

成员被邀请进入工作空间以后，在**成员管理**，点击任意成员即可测滑查看成员的信息，包括成员姓名、创建/更新时间、邮箱、角色以及角色权限。

![](img/8.member_7.png)

点击成员右侧的**编辑**按钮，可选择角色权限和团队。

![](img/8.member_8.png)

???+ abstract "SSO 管理"

    除了**邀请成员**以外，<<< custom_key.brand_name >>>支持企业在本地 IDP（身份提供商） 中管理员工信息，通过配置 SSO 单点登录来访问<<< custom_key.brand_name >>>，无需进行<<< custom_key.brand_name >>>和企业 IDP 之间的用户同步，企业员工即可通过指定的角色登录访问<<< custom_key.brand_name >>>。

    > 在成员管理，点击进入 **SSO 管理**，您可参考文档 [SSO 管理](sso/index.md) 了解更多信息。

    <img src="../img/9.member_sso_1.png" width="70%" >

## 团队相关操作

在成员管理，点击**团队管理**，可进入团队编辑页面。

![](img/8.member_9.png)

???+ abstract "团队的妙用"

    若企业需要针对不同的团队设置不同的告警策略，以便相关团队能够第一时间获取并解决故障问题，可以通过设置团队，并相关的团队成员到该团队，然后在告警策略，设置告警通知对象为该团队。

    > 更多告警策略设置，可参考 [告警策略](../monitoring/alert-setting.md)。

### 新建/编辑团队

进入**团队管理 > 新建团队**：

<img src="../img/1-member-3.png" width="70%" >

自定义团队名称；在左侧待添加列表里，显示所有不在这个团队内的成员，您可以点击搜索框搜索代添加成员。勾选该成员，点击**确定**后即可该成员添加至右侧**成员列表**。

<img src="../img/1-member-4.png" width="70%" >


**注意**：在进行添加成员操作时会验证团队名称是否重复，重名则无法保存。

### 删除团队

轻触一行团队，右侧显示 :fontawesome-regular-trash-can: ，点击后显示二次确认弹窗；

点击**确定**，即可删除该团队：

<img src="../img/1-member-2.png" width="60%" >

### 应用场景

您可以在**监控**的**告警策略管理**和**通知对象管理**中应用已新建的团队。

:material-numeric-1-circle-outline: 在您新建告警配置时，支持在**告警通知对象**中选择已新建的团队。

<img src="../img/1-member-management-1.png" width="60%" >

:material-numeric-2-circle-outline: 在您新建通知对象时，支持在短信和邮件组选择已新建的团队。

<img src="../img/1-member-management-2.png" width="60%" >