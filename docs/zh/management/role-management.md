# 角色管理
---

若您需要对企业中的员工设置不同的<<< custom_key.brand_name >>>访问权限，以达到不同员工之间的权限隔离，您可以使用<<< custom_key.brand_name >>>的角色管理功能。**角色管理**为用户提供一个直观的权限管理入口，支持自由调整不同角色对应的权限范围、为用户创建新的角色、为角色赋予权限范围，满足不同用户的权限需要。    

## 角色

### 默认角色 {#default-roles}

若企业不同的团队需要查看操作的<<< custom_key.brand_name >>>功能模块不一样，需要区分不同角色权限，可以邀请成员加入到当前工作空间，并为其设置角色权限，来控制该成员可访问和操作的<<< custom_key.brand_name >>>功能模块。

<<< custom_key.brand_name >>>默认提供四种成员角色，并为默认角色进行了重新命名，见如下表格：


| 旧角色名称 | 新角色名称    |
| ---------- | ------------- |
| 拥有者     | Owner         |
| 管理员     | Administrator |
| 标准成员   | Standard      |
| 只读成员   | Read-only     |

**注意**：默认角色不可删除、也不支持变更权限范围。

#### 权限说明 {#descrip}

> 不同默认角色的权限范围，可参考文档 [权限清单](role-list.md)。

| **角色** | **说明**                                                     |
| -------- | ------------------------------------------------------------ |
| Owner | 当前工作空间的拥有者，拥有工作空间内的所有操作权限，支持调整其他成员角色权限，若授予的角色权限中包含 "Token 查看" 则发起授权审核流程，详情可以参考 [权限变更审核](#upgrade)。<br />**注意**：<br /><li>工作空间创建者默认为 Owner <br /><li>一个工作空间只能有一个 Owner <br /><li>  Owner 不可退出工作空间<br /><li>  Owner 可以将权限转让给空间成员，成功转让后，原 Owner 降级为 Administrator  |
| Administrator | 当前工作空间的管理员，具有工作空间读写权限，支持调整除了 Owner 以外的其他成员角色权限。 |
| Standard | 当前工作空间的标准成员，具有工作空间读写权限。                 |
| Read-only | 当前工作空间的只读成员，仅能够对工作空间的数据进行查看，无写入权限。 |

### 自定义角色 {#customized-roles}

除了默认角色以外，<<< custom_key.brand_name >>>支持在角色管理创建新的角色，并为角色赋予权限范围，满足不同用户的权限需要。

在<<< custom_key.brand_name >>>工作空间**管理 > 角色管理**，即可创建一个新的角色。

> 关于自定义角色的权限范围，可参考 [权限清单](role-list.md)。

**注意**：自定义角色仅 Owner、Administrator 可创建。

![](img/8.member_6.png)

#### 修改/删除/克隆角色 {#operations}

您可以对自定义角色进行以下操作：

- 点击**编辑**按钮，即可调整角色的权限；  

- 点击 :fontawesome-regular-trash-can:，若该角色和成员账号无关联，即可删除；    

- 点击 :octicons-copy-24:，可以克隆已有角色从而创建新角色；

    - 在已有角色权限基础上，通过克隆角色可减少操作步骤，快速增减权限并创建角色。

![](img/clone.png)

#### 角色详情页

点击任意自定义角色，即可查看该角色详情信息，包括角色名称、创建/更新时间、创建人/更新人、描述以及角色权限，您可点击角色右侧的**编辑**按钮修改角色权限。

![](img/8.member_13.1.png)

### 权限变更审核 {#upgrade}

在为工作空间成员设置角色权限的时候，若授予的角色权限中包含 "Token 查看" 的权限，则会给<<< custom_key.brand_name >>>费用中心发送一条验证信息，发起权限变更审核流程：

- 若费用中心**接受**该验证，则权限变更成功；
- 若费用中心**拒绝**该验证，则权限变更失败，继续保持原有的角色权限；
- 若费用中心一直未审核，可为成员修改为其他角色，修改成功后，原权限变更审核申请失效。

> 更多权限详情，可参考 [权限清单](role-list.md)。

???+ warning

    - 目前仅 Owner 和 Administrator 具有 "Token 查看" 权限，若商业版工作空间成员需要提权到 Administrator，需到<<< custom_key.brand_name >>>费用中心审核；     
    - 体验版工作空间成员可直接提权 Administrator，无需到<<< custom_key.brand_name >>>费用中心审核。

#### 商业版提权为 Administrator 示例

在<<< custom_key.brand_name >>>工作空间**管理 > 成员管理**，选择需要升到 Administrator 的成员，点击右侧**编辑**按钮，在弹出的对话框中，**角色**选择为 Administrator，点击**确定**。

**注意**：<<< custom_key.brand_name >>>仅支持 Owner、Administrator 角色为当前工作空间成员赋予 Administrator 权限，仅 Owner 角色能够在费用中心审核通过 Administrator 权限。

![](img/11.role_upgrade_1.png)

- 若您是当前工作空间的 Administrator 角色，为成员进行提权时，则需要通知<<< custom_key.brand_name >>>费用中心管理员 [登录费用中心](https://<<< custom_key.boss_domain >>>/) 进行操作；   
- 若您是当前工作空间的 Owner 角色，则可直接点击**前往费用中心审核**，免登录到<<< custom_key.brand_name >>>费用中心进行操作。  

![](img/11.role_upgrade_2.png)

在<<< custom_key.brand_name >>>费用中心的消息中心，点击**接受**：

![](img/11.role_upgrade_3.png)

在**操作确认**对话框，点击**确定**：

![](img/11.role_upgrade_4.png)

可以看到提权申请已经被接受：

![](img/11.role_upgrade_5.png)

返回<<< custom_key.brand_name >>>工作空间成员管理，即可看到工作空间成员已经为 Administrator：

![](img/11.role_upgrade_6.png)

<<< custom_key.brand_name >>>支持在成员管理列表查看所有未通过审核 Administrator 角色的成员，点击成员角色右侧的 ![](img/4.member_admin_2.png) 图标，即可在提示对话框中点击**费用中心**进行审核操作。

**注意**：仅支持 Owner 角色为当前工作空间成员审核通过 Administrator 权限。

![](img/4.member_admin_1.png)

## 权限清单

<<< custom_key.brand_name >>>支持为工作空间内的自定义角色设置权限，满足不同用户的权限需求。

> 更多详情可参考文档 [权限清单](role-list.md)。

**注意**：目前权限仅针对为工作空间内的功能操作设置权限。