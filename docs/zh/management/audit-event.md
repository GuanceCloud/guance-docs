# 审计事件逻辑详解
---

操作审计帮助您监控并记录所有成员在<<< custom_key.brand_name >>>工作空间内的访问行为，包括通过<<< custom_key.brand_name >>>控制台、OpenAPI 对工作空间内的登录访问和操作使用行为。

**审计事件范围**：

- 用户登录访问行为记录；
- 用户操作行为记录；
- 审计事件 DQL 查询示例。

**审计事件查询 DQL**：

```
TAE::re(`.*`):(`*`){ `df_source` IN ['audit'] }
```

## 字段说明

| 字段名 | 类型 | 是否必须 | 说明 |
| --- | --- |--- | --- |
| `date` | Int | 必须 | 产⽣时间，Unix 时间戳，单位 ms |
| `df_date_range` | Int | 必须 | 时间范围，单位 s |
| `df_source` | Str | 必须 | 数据来源，操作事件取值 audit |
| `df_status` | Str | 必须 | 状态，操作事件默认取 info |
| `df_origin` | Str | 必须 | 操作来源，用于记录当前操作来源入口 |
| `df_menu` | Str | 必须 | 用户访问的菜单路径，例如：日志 > 查看器 |
| `df_event_id` | Str | 必须 | 事件唯一 ID |
| `df_title` | Str | 必须 | 标题 |
| `df_message`	 | Str | 必须 | 描述 |
| `df_user_id` | Str | 必须 | 用户 ID |
| `df_user_name` | Str | 必须 | 用户姓名 |
| `df_user_email` | Str | 必须 | 用户邮箱，对应“成员管理”的 ID、name、email |
| `df_user_team` | Str | 必须 | 用户当下所属团队 |
| `df_role_scope` | Str | 必须 | 用户当下所拥有的角色范围 |
| `df_operation_id` | Str | 必须 | 当前审计对应的实际操作项唯一 ID |
| `df_operation_name` | Str | 必须 | 产生当前审计的操作项对应的菜单名称。例如：某条通知策略操作对应审计事件，此字段为当前通知策略名称 |
| `df_query_typeDQL` | String | 必须 | 查询类型 |
| `df_query` | String | 必须 | DQL 查询 |
| `df_query_range` | String | 必须 | DQL 查询时长，单位 ms |
| `df_cost` | String | 必须 | DQL 查询耗时 |
| `df_hit_count` | String | 必须 | 查询命中数量 |