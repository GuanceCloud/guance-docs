# 常见问题


:material-chat-question: 在绑定 SLS Logstore 索引时，如何确认在阿里云市场授权成功？

您可以在请求授权页面，点击前往 **RAM 控制台**；

![](img/index-4.png)

在**角色**可查看已被授权的角色；在**授权**可查看已授权的主体和权限策略。

![](img/index-role.png)

![](img/index-auth.png)

---

:material-chat-question: 在绑定 SLS Logstore 索引时，为何输入阿里云账号 ID 后，无法自动获取 Project 和 Logstore？

**只有您的阿里云账号开通了 SLS 日志服务并完成授权**，才会自动获取 Project 和 Logstore。

**注意**：以 `/guance-wksp-` 为前缀的 Project 会被自动过滤，不会列出；如果您的 Project 下没有所属 Logstore，将不会自动获取。

---

:material-chat-question: 工作空间 1 的索引授权给工作空间 2 后，需要取消授权，如何操作？

撤销索引的授权分以下两种情况：

:material-numeric-1-circle: 授权范围仅有日志数据

只授权了日志，可直接在授权列表点击**删除**，即可撤销对“工作空间 2” 的全部索引项授权。

![](img/cross-workspace-index-3.png)

:material-numeric-2-circle: 授权范围包含别的数据

若授权范围包含除日志以外的其他数据类型，可点击**编辑**，将日志项从授权范围中删除。

**注意**：

- 数据范围中删除日志后，日志索引输入域也会同步关闭。
- 索引删除后，相当于删除日志数据的授权。也就意味着“工作空间 1” 的所有日志数据和“工作空间 2” 不互通，“工作空间 2” 的日志查看器中选择工作空间时将无法选到“工作空间 1”。

![](img/cross-workspace-index-4.png)

---

:material-chat-question: 操作授权索引正常，但是在被授权工作空间的日志查看器中无法查询到此索引。

1. 进入**授权工作空间 > 日志 > 索引**，确认此索引状态是否正常，是否已被删除。

2. 进入授权工作空间，点击**管理 > 跨工作空间授权**，查看索引授权是否正常。

**注意**：被删除的索引无法在跨工作空间查询中被引用。

---

:material-chat-question: 如何查询其他工作空间的外部日志索引？

1. 需界定，外部索引是从[外部渠道（SLS Logstore 、Elasticsearch、OpenSearch）](./multi-index/index.md)绑定到观测云平台。

2. 因此，需要使用何种外部索引，直接绑定此外部索引到本工作空间下即可，使用时在日志查看器选择默认的当前工作空间，选取对应外部索引进行查询即可。