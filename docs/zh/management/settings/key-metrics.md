# 关键指标管理（作战室）
---

<<< custom_key.brand_name >>>提供**作战室**看板，您可以在**作战室**看板纵观所有工作空间的关键指标趋势，帮助您快速了解每个工作空间的关键数据情况，及时发现和解决异常问题。

## 查看作战室关键指标

在<<< custom_key.brand_name >>>工作空间，点击左上角的工作空间名称，在弹出的对话框中，点击**进入作战室**。

![](../img/3.key_metrics_4.png)

进入作战室以后，您可以查看当前账号所属的所有工作空间的关键指标趋势。在作战室，您可以通过图标、列表的形式查看关键指标趋势，您可以按照**事件紧急程度**、**工作空间**、**未恢复事件数量**多种维度对工作空间进行排序查看。

- 事件紧急程度：按照紧急 > 重要 > 警告 > 数据断档进行排序；  
- 工作空间：按照别名 > 工作空间名称进行排序；           
- 未恢复事件数量：按照工作空间 48 小时未恢复事件数量从大到小排序。    

以图标形式查看指标趋势：

![](../img/3.key_metrics_5.2.png)

以列表形式查看指标趋势：

![](../img/3.key_metrics_6.1.png)


## 配置作战室关键指标

在<<< custom_key.brand_name >>>工作空间**管理 > 设置 > 高级设置 > 关键指标**，可查看已经配置的关键指标，点击**添加关键指标**即可配置新的关键指标。

![](../img/3.key_metrics_2.png)

点击**添加关键指标**后，会跳转到 **[指标分析](../../metrics/explorer.md)** 进行指标查询，配置完查询语句以后，点击右侧的 :heavy_plus_sign: 按钮，输入关键指标名称，单击**确定**即可添加一条新的关键指标。

**注意**：关键指标最多配置 3 条 DQL 查询，若需要查看其他关键指标，您可以删除当前的 DQL 查询重新配置。

![](../img/3.key_metrics_1.png)



### 查看关键指标

在管理 > 设置 > 关键指标右侧的查看图标，即可跳转到**指标分析**查看查询语句，若关键指标未满 3 条，您可以修改查询语句并添加新的关键指标。

![](../img/3.key_metrics_3.gif)



### 删除关键指标

点击关键指标右侧的删除图标，即可删除当前的关键指标。
