# 数据转发至华为云 OBS
---

## 开始配置


1. 存档类型选择**华为云 OBS**，即表示将匹配到规则的日志自动转发到外部 OBS；

2. 在**配置华为云资源访问授权**，须使用观测云为您提供的专属华为云账号 ID `f000ee4d7327428da2f53a081e7109bd`，[前往添加跨账号访问授权策略](../obs-config.md)；

3. 选择地区；

4. 在**存储桶**，输入您在华为云的桶名称；

5. 点击**确定**，即可创建成功。

![](../img/back-8.png)

**注意**：海外站点的账号 ID 与中国站点不同，请作区分：

| 站点 | ID    |
| ---------- | ------------- |
| 中国香港 | 25507c35fe7e40aeba77f7309e94dd77    |
| 俄勒冈 | 25507c35fe7e40aeba77f7309e94dd77    |
| 新加坡 | 25507c35fe7e40aeba77f7309e94dd77    |
| 法兰克福 | 25507c35fe7e40aeba77f7309e94dd77    |

<!--
## 添加桶授权

1、[登录华为云控制台](https://auth.huaweicloud.com/authui/login.html?service=https://console.huaweicloud.com/console/#/login)。

2、在**服务列表**页面，找到**对象存储服务**，进入**并行文件系统**页面，即进入桶：

![](../img/obs.png)

3、选择目标文件系统，进入**访问权限控制 > ACL**：

![](../img/obs-1.png)

4、点击**增加**，进入**新增账号授权**页面。

4.1 填写被授权的华为云账号 ID，勾选桶访问权限和 ACL 访问权限，点击确定即可：

**注意**：此处的账号 ID 即观测云为您提供的专属华为云账号 ID：`f000ee4d7327428da2f53a081e7109bd`

![](../img/obs-2.png)

5、若没有下载权限，需要勾选上**对象读权限**，点击**确定**即可。

![](../img/obs-3.png)

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 什么是桶策略？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 在华为云，如何对其他帐号授予桶的读写权限？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)


</div>
-->