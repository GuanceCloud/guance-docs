---

## 简介

工作空间基于多用户设计，可隔离不同单元数据。同时支持选择工作空间的数据存储策略，查看、添加和删除工作空间成员。

## 新建工作空间

在「工作空间列表」，点击右上角「新建工作空间」。
![23.admin_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1659662376627-15071f47-d458-47ca-83b2-4a952684b29e.png#clientId=u03167591-b384-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ub1524961&margin=%5Bobject%20Object%5D&name=23.admin_1.png&originHeight=663&originWidth=1413&originalType=binary&ratio=1&rotation=0&showTitle=false&size=125951&status=done&style=stroke&taskId=uec65de28-c064-4117-bca4-96f603f559b&title=)

在弹出的对话框中，填入“名称”，选择是否开启“索引合并”，选择“数据的保留时长”、“空间拥有者”和“空间管理员”，点击「确定」即可创建一个新的工作空间。

- **空间拥有者：**拥有工作空间最高操作权限，可以指定当前空间“管理员”并进行任意的空间配置管理，包括升级空间付费计划、解散当前空间。
- **空间管理员：**当前工作空间的管理者，可以设置用户权限为“只读成员”或“标准成员”，具有空间配置管理的权限，包括：访问当前工作空间的付费计划与清单；对工作空间的基本设置、成员管理、通知对象管理进行操作；对数据的采集、禁用/启用、编辑、删除等进行管理等；不包括升级空间付费计划、解散当前空间。
- **索引合并：**采集的数据根据数据类型不同会创建不同的索引，索引越多数据存储量越大，为了节约数据存储空间，可开启工作空间的索引合并。
   - 索引合并开启，该工作空间按照指标、日志/CI 监测/可用性监测/安全巡检、备份日志、事件、用户访问/应用性能（trace、profile）创建对应的数据索引；
   - 索引合并关闭，该工作空间按照指标、日志、备份日志、事件、应用性能、用户访问、安全巡检创建对应的数据索引；
   - **调整索引合并，工作空间的对应旧索引及历史数据即将做删除操作，删除后数据将无法恢复。**

注意：添加工作空间时，可暂不指定空间管理员。后续可在「工作空间列表」页面中点击「查看成员」-「添加用户」进行设置。

- 索引合并开启状态下添加工作空间

![11.workspace_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1655876564691-6ee71781-69b1-45d7-8d02-604fa272d8d9.png#clientId=u9e4a197f-8378-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1b921d02&margin=%5Bobject%20Object%5D&name=11.workspace_1.png&originHeight=719&originWidth=709&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63280&status=done&style=none&taskId=u92c3cd86-1c89-43a4-a0e7-2f43043079a&title=)

- 索引合并关闭状态下添加工作空间

![11.workspace_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1655877821894-fcfdd475-1707-4446-a5fe-199ee605bdfa.png#clientId=u9e4a197f-8378-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ubba25be4&margin=%5Bobject%20Object%5D&name=11.workspace_2.png&originHeight=719&originWidth=712&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60897&status=done&style=none&taskId=uc9f0a9c5-c9bb-403b-82ae-33f458ac5ea&title=)

## 管理工作空间

### 搜索

「工作空间列表」页面可查看所有工作空间的基本信息。支持按空间名称关键字进行搜索查找。

### 索引配置

点击「索引配置」，进入对应的索引配置页面，支持针对当前工作空间的所有索引模板做 “主分片” 、“分片大小”、“副本分片” 的调整。
![23.admin_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1659662416775-46b8bfcd-0b75-449e-859e-3c21f7429dc1.png#clientId=u03167591-b384-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u25288c68&margin=%5Bobject%20Object%5D&name=23.admin_2.png&originHeight=433&originWidth=1427&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61330&status=done&style=stroke&taskId=u8b8cbdfc-de98-46a5-98e2-8cf2f020cf8&title=)
点击数据类型右侧的「配置」按钮，支持自定义配置该数据类型的 “主分片” 、“分片大小”，支持是否“开启副本”。 
注意：开启副本后，默认会给索引分片创建一份冗余的副本。
![23.admin_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1659662422950-c728ddca-1e77-4905-bfb4-fdd43c15d77e.png#clientId=u03167591-b384-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc13f011b&margin=%5Bobject%20Object%5D&name=23.admin_3.png&originHeight=340&originWidth=715&originalType=binary&ratio=1&rotation=0&showTitle=false&size=25000&status=done&style=stroke&taskId=u7cca898a-7a3e-46f1-b8e5-3e35aaa964c&title=)

### 查看成员

点击「查看成员」，进入对应的工作空间成员页面，可以查看到该空间下的所有成员基本信息。支持按邮箱账号或姓名进行搜索查找。

![17.manage_4.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648547528945-12ad7287-3f47-4dac-ade3-227233c914e4.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue7e2d62b&name=17.manage_4.1.png&originHeight=315&originWidth=1217&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47087&status=done&style=stroke&taskId=u07e82189-4ba0-4811-b86c-0a805565600&title=)

#### 添加成员

在工作空间成员列表，点击右上角「添加用户」，选择成员并设置好权限后，点击「确定」即可在此空间中添加一名新成员。

**注意：此处可添加成员为系统内已存在的成员，若为系统新成员，需到「用户」-「添加用户」页面中添加成功后，再返回此处进行操作。**

![17.manage_5.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648547590048-0e812f2e-ec22-4e5d-b80f-fa83a854d956.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u4b0d3414&name=17.manage_5.1.png&originHeight=373&originWidth=673&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27481&status=done&style=stroke&taskId=ucbd3ccb0-b39a-40db-bc4e-918324f2f7f&title=)


#### 编辑和删除成员

-  点击「修改权限」，即可修改成员的权限。 
-  点击「删除」，即可从该工作空间中删除此成员。

注意：一个工作空间只能有一个“拥有者”，修改其他成员为“拥有者”，原“拥有者”降级为“管理员”
![17.manage_6.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648547795952-4560eafd-128a-435a-90ab-e9002ab7b854.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8233c361&name=17.manage_6.png&originHeight=293&originWidth=672&originalType=binary&ratio=1&rotation=0&showTitle=false&size=24000&status=done&style=stroke&taskId=u9fd08215-c185-4440-bfdf-ca413624ac8&title=)

#### 批量编辑和删除成员

在选择多个成员后，点击右上角的「设置」或「删除」图标，可统一修改成员权限和批量删除所选成员。

![17.manage_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648548104127-6a9a086c-6cc7-4979-9b8d-02197efb3056.png#clientId=u6e0cb999-1f90-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ufe9c14f4&name=17.manage_7.png&originHeight=492&originWidth=1227&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60169&status=done&style=stroke&taskId=ud202af37-2550-4336-9c87-b1906eb404c&title=)

### 修改

在「工作空间列表」，点击工作空间右侧的「修改」可编辑该工作空间的名称和索引合并。

![11.workspace_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1655878308870-9b242491-208c-4536-a28a-f1122efab6f5.png#clientId=u9e4a197f-8378-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud50e4e08&margin=%5Bobject%20Object%5D&name=11.workspace_3.png&originHeight=604&originWidth=714&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50137&status=done&style=none&taskId=uf7e1a4be-3fe9-4d16-a02a-54061864915&title=)
### 删除

进入「工作空间列表」，点击工作空间右侧的「删除」即可删除对应的工作空间。



---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png#clientId=ucc58c24e-d7a9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f1c3a96&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u420e6521-1eac-4f17-897f-53a63d36ff8&title=)
