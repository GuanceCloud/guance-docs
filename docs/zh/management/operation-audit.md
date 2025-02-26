# 操作审计
---



即工作空间内因用户行为而产生的操作审计事件，能够实时记录工作空间内的项目使用情况、用户行为操作和资源变更。包括但不限于：

1. 工作空间管理的事件：如基本设置的修改，成员权限的修改，删除通知对象，Lisence 过期等；  
2. 功能和服务使用的事件：如新建/修改/删除视图，新建应用检测，禁用某个检测库，设置主机沉默，生成指标等；        
3. 计费项目事件：如项目的使用量已接近免费额度等；
4. ...     

<img src="../img/audit.png" width="70%" >

## 管理审计事件

前往**管理 > 审计事件**查看所有工作空间产生的用户操作行为事件。

1. 在列表，可以针对事件进行搜索、分组聚合等操作；
2. 通过页面上方的时间组件，查看不同时间范围内的操作事件；
3. 点击设置，针对审计事件直接创建监控器或将当前审计事件列表导出为 CSV。


### 分组聚合

通过操作人分组聚合，查看在一定的时间范围内，用户在{{{ custom_key.brand_name }}}平台上的触发的所有聚合事件数量。

<img src="../img/audit_2.png" width="70%" >


#### 分组聚合详情页

在分组聚合模式下，可查看**聚合事件**，您可以在详情页查看某一用户（操作人）触发的所有审计事件。

<img src="../img/audit_3.png" width="70%" >

## 审计事件详情

在操作事件列表中点击单条事件，即可侧滑出事件的详情页面，查看事件的触发时间、标签属性、操作人、事件内容等。

<img src="../img/audit_1.png" width="70%" >

您还可以使用以下字段进行自主查询分析：

| <div style="width: 140px"> 字段名 </div>	      | 类型      | 是否必须	      | 说明      |
| ----------- | ---------------- | ----------- | ---------------- |
| `date`	      | Integrate      | 必须	      | 产⽣时间，Unix 时间戳，单位 ms      |
| `df_date_range`		      | Integrate      | 必须	      | 时间范围，单位 s     |
| `df_source`	      | String      | 必须	      | 数据来源，操作事件取值 audit      |
| `df_status`		      | String      | 必须	      | 状态，操作事件默认取 info      |
| `df_origin`	      | String      | 必须	      | 操作来源，用于记录当前操作来源入口。<br />参考值如下：<br /><li>front: 前端用户操作 <br /><li>openapi: 通过 OpenAPI 操作<br /><li>manage: 通过管理后台操作<br /><li>inner: 通过内部可信任系统操作      |
| `df_menu`	      | String      | 必须	      | 用户访问的菜单路径，例如：日志-查看器      |
| `df_event_id`		      | String      | 必须	      | 事件唯一 ID      |
| `df_title`		      | String      | 必须	      | 标题      |
| `df_message`	      | String      | 必须	      | 描述      |
| `df_user_id`		      | String      | 必须	      | 用户 ID      |
| `df_user_name`		      | String      | 必须	      | 用户姓名      |
| `df_user_email`	      | String      | 必须	      | 用户邮箱，对应【成员管理】的 id、name、email      |
| `df_user_team`		      | String      | 必须	      | 用户当下所属团队      |
| `df_role_scope`		      | String      | 必须	      | 用户当下所拥有的角色范围      |
| `df_operation_id` | Str | 必须 | 当前审计对应的实际操作项唯一 ID |
| `df_operation_name` | Str | 必须 | 产生当前审计的操作项对应的菜单名称。例如：某条通知策略操作对应审计事件，此字段为当前通知策略名称 |
| `df_query_typeDQL` | String | 必须 | 查询类型 |
| `df_query` | String | 必须 | DQL 查询 |
| `df_query_range` | String | 必须 | DQL 查询时长，单位 ms |
| `df_cost` | String | 必须 | DQL 查询耗时 |
| `df_hit_count` | String | 必须 | 查询命中数量 |



## 审计事件数据存储

操作审计的数据按照事件的存储策略进行保存，您可以在**管理 > 设置 > 变更数据存储策略**查看和调整事件存储策略。

![](img/audit_4.png)


## 更多阅读

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **审计事件逻辑详解**</font>](./audit-event.md)

</div>

</font>
