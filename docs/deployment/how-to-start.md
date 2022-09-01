---

观测云社区版部署完成以后，需要进行配置并激活社区版才能开始使用。

## 前提条件

您可以参考文档 [云上部署](https://www.yuque.com/dataflux/rtm/owi0v8) 或者 [线下环境部署](https://www.yuque.com/dataflux/rtm/zy5pdk)  或者 [阿里云计算巢部署](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m)，进行线上或者线下部署。部署完成后，您可以获得以下观测云社区版相关平台的登录方式。

- dataflux 【**用户前台（观测云）**】
- df-management 【**管理后台**】
- df-func 【**Func 平台**】
- df-openapi 【**OpenAPI**】

## 方法步骤

### Step1：部署 DataWay

观测云社区版部署完成后，需要先部署 DataWay，才能通过 DataWay 来上报数据到观测云社区版工作空间。在这期间我们会有一个 DataWay 数据网关地址，用于激活社区版。

#### 新建 DataWay
使用管理员账号，进入“**观测云管理后台**”的“**数据网关**”菜单，点击“新建 DataWay”，添加一个数据网关 DataWay 。

- **名称**：自定义名称即可
- **绑定地址**：DataWay 的访问地址，在 DataKit 中接入数据使用，可以使用 `http://ip+端口`

**注意：在配置 DataWay 绑定地址时，必须保证 DataKit 主机与这个 DataWay 地址的连通性，能通过这个 DataWay 地址上报数据。**
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1648095586746-d866ceb0-a0ac-4131-b932-dc64e80d6134.png#clientId=u0470c319-ecb8-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=879&id=aKJpr&margin=%5Bobject%20Object%5D&name=image.png&originHeight=879&originWidth=1167&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94923&status=done&style=none&taskId=ufd7fe563-c34a-4bcd-8291-fa3cbec4fb2&title=&width=1167)

#### 安装 DataWay
DataWay 添加完成后，可获取到一个 DataWay 的安装脚本，复制安装脚本，在部署 DataWay 的主机上运行安装脚本。

**注意：此处需要确保部署 DataWay 的这台主机，能访问到前面配置的 kodo 地址，建议 DataWay 通过内网到 kodo！**
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1648096120840-64a45e0a-3a16-42a4-bafd-4449494afc4d.png#clientId=u0470c319-ecb8-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=982&id=DJmiH&margin=%5Bobject%20Object%5D&name=image.png&originHeight=982&originWidth=1156&originalType=binary&ratio=1&rotation=0&showTitle=false&size=112925&status=done&style=none&taskId=u53919af1-8f78-4063-b682-380de144f46&title=&width=1156)
安装完毕后，等待片刻刷新“数据网关”页面，如果在刚刚添加的数据网关的“版本信息”列中看到了版本号，即表示这个 DataWay 已成功与观测云中心连接，前台用户可以通过它来接入数据了。
![21.dataway_2.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648558605350-2a8c89d2-f408-48b3-86ed-b08669b5f284.png#clientId=u393899ca-ea0d-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u15eb097d&name=21.dataway_2.1.png&originHeight=447&originWidth=1200&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52840&status=done&style=stroke&taskId=u2709ffa4-a273-4812-847f-2f5f5b35db1&title=)

### Step2：激活社区版

#### 注册社区版账号
打开社区版注册网址（[https://boss.guance.com/index.html#/signup?type=community](https://boss.guance.com/index.html#/signup?type=community)），根据提示注册社区版账号。
![13.community_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805060711-c4ac0eea-0326-4945-b2d4-d1810dbd15b5.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud0f3d634&margin=%5Bobject%20Object%5D&name=13.community_1.png&originHeight=595&originWidth=693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53431&status=done&style=stroke&taskId=u248f9f55-52eb-428a-9506-de7322faba9&title=)
注册完成后，进入观测云社区版费用中心。
![13.community_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805744575-47205c41-6934-479a-9637-6f0621591965.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3e7d04db&margin=%5Bobject%20Object%5D&name=13.community_2.png&originHeight=436&originWidth=1430&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54498&status=done&style=stroke&taskId=u0d62100b-dcf7-4085-9fdb-72f95fbc2cc&title=)

#### 获取 AK/SK

在观测云社区版费用中心的“AK 管理”，点击“创建 AK”。
![13.community_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805750605-2b922e66-4950-40ad-8b2d-7242f1dc0048.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u372c9f85&margin=%5Bobject%20Object%5D&name=13.community_3.png&originHeight=408&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60286&status=done&style=stroke&taskId=u90418e28-5666-4379-bfad-bcc670221de&title=)
#### 获取 License

在观测云社区版费用中心的“License 管理”，点击“创建 License”。
![13.community_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805942748-8e71583b-6014-469e-a9c2-51ec27d384ce.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u99e59019&margin=%5Bobject%20Object%5D&name=13.community_4.png&originHeight=404&originWidth=1429&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57738&status=done&style=stroke&taskId=u28263956-928e-48bc-ad80-d0257e2d60f&title=)
#### 激活社区版
打开观测云 Launcher，在右上角设置，点击“License 激活及 AK/SK 配置”。
![1.launcher_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650365861656-e63972eb-0cba-4eef-b008-80f65ee89ce1.png#clientId=u06a8da02-f67c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=jcbma&margin=%5Bobject%20Object%5D&name=1.launcher_1.png&originHeight=663&originWidth=1312&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134043&status=done&style=stroke&taskId=ua994e810-3bfc-49ce-a27c-3193c04d8a0&title=)
在观测云 Launcher 的“观测云激活”对话框中，填入 AK/SK、License 和 数据网关地址，完成社区版激活。
注意：您可以扫码关注观测云服务号，获取更多观测云的官方信息。
![13.community_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650806605707-bbfded2d-b528-40ec-84df-a49f46efe9ab.png#clientId=u4b724c7d-6e6e-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=nqD9V&margin=%5Bobject%20Object%5D&name=13.community_5.png&originHeight=624&originWidth=888&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103460&status=done&style=stroke&taskId=u9540d53c-f36a-43ce-95fd-06dfb3e0374&title=)

### Step3：开始使用观测云
#### 
#### 创建用户
观测云部署版，不提供用户注册功能，需要登录“**观测云管理后台**”的“**用户**”菜单，点击“添加用户”来添加用户。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1648094765009-7191af6c-ef93-45f2-9137-3941a2274eb7.png#clientId=u0470c319-ecb8-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=333&id=uaf100d15&margin=%5Bobject%20Object%5D&name=image.png&originHeight=333&originWidth=1301&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54166&status=done&style=stroke&taskId=uc8acc2ae-15f1-4b99-bc64-b4b9c4172ec&title=&width=1301)
#### 创建工作空间
添加完用户以后，在“**观测云管理后台**”的“**工作空间列表**”菜单，点击“新建工作空间”，继续创建一个工作空间。
**注意：默认的“系统工作空间”不要作为日常业务上的观测使用！**
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1648094933435-ed0d2325-be5d-4743-b584-9d92c77e77e0.png#clientId=u0470c319-ecb8-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1127&id=u809534f5&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1127&originWidth=1305&originalType=binary&ratio=1&rotation=0&showTitle=false&size=125942&status=done&style=none&taskId=uc835732b-a93c-4b5e-9a27-e8f4f2cb2a0&title=&width=1305)
#### 添加工作空间成员
创建完工作空间以后，点击「查看成员」，进入对应的工作空间成员页面，可以查看到该空间下的所有成员基本信息。
![17.manage_4.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648547528945-12ad7287-3f47-4dac-ade3-227233c914e4.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue7e2d62b&name=17.manage_4.1.png&originHeight=315&originWidth=1217&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47087&status=done&style=stroke&taskId=u07e82189-4ba0-4811-b86c-0a805565600&title=)
在工作空间成员列表，点击右上角「添加用户」，选择新添加的用户并设置好权限后，点击「确定」即可在此空间中添加一名新用户。

![17.manage_5.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648547590048-0e812f2e-ec22-4e5d-b80f-fa83a854d956.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u4b0d3414&name=17.manage_5.1.png&originHeight=373&originWidth=673&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27481&status=done&style=stroke&taskId=ucbd3ccb0-b39a-40db-bc4e-918324f2f7f&title=)
#### 登录观测云
打开观测云社区版访问地址，即可使用以上创建的用户登录到对应的工作空间开始使用观测云的所有功能。详细功能使用介绍可参考 [观测云帮助手册](https://www.yuque.com/dataflux/doc) 。

![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650374516786-63cac032-6986-4a5a-922d-03bb7d25bcb2.png#crop=0&crop=0&crop=1&crop=1&from=url&id=qCNo8&originHeight=783&originWidth=1418&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)



---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png#clientId=ucc58c24e-d7a9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f1c3a96&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u420e6521-1eac-4f17-897f-53a63d36ff8&title=)
