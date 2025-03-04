# 本地 Function 函数


在企业系统中，多方数据相互交织。为了有效管理这些数据，我们需要为上报的数据设定明确的业务责权范围。鉴于业务数据时刻处于动态变化之中，根据最新的业务管理范围来查询和获取相关联的数据结果变得尤为关键。

<<< custom_key.brand_name >>>提供的本地 Function 函数功能，允许第三方用户充分利用 Function 的本地缓存和本地文件管理服务接口，并结合相关负责人的业务关系，在工作空间内执行数据分析查询，最终轻松获取与业务关系相关的接口耗时等性能分析数据。

## 配置步骤

### 编辑本地 Function 函数

1. 通过 Function 本地缓存/本地文件输入业务对应关系；

2. 新建 Category=函数脚本，定义业务参数范围，编写数据查询语句（DQL + 业务关系表）；

3. 发布函数脚本。

#### 编辑示例

```
import time

@DFF.API('数据查询函数', category='guance.dataQueryFunc')
def query_fake_data(time_range=None, tier=None):
    # <<< custom_key.brand_name >>>连接器
    guance = DFF.CONN('guance')

    # 未指定时间范围时，可以强制限制到最近 1 分钟数据
    if not time_range:
        now = int(time.time())
        time_range = [
            (now - 60) * 1000,
            (now -  0) * 1000,
        ]

    # DQL 语句
    dql = 'M::`fake_data_for_test`:(avg(`field_int`)) BY `tag`'

    # 根据额外参数 tier 追加条件
    conditions = None
    if tier == 't1':
        conditions = 'tag in ["value-1", "value-3"]'
    elif tier == 't2':
        conditions = 'tag = "value-2"'

    # 查询并以原始形式返回数据
    status_code, result = guance.dataway.query(dql=dql, conditions=conditions, time_range=time_range, raw=True)
    return result
```

### 使用该函数获取查询结果

1. 进入控制台 > 场景 > 图表查询，选择**添加数据源**；

2. 选中已经编辑好的 Function 函数，并填写参数内容；

3. 展现查询结果：

![](img/func-query-out.png)


