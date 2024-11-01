# 数据访问
---

观测云允许在应用级别来向工作空间成员的 RUM 数据访问权限进行限制。同时，通过引入正则表达式和脱敏字段，有效增强不同应用数据的安全防护，确保信息安全。


## 开始创建

1. 进入新建规则页面；
2. 输入规则名称；
3. 按需输入针对该规则的描述；
4. 选择应用 ID（仅能选择当前工作空间的应用），您可以直接运用全部应用或选择单个/多个应用，覆盖 Web、iOS、Android 等；
5. 定义当前规则下，RUM 数据的[访问范围](../management/logdata-access.md#scope)；

6. 添加需要脱敏的单个或多个字段；

7. 利用正则表达式针对字段内容中的敏感信息进行脱敏；
8. 选定当前访问规则可应用到的单个或多个成员角色，包含系统内默认角色及自建角色；
9. 点击保存。

<img src="../img/rum_data.png" width="70%" >


## 配置须知

在配置数据访问规则时，需注意三大逻辑：

- [数据访问范围](../management/logdata-access.md#scope)：即在访问规则内的成员只能访问与筛选条件匹配的数据。
- [正则表达式脱敏](../management/logdata-access.md#regex)：如果您需要在已框定数据范围的情况下再叠加一层数据保护，可设置正则表达式或脱敏字段向外屏蔽敏感数据；
- [角色场景与查询权限](../management/logdata-access.md#role_permission)：不同角色与不同规则的单个或叠加均会对数据访问规则的最终呈现效果产生不同结果。

## 管理列表

> 更多详情，可参考 [列表操作](../management/logdata-access.md#list)。

## 注意事项

**跨工作空间查询**：如果两个工作空间都包含同一应用，根据数据访问规则中的权限设置，特定角色只能查看已授权工作空间中该应用的筛选数据。

**前提**：`工作空间 A` 与`工作空间 B` 同时存在 `whytest-android` 这一应用，且`工作空间 B` 将 RUM 应用数据查看权限[授权](../management/data-authorization.md#site)给了`工作空间 A`。

在配置数据访问规则时（如下图），`工作空间 A` 限制“自定义管理”这一角色仅可查看 `whytest-android` 这一应用下 `source:kodo` 的数据。


<img src="../img/rum_data_1.png" width="80%" >

此时存在以下场景：

:material-numeric-1-circle: [RUM 查看器](./explorer/index.md)

由于该查看器暂不支持跨工作空间查询，所以“自定义管理”这一角色在 RUM 查看器仅可查看`工作空间 A` 的 `whytest-android` 这一应用下的 RUM 数据。

:material-numeric-2-circle: [仪表板](../scene/dashboard/config_page.md#cross-workspace)

当同时选择`工作空间 A` 与`工作空间 B` 进行数据查询，而在 DQL 中同时查询 `whytest-android` 与 `whytest-ios` 两个应用的数据。由于当前数据访问限制规则针对“自定义管理”这一角色进行访问限制，而`工作空间 B` 的 `whytest-android` 应用数据以及`工作空间 A` 与`工作空间 B` 的`whytest-ios` 应用数据未被配置访问权限。

因此，最终“自定义管理”这一角色仅能访问`工作空间 A` 的 `whytest-android` 应用数据。

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **日志数据访问权限控制**</font>](../management/logdata-access.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **查看器的强大之处**</font>](../getting-started/function-details/explorer-search.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **提升协作效率的快照**</font>](../getting-started/function-details/snapshot.md)

</div>


</font>
