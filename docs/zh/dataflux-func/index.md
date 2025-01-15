---
icon: zy/dataflux-func
---

# DataFlux Func
---

DataFlux Func 是一个基于 Python 的脚本开发、管理、执行平台。是[观测云](https://guance.com/)下属的一个函数计算组件，目前已成为可独立运行的系统。

主要分为 2 个部分：

- Server：使用 Node.js + Express 构建，主要提供 Web UI 服务、对外 API 接口。
- Worker：使用 Python3 + Celery 构建，主要提供 Python 脚本的执行环境（内含 Beat 模块）。


## 开始安装

选择下载对应安装包，[快速开始](https://func.guance.com/doc/quick-start/)部署 Func 平台。

部署完成后，等待初始化完成，登录进入平台。

### :material-numeric-1-circle: 添加连接器

通过连接器，帮助开发者连接观测云系统或其他数据库。

进入开发 > 连接器 > 添加连接器页面：

<img src="../img/get_func.png" width="70%" >


1. 选择连接器类型；
2. 自定义该连接器的 [ID](https://func.guance.com/doc/development-guide-basic-conception/#2)，如 `guance_test`；
3. 添加标题。该标题将同步展示在观测云工作空间内；
4. 按需输入该连接器的描述；
5. 选择观测云[节点](https://func.guance.com/doc/ui-guide-development-module-guance-node/)；
6. 添加 [API Key ID 和 API Key](#api-key-how_to_get_api_key)；
7. 按需测试连通性；
8. 点击保存。

#### 如何获取 API Key {#how_to_get_api_key}

1. 进入观测云工作空间 > 管理 > API Key 管理；
2. 点击页面右侧**新建 Key**。
3. 输入名称；
4. 点击确定。系统此时将会为您自动创建一个 API Key，您可在 API Key 中查看。

<img src="../img/get_func_1.png" width="70%" >

> 更多详情，可参考 [API Key 管理](../management/api-key/index.md)。

### :material-numeric-2-circle: 使用连接器

正常添加连接器后，即可在脚本中使用连接器 ID 获取对应连接器的操作对象。

以上文 ID 为 `guance_test` 的连接器为例，获取该连接器操作对象的代码为：

```
mysql = DFF.CONN('mysql')
```

<img src="../img/get_func_2.png" width="70%" >


### 示例


