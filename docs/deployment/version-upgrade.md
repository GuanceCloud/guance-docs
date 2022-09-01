# 1 升级安装
## 1.1 Launcher 服务升级
升级 观测云，首先第一步是升级 **Launcher** 服务，获取到需要升级的目标版本的 **Launcher** 服务镜像，最新版 Launcher 镜像地址可查看文档  [社区版本部署镜像](https://www.yuque.com/dataflux/doc/rtm) ，在**运维操作机**上执行以下命令，升级 **Launcher**：
```yaml
kubectl patch deployment launcher -p '{"spec": {"template": {"spec": {"containers": [{"image": "{{ Launcher 镜像地址 }}", "name": "launcher"}]}}}}' -n launcher
```
执行以下命令，将 **launcher** 副本上设置为 1：
```yaml
kubectl scale deployment -n launcher --replicas=1  launcher
或
kubectl patch deployment launcher -p '{"spec": {"replicas": 1}}' -n launcher
```
## 1.2 升级应用
在**安装操作机**的浏览器上访问 **launcher.dataflux.cn**，根据安装引导步骤完成 观测云 的升级。
### 1.2.1 新增应用配置
**launcher** 自动检测当前的 观测云 版本，到目标升级版本之间，新增加的应用配置，并列出，根据配置模板，修改相应的值后，点击“检查完毕，生成配置”。
![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021972019-a60353ec-bb11-49df-8f9d-5e9995099355.png#crop=0&crop=0&crop=1&crop=1&id=mQcNU&originHeight=563&originWidth=1269&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)


### 1.2.2 升级应用配置

- **launcher** 自动检测当前的 DataFlux 版本，到目标升级版本之间，有更新的应用配置，根据列出的更新内容，修改相应的值。

![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021972293-6ee556da-ce7c-4001-bac5-9470fc3ca2ab.png#crop=0&crop=0&crop=1&crop=1&id=VcwsP&originHeight=561&originWidth=1185&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

- 展开标记有 **配置有更新** 的配置项，左侧列出了需要升级的历史版本，右侧是应用当前的配置，根据左侧的配置升级描述，在右侧修改配置内容。

![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021972957-e7ac0ad3-1aea-441f-8556-1313e7b7e489.png#crop=0&crop=0&crop=1&crop=1&id=AUBFe&originHeight=659&originWidth=1268&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

- 同时也可以修改未标记**配置有更新**的应用配置，勾选**升级配置**选项后，可以修改配置。
- 确认所有配置修改完毕后，点击 **确认升级配置** 按钮升级配置。

### 1.2.3 升级数据库
**launcher** 自动检测当前的 DataFlux 版本，到目标升级版本之间，有数据库升级的应用，并列出每个版本的数据库升级内容，点击**确认升级**：
![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021973419-3043cfee-b974-4b75-9681-1ed72896f17b.png#crop=0&crop=0&crop=1&crop=1&id=ADptV&originHeight=733&originWidth=1268&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

### 1.2.4 升级应用
**launcher** 自动检测当前的 观测云 版本，到目标升级版本之间，有升级或者是新增加的应用，并显示当前版本与目标升级版本的镜像版本对比，点击**确认升级应用**：
![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021973990-d4aaae8c-c9fb-4c07-aa2c-d89c970a9e0f.png#crop=0&crop=0&crop=1&crop=1&id=IsxPR&originHeight=733&originWidth=1269&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

### 1.2.5 应用启动状态
显示所有更新或者新增加的应用启动状态，等全部启动完毕，即完成了此版本 观测云 的升级安装。
![](https://cdn.nlark.com/yuque/0/2021/png/21511589/1636021974445-a71405c3-b49a-4cba-a57b-bf9128beb635.png#crop=0&crop=0&crop=1&crop=1&id=Hq4iL&originHeight=729&originWidth=1269&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)

**注意：服务重启过程中，必须停留在此页面不要关闭，到最后看到“版本信息写入成功”的提示，且没有弹出错误窗口，才表示升级成功！**
## 1.3 很重要的步骤！！！
升级完成后，进行升级后的验证，验证无误后一个很重要的步骤，将 launcher 服务下线，防止被误访问而破坏应用配置，可在**运维操作机**上执行以下命令，将 launcher 服务的 pod 副本数设为 0：
```yaml
kubectl scale deployment -n launcher --replicas=0  launcher
或
kubectl patch deployment launcher -p '{"spec": {"replicas": 0}}' -n launcher
```



---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png#clientId=ucc58c24e-d7a9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f1c3a96&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u420e6521-1eac-4f17-897f-53a63d36ff8&title=)
