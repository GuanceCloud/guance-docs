# 如何使用 TLS 授权文件给 lAM 账号授权
---

## 背景

本篇内容是从 0 开始创建一个 lAM 账号并授权，若之前有进行过相关操作跳过即可。

## 步骤

1、在<<< custom_key.brand_name >>>[绑定火山引擎 TLS 外部索引](./multi-index/tls.md)的页面点击下载授权文件，打开后复制该 JSON 备份，后续会用到。

2、登录您的火山引擎主账号并进行实名认证。

**注意**：若未出现提示，则说明您已经认证完成。

3、右上角头像下拉，点击 API 访问密钥。

<img src="../img/api.png" width="60%" >

4、点击新建密钥，去新建子用户。

![](img/new-user.png)

5、创建用户，可通过当前用户名创建，也可邀请其他账号进行创建。

*下图为通过用户名创建：*

![](img/via-name.png)

6、输入子用户必要信息后点击下一步。

**注意**：登录设置中需勾选“编程访问”。

![](img/next.png)

7、权限设置中，不勾选权限策略；作用范围选择“全局”。

![](img/all.png)

8、审阅完成并进行手机号码校验后，可查看 AK、AKS 信息并进行下载。

![](img/download.png)

9、点击策略管理，新建自定义策略。

![](img/strategy.png)

10、点击 JSON 编辑器，输入策略名称，把第一步复制的 JSON 粘贴到这里，点击提交。

![](img/json-tls.png)

11、提交成功后，点击添加授权将该权限策略添加到已申请的子用户下进行授权。

12、为火山引擎账号开通日志服务。

![](img/open.png)