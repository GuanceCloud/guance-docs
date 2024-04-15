# Azure AD 单点登录（部署版）
---


Azure Active Directory (Azure AD) 是 Microsoft 推出的基于云的标识和访问管理服务，可帮助企业管理内外部资源。


## 一、获取单点登录所需关键配置信息

通过 Azure AD 单点登录观测云部署版，需要三项关键配置信息：

| 配置      | 描述                          |
| ----------- | ------------------------------------ |
| wellKnowURL      | 应用对应的 OIDC Endpoints 配置地址，即完整的 `https://xxx.xxx.com/xx/.well-known/openid-configuration` 地址。                          |
| clientSecret      | 客户端密钥值。                          |
| clientId      | 应用程序(客户端) ID                    |

### 1、创建 Azure AD 应用程序

1）在 Microsoft 门户创建一个 Azure 账号。

进入 [Azure Active Directory 管理中心](https://portal.azure.com/)，点击管理 Azure Active Directory 下的**查看 > 应用注册**：

![](img/aad-1.png)

在**应用注册**页面，点击**新注册**：

![](img/aad-2.png)

2）创建新的应用程序

在**注册应用程序**页面输入**名称**，受支持的账户类型需选择**任何组织目录**，重定向 URI 选择 **Web**。点击**注册**，即可创建一个新的应用程序。如下图，定义该应用名称为 “观测云部署版”。

![](img/aad-3.png)

### 2、完成新应用程序基本配置

1）创建新应用程序后，默认进入**概述**页面。您可以在**应用注册 > 所有应用程序**下查看您所创建的应用程序。

![](img/aad-4.png)

<font color=coral>**注意：**</font>此处的<u>**应用程序(客户端) ID** 即为 OIDC 客户端配置中的 clientId</u>。

2）添加客户端凭据：

![](img/aad-5-1.png)

![](img/aad-5.png)

![](img/aad-5-2.png)

<font color=coral>**注意：**</font>此处列表中的<u>**值**即为 OIDC 客户端配置中的 clientSecret 值</u>，请立即保存！

3）进入**令牌配置 > 添加可选声明**页面，**添加组声明**。添加完毕之后，会产生一个 `groups` 记录。

![](img/aad-5-3-1.png)

同时分别对令牌类型**ID** 与**访问**选择图示声明，使登录的客户端能够拿到相关令牌数据。

![](img/aad-5-3.png)

![](img/aad-5-3-2.png)

4）添加 API 的作用域。进入**公开 API**，分别添加作用域：`User.Read`、`User.Read.All`、`GroupMember.Read.All`、`Group.Read.All`。点击**添加范围**，为当前这个应用客户端公开图示四个权限：

![](img/aad-5-4.png)

![](img/aad-5-5.png)

5）继上一步添加完毕四个作用域后，为客户端应用程序添加授权。进入 **API 权限**：

- 先选择微软接口权限：

![](img/aad-5-6.png)

- 再选择应用需要对应的权限：

![](img/aad-5-6-1.png)

需代表当前租户管理员同意授权：

![](img/aad-5-6-2.png)

<font color=coral>**注意：**</font>客户端 ID 即为**应用程序(客户端) ID**。

### 3、获取应用的 OIDC 协议端点访问地址信息

在**应用注册 > 终结点**，OIDC 客户端配置中的 WellKnowURL 取值为：`https://login.microsoftonline.com/consumers/v2.0/.well-known/openid-configuration`。

![](img/aad-5-7.png)

> 关于 OpenID 配置文档 URI 更多相关信息，可前往 [Microsoft 标识平台上的 OpenID Connect](https://learn.microsoft.com/zh-cn/azure/active-directory/develop/v2-protocols-oidc)。


<font color=coral>至此，三项关键配置信息已获取完毕。</font>


## 二、配置 Azure AD 应用内的用户组

![](img/aad-11.png)

1）回到主页，进入**组 > 新建组**；

![](img/aad-12.png)

2）选择**组类型**：

- 安全性：用于管理用户和计算机对共享资源的访问权限。

- Microsoft 365：通过向成员赋予对共享邮箱、日历、文件、SharePoint 站点等的访问权限，提供协作机会。

3）输入**组名**，按需添加组描述；

4）添加**所有者**或**成员**：  

- 选择“所有者”或“成员”下的链接，以填充目录中每个用户的列表；  
- 从列表中选择用户，然后点击窗口底部的“选择”按钮。

4）点击**创建**。

![](img/aad-13.png)

## 三、设置企业应用配置

1、进入您的应用，选择**概述 > 自助服务**。

![](img/aad-19.png)

2、选择允许用户请求访问此应用程序，并决定将已分配的用户添加到哪个组。

![](img/aad-20.png)

3、在您的**应用 > 用户和组**，添加需要登录的组和用户。

![](img/aad-21.png)

4、在您的**应用 > 单一登录**，可以查看到存在 `groups` 的属性声明。

![](img/aad-22.png)

## 三、在观测云 Launcher 配置关联 {#config}

1）在观测云 Launcher **命名空间：forethought-core > core** 中配置 Azure AD 的基本信息。

```
# OIDC 客户端配置(当该项配置中配置了 wellKnowURL 时, KeyCloakPassSet 配置项自动失效)
OIDCClientSet:
  # OIDC Endpoints 配置地址,即完整的 `https://xxx.xxx.com/xx/.well-known/openid-configuration` 地址.
  wellKnowURL:
  # 由认证服务提供的 客户端ID
  clientId:
  # 客户端的 Secret key
  clientSecret:
  # 认证方式，目前只支持 authorization_code
  grantType: authorization_code
  # 请求中的证书认证开关
  verify: false
  # 证书路径列表，依次填入 .crt 和 .key 文件路径
  cert:
  # 获取 token 接口的认证方式 basic: 位于请求头中的 Authorization 中; post_body: 位于请求body中
  fetchTokenVerifyMethod: basic
  # 数据访问范围
  scope: "openid profile email address"
  # 【内部配置用户无需调整】认证服务器认证成功之后的回调地址
  innerUrl: "{}://{}/oidc/callback"
  # 【内部配置用户无需调整】认证服务认证成功并回调 DF 系统之后，DF系统拿到用户信息后跳转到前端中专页面的地址
  frontUrl: "{}://{}/tomiddlepage?uuid={}"
  # 从认证服务中获取到的账号信息 与 DF 系统账号信息字段的映射关系配置, 其中必填项为: username, email, exterId； 可选项为: mobile
  mapping:
    # 认证服务中，登录账号的用户名字段名，必填，如果值不存在，则取 email
    username: preferred_username
    # 认证服务中，登录账号的邮箱字段名，必填
    email: email
    # 认证服务中，登录账号的手机号字段名，选填
    mobile: phone_number
    # 认证服务中，登录账号的唯一标识字段名， 必填
    exterId: sub
```

参考示例图：

![](img/aad-14.png)

???+ abstract "**客户端 ID** 和**客户端密钥值**可在下图位置中获取"

    ![](img/aad-15.png)

    ![](img/aad-16.png)


2）在观测云 Launcher **命名空间：forethought-webclient > frontNginx** 中配置跳转信息。

```
server {
        listen 80;
        # 注意，此处的 server_name 服务名是 前端访问地址域名
        server_name cloudcare.cn, daily-ft2x.cloudcare.cn;
        location / {
           root /config/cloudcare-forethought-webclient;
           index index.html;
           try_files $uri $uri/ /index.html;
           if ($request_filename ~* .*\.(?:htm|html)$)
            {
                add_header Cache-Control "no-cache, no-store";
            }
        }
         
        # =========OIDC协议 跳转相关配置开始=========
        # 请求直接跳转至 Inner API 的接口 =========开始=========
        # 这个地址是用于 第三方登录时的访问地址；可视情况自行变更，但 proxy_pass 对应的路由地址不可改
        location /oidc/login {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/oidc/login;
        }
         
        # 这个地址是用于 第三方服务通过 OIDC 协议认证通过之后，回调本服务的当前地址；该地址与 【3.2.1】配置中 OIDCClientSet 配置项下的 innerUrl 配置直接关联；该地址变更时应与 innerUrl 同步变更； proxy_pass 对应值不可改
        location /oidc/callback {
            proxy_connect_timeout 5;
            proxy_send_timeout 5;
            proxy_read_timeout 300;
            proxy_http_version 1.1;
            proxy_set_header Connection "keep-alive";
            add_header Access-Control-Allow-Origin *;
            add_header Access-Control-Allow-Headers X-Requested-With;
            add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
            proxy_pass http://inner.forethought-core:5000/api/v1/inner/oidc/callback;
       }
       # =========OIDC协议 跳转相关配置结束=========
}
```

参考示例图：

![](img/aad-17.png)

3）在观测云 Launcher **命名空间：forethought-webclient > frontWeb** 中配置 Azure AD 用户登录观测云部署版的入口地址。

```
window.DEPLOYCONFIG = {
 
    ......
    paasCustomLoginInfo:[
        {url:"http://<server_name>/oidc/login",label:"第三方认证 登录按钮标签"}
    ]
     
    ......
 
};
```

**注意**：`server_name` 即观测云登录页地址中的域名。

参考示例图：

![](img/aad-18.png)

1) 配置完成后，勾选更新的**修改配置**，并确认重启。

![](img/1.keycloak_6.png)

## 四、使用 Azure AD 账号单点登录观测云

所有配置完成后，即可使用单点登录到观测云。

1）打开观测云部署版登录地址，在登录页面选择 **Azure AD 单点登录**。

2）输入在 Azure AD 配置的邮箱地址。

3）更新登录密码。

4）登录到观测云对应的工作空间。

???+ warning

    - 若提示“当前账户未加入任何工作空间，请移步至管理后台将该账户添加到工作空间。”，则需要登录观测云管理后台为用户添加工作空间。

    > 更多详情，可参考 [部署版工作空间管理](space.md)。
 
    ![](img/1.keycloak_15.png)

    在观测云管理后台为用户添加完工作空间后，用户即可开始使用观测云。

![](img/1.keycloak_14.png)


## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **基于 OpenID Connect 协议实现 Keycloak 账户单点登录观测云**</font>](./keycloak-sso.md)

</div>
