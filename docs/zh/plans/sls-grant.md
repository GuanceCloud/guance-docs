# 如何使用 SLS 授权文件给 RAM 账号授权

---

## 背景

本篇内容是从 0 开始创建一个 RAM 账号并授权，若之前有进行过相关操作跳过即可。

## 步骤

1、<<< custom_key.brand_name >>>一键开通 SLS 专属版的注册流程中下载 SLS 授权文件，打开后复制该 JSON 备份，后续会用到。

> 关于开通流程，可参考文档 [阿里云市场开通<<< custom_key.brand_name >>>专属版](../commercial-aliyun-sls.md)；

![](../img/1.sls_6.jpeg)

2、通过您的主账号登录阿里云并进行实名认证（若没有提示则说明已经认证过了）；

3、右上角头像下拉，点击 **AccessKey 管理**；

![](../img/1.RAM.png)

4、开始使用子用户 AccessKey；

![](../img/2.RAM.png)

5、创建 AccessKey；

**注意**：由于AccessKey Secret 只能查看一次，创建完成后建议复制出来备份。

![](../img/3.RAM.png)

6.在 **RAM 访问控制 > 用户**，创建 RAM 用户并点击添加权限；

![](../img/4.RAM.png)

7、点击新建权限策略；

![](../img/5.RAM.png)

8、点击脚本编辑，把第一步复制的 JSON 粘贴到这里；

![](../img/6.RAM.png)

9、将这个权限策略添加到授权；

![](../img/7.RAM.png)

10、为阿里云账号开通日志服务；

![](../img/8.RAM.png)
