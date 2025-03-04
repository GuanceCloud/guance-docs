# 华为云 OBS 桶授权

## 具体操作

1、[登录华为云控制台](https://auth.huaweicloud.com/authui/login.html?service=https://console.huaweicloud.com/console/#/login).

2、在**服务列表**页面，找到**对象存储服务**，进入**并行文件系统**页面，即进入桶：

![](img/obs.png)

3、选择目标文件系统，进入**访问权限控制 > ACL**：

![](img/obs-1.png)

4、点击**增加**，进入**新增账号授权**页面。

4.1 填写被授权的华为云账号 ID，勾选桶访问权限和 ACL 访问权限，点击确定即可：

**注意**：此处的账号 ID 即<<< custom_key.brand_name >>>为您提供的专属华为云账号 ID：`f000ee4d7327428da2f53a081e7109bd`

![](img/obs-2.png)

5、若没有下载权限，需要勾选上**对象读权限**，点击**确定**即可。

![](img/obs-3.png)

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 什么是桶策略？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 在华为云，如何对其他帐号授予桶的读写权限？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)

</div>
