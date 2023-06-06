# Azure AD 单点登录（部署版）
---

## 操作场景

Azure Active Directory (Azure AD) 是 Microsoft 推出的基于云的标识和访问管理服务，可帮助企业管理内外部资源。

## 操作步骤

### 1、创建 Azure AD 应用程序

1）登录进入 [Azure Active Directory 管理中心](https://portal.azure.com/)，点击管理 Azure Active Directory 下的**查看 > 概述 > 添加应用程序**。

![](img/aad-1.png)

![](img/aad-2.png)

2）在**添加应用程序**页面，点击**创建你自己的应用程序**，在打开的页面输入**应用的名称**，并选择**非库应用程序**，点击**创建**，即可创建一个新的应用程序。如图定义改应用名称为 “观测云部署版”。

![](img/aad-3.png)

### 2、为 Azure AD 应用程序配置 OpenID Connect & OAuth 2.0

1）您可以在**应用注册 > 所有应用程序**下查看您所创建的应用程序。

![](img/aad-4.png)

2）点击进入 “观测云部署版”。首先进行**身份验证**。

- 点击**添加平台**，在右侧页面中选择 **Web**，输入**应用程序的重定向 URI**，点击**配置**。

![](img/aad-6.png)

- 在**隐式授权和混合流**、**受支持的帐户类型**及**高级设置**，配置可参考下图：

![](img/aad-7.png)

- 全部配置完成后点击保存。

3）开始**身份验证**，添加您的**客户端密码**。

???+ attention

    除了刚刚创建时，之后无法查看客户端密码值。请务必在创建时保存密码，然后再离开该页面。

![](img/aad-8.png)

4）在**公开 API**，添加**应用程序 ID URI**、**此 API 定义的作用域**范围及**客户端应用程序**：

![](img/aad-9.png)

### 3、配置 Azure AD 用户组

![](img/aad-11.png)

1）回到主页，进入**组 > 新建组**；

![](img/aad-12.png)

2）选择**组类型**：

- 安全性：用于管理用户和计算机对共享资源的访问权限。

- Microsoft 365：通过向成员赋予对共享邮箱、日历、文件、SharePoint 站点等的访问权限，提供协作机会。

3）输入**组名**，按需添加组描述；

4）按需选择添加**所有者**或**成员**。创建组后，可以添加成员和所有者；  

- 选择“所有者”或“成员”下的链接，以填充目录中每个用户的列表；  
- 从列表中选择用户，然后点击窗口底部的“选择”按钮。

4）点击**创建**。

![](img/aad-13.png)

### 4、观测云 Launcher 配置 {#config}

1）在观测云 Launcher **命名空间：forethought-core > core** 中配置 Azure AD 的基本信息。

```
# Pass 版 keycloak 第三方认证服务配置
KeyCloakPassSet:
  # 认证服务地址, 例如 https://cce.guance.com/auth/" （请优先使用 wellKnowURL 配置项）
  serverUrl:
  # 认证服务所在的 realm （请优先使用 wellKnowURL 配置项）
  realmName:
  # OIDC 可访问端点信息地址，例如 https://www.xxx.com/xxxx/.well-known/openid-configuration
  # 注意，当存在 wellKnowURL时，serverUrl和realmName 自动失效
  wellKnowURL: https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration
  # 由认证服务提供的 客户端ID
  clientId:
  # 客户端的 Secret key
  clientSecret:
  # 认证方式，目前只支持 authorization_code
  grantType: authorization_code
  verify: false
  # 数据访问范围
  scope: "openid profile email address"
  # 认证服务器认证成功之后的回调地址
  innerUrl: "{}://{}/keycloak/login_callback"
  # 认证服务认证成功并回调 DF 系统之后，DF系统拿到用户信息后跳转到前端中专页面的地址
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # 从认证服务中获取到的账号信息 与 DF 系统账号的映射配置, 其中必填项为: username, email, exterId
  mapping:
    # 认证服务中，登录账号的用户名，必填，如果值不存在，则取 email
    username: preferred_username
    # 认证服务中，登录账号的邮箱，必填
    email: email
    # 认证服务中，登录账号的唯一标识， 必填
    exterId: sub
```

参考示例图：

![](img/aad-14.png)

???+ info

    **客户端 ID** 和**客户端密钥值**可在下图位置中获取：

    ![](img/aad-15.png)

    ![](img/aad-16.png)


2）在观测云 Launcher **命名空间：forethought-webclient > frontNginx** 中配置跳转信息。

```
        # =========KeyCloak 跳转相关配置开始=========
        # 请求直接跳转至 Inner API 的接口 =========开始=========
        location /keycloak/login {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/keycloak/login;
        }
         
        location /keycloak/login_callback {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/keycloak/login_callback;
       }
       # =========KeyCloak 跳转相关配置结束=========
```

参考示例图：

![](img/1.keycloak_4.png)

3）在观测云 Launcher **命名空间：forethought-webclient > frontWeb** 中配置 Azure AD 用户登录观测云部署版的入口地址。

```
window.DEPLOYCONFIG = {
 
    ......
    paasCustomLoginInfo:[
        {url:"http://<观测云的部署域名>/keycloak/login",label:"Keycloak 登录"}
    ]
     
    ......
 
};
```

参考示例图：

![](img/1.keycloak_5.png)

4) 配置完成后，勾选更新的**修改配置**，并确认重启。

![](img/1.keycloak_6.png)

### 5、使用 Azure AD 账号单点登录观测云

所有配置完成后，即可使用单点登录到观测云。

1）打开观测云部署版登录地址，在登录页面选择 **Azure AD 单点登录**。

2）输入在 Keycloak 配置的邮箱地址。

3）更新登录密码。

4）登录到观测云对应的工作空间。

???+ attention

    - 若提示“当前账户未加入任何工作空间，请移步至管理后台将该账户添加到工作空间。”，则需要登录观测云管理后台为用户添加工作空间。

    > 更多详情可参考文档 [部署版工作空间管理](space.md)。
 
    ![](img/1.keycloak_15.png)

    在观测云管理后台为用户添加完工作空间后，用户即可开始使用观测云。

![](img/1.keycloak_14.png)


## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **基于 OpenID Connect 协议实现 Keycloak 账户单点登录观测云**</font>](./keycloak-sso.md)

</div>
