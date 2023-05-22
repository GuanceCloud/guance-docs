# 配置 Keycloak 单点登录映射规则
---

## 简介

观测云支持使用动态映射规则添加账号到工作空间并映射角色进行单点登录。下面以添加映射规则属性字段“department”，属性值“product” 为例，介绍如何配置 Keycloak 映射规则单点登录到观测云。

## 前置条件

已配置完 [Keycloak单点登录](keycloak-sso.md) 。

## 操作步骤

### 1.配置 Keycloak 用户

> 注意：为 Keycloak 用户配置映射规则有两种方式，一种是为用户直接添加映射规则属性，另外一种是为用户组添加映射规则属性。

#### 1.1 为**用户**添加映射规则属性

1）在创建的gcy域，点击“User”，选择需要添加映射规则的用户，在“Attributes”，点击“Add”添加，如：

- Key：department
- Value：product

![](img/10.keycloak_11.png)

#### 1.2 为**用户组**添加映射规则属性

1）在创建的gcy域，点击“Groups”，点击“New”，创建一个新的用户组，如“department”。

![](img/10.keycloak_14.png)

2）在“Attributes”，点击“Add”添加，，如：

- Key：department
- Value：product

![](img/10.keycloak_13.png)

3）在“User” > “Groups”，点击“Join”，为用户添加用户组。

![](img/10.keycloak_12.png)

### 2.配置 Keycloak 映射字段

> 注意：本步骤将创建 Keycloak Client Scopes 并配置映射字段， 用于建立 Keycloak 和观测云之间的映射规则。

1）在创建的“gcy”领域下，点击“Client Scopes”，在右侧点击“Create”。

![](img/10.keycloak_3.png)

2）在“Add client scope”填写需要配置映射的属性字段，如“department”，点击“Save”。

![](img/10.keycloak_4.png)

3）在“Mappers”，右侧点击“Create”创建映射。

![](img/10.keycloak_5.png)

4）在“Create Protocol Mappers“，按照以下内容填写完成后，点击“Save”。

- Name：填入映射属性字段，如“department”
- Mapper Type：选择“User Attribute”
- User Attribute：填入映射属性字段，如“department”
- Token Claim Name：填入映射属性字段，如“department”
- Claim JSON Type：选择 “String”

![](img/10.keycloak_7.png)

5）在“Client”，点击创建的“Guance”客户端。

![](img/10.keycloak_8.png)

6）在“Client Scopes” > "Setup"，把创建的“department”添加到右侧“Assigned Default Client Scopes”。

![](img/10.keycloak_9.png)


### 3.验证用户配置的映射规则是否可用

配置完映射规则以后，在“Client” > “Client Scopes” > "Evaluate" > "Generated User Info"，可查看映射规则是否可用。如下图，已存在配置的映射字段，则说明可以通过该字段进行映射登录。

![](img/10.keycloak_10.png)

### 4.配置观测云管理后台映射规则

> 注意：本步骤将创建观测云的映射规则， 用于建立 Keycloak 和观测云之间的映射规则。

在观测云管理后台“映射规则” > “添加映射” > “添加映射属性字段和属性值，选择工作空间和角色” > “启用”，创建并启用映射规则，见下图。

![](img/10.keycloak_2.png)

### [5.使用 Keycloak 账号单点登录观测云](keycloak-sso.md#5-keycloak)


