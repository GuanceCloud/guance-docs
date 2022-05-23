---

## 简介

DQL 是专为 “观测云” 开发的语言，语法简单，方便使用，可在 “观测云” 或者终端设备通过 DQL 语言进行数据查询。

## DQL 查询

在观测云工作空间，点击菜单栏的「快捷入口」-「DQL 查询」即可打开 DQL 查询查看器，或者您可以通过快捷键`Alt+Q`直接打开 DQL 查询。
![3.dql_6.png](img/3.dql_6.png)
### 简单查询
点击“DQL 查询”右侧的切换按钮![3.dql_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649324053221-27764ea3-80ff-456c-8cd8-f47aa6cd307a.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=upJYW&margin=%5Bobject%20Object%5D&name=3.dql_5.png&originHeight=14&originWidth=19&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7186&status=done&style=stroke&taskId=ufb92460f-fea4-4490-95ef-6369ca07a3a&title=)，可切换 DQL 查询为简单查询。
注意：「DQL查询」切换成「简单查询」时，若无法解析或者解析不完整：

- 在「简单查询」下未操作，直接切换回「DQL查询」则显示之前的 DQL 查询语句；
- 在「简单查询」下调整了查询语句，再次切换回「DQL查询」将按照最新的「简单查询」进行解析。

![3.dql_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320677940-aba9ac38-1125-46b9-8454-0602b1b97cce.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=EFJIo&margin=%5Bobject%20Object%5D&name=3.dql_2.png&originHeight=519&originWidth=1350&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69469&status=done&style=stroke&taskId=uc095cad8-22a1-4497-a391-65baf1d06e0&title=)

### 返回结果

在 DQL 查询窗口输入 DQL 查询语句，点击其他任意地方，即可在“返回结果”查看查询结果。 “返回结果”以表格形式返回查询结果，最多返回1000条数据，支持导出CSV文件，支持点击查看帮助文档。
![3.dql_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320668248-6173e567-ae4d-4361-99e3-d2cd6054d46e.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=cK8r6&margin=%5Bobject%20Object%5D&name=3.dql_1.png&originHeight=520&originWidth=1349&originalType=binary&ratio=1&rotation=0&showTitle=false&size=67442&status=done&style=stroke&taskId=u4dc6cf7c-eefa-4244-bd67-a07f3122b3c&title=)
若 DQL 查询语句有误，也可在“返回结果”查看错误提示。
![3.dql_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649325352050-20468511-1786-4a02-b0fa-38e025ed21f8.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucbaa5cca&margin=%5Bobject%20Object%5D&name=3.dql_7.png&originHeight=431&originWidth=1353&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38577&status=done&style=stroke&taskId=u893bb015-317e-4488-a277-1e3d8ffac17&title=)

### JSON

若 DQL 查询语句正确，返回查询结果后，可在“JSON”查看 Json 结构的查询结果，支持复制 Json ，支持点击查看帮助文档。若 DQL 查询返回错误结果，则在“JSON”同时提示错误信息。
![3.dql_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320685871-14f827dd-369b-481c-ba23-baef23df2156.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u86f8aab8&margin=%5Bobject%20Object%5D&name=3.dql_3.png&originHeight=708&originWidth=1345&originalType=binary&ratio=1&rotation=0&showTitle=false&size=72274&status=done&style=stroke&taskId=ubd3e5244-e259-421b-9fa9-51bf8e35e2e&title=)

### 查询历史

查询历史支持按日查看7天内的100条查询历史数据，支持对查询语句进行模糊搜索。
![3.dql_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320694064-39213a68-ef62-428c-a623-76cca26d1def.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6e9d5510&margin=%5Bobject%20Object%5D&name=3.dql_4.png&originHeight=565&originWidth=1348&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56896&status=done&style=stroke&taskId=u9a6372e9-0df6-4445-bc99-42172d070af&title=)
点击查询历史数据右侧的执行按钮![3.dql_8.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649326117044-a6854149-9016-4b54-9efa-2c7f72d68aa9.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=bHczO&margin=%5Bobject%20Object%5D&name=3.dql_8.png&originHeight=20&originWidth=19&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7528&status=done&style=stroke&taskId=u5fe15d19-b6d3-415f-aeb3-4b963dbcfdc&title=)，直接展示对应的查询语句及查询结果。
![3.dql_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320668248-6173e567-ae4d-4361-99e3-d2cd6054d46e.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=dRvzG&margin=%5Bobject%20Object%5D&name=3.dql_1.png&originHeight=520&originWidth=1349&originalType=binary&ratio=1&rotation=0&showTitle=false&size=67442&status=done&style=stroke&taskId=u4dc6cf7c-eefa-4244-bd67-a07f3122b3c&title=)

## DQL 语法

DQL 查询遵循如下的语法范式，各个部分之间的相对顺序不能调换，从语法角度而言，`data-source` 是必须的（类似于 SQL 中的 `FROM` 子句），其它部分都是可选的。更多 DQL 语法介绍可参考文档 [DQL 定义](https://www.yuque.com/dataflux/doc/fsnd2r) 。
```
namespace::
    data-source
    target-clause
    filter-clause
    time-expr
    by-clause
    limit-clause
    offset-clause
    slimit-clause
    soffset-clause
```
### 示例说明

下面是一个简单的示例，通过 DQL 查询时序指标集 cpu 的字段 usage_idle (CPU空闲率)，以 host 来过滤筛选，同时以 host 来分组显示结果。其中 #{host} 是在观测云仪表板设置的视图变量，用于过滤筛选。
![4.DQL_2.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639462494083-8ccfbe2a-205c-4645-ba06-14d62d4ce383.png#clientId=u8e0c1d05-2569-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=Jm5kK&margin=%5Bobject%20Object%5D&name=4.DQL_2.1.png&originHeight=1168&originWidth=3955&originalType=binary&ratio=1&rotation=0&showTitle=false&size=283431&status=done&style=none&taskId=uf6dd7ca9-8f4c-4aee-9f7e-4db6d5dd995&title=)

把上面的语句应用到观测云场景仪表版的图表查询中，下图结合表达式查询和 DQL 查询，展示最近 15 分钟 CPU 使用率。
![4.DQL_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639462477677-956edc31-e968-4e1f-8b26-b5e2a4745110.png#clientId=u8e0c1d05-2569-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u21743c2f&margin=%5Bobject%20Object%5D&name=4.DQL_2.png&originHeight=713&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105493&status=done&style=stroke&taskId=uc5433f1f-b695-416e-aa41-08a2df281f5&title=)

## DQL 函数

DQL 查询除了可以在场景仪表板中使用以外，我们还可以通过 DQL 函数来查询 DataKit 采集的各种数据，如数据来源、字段、标签等。

### SHOW 函数

SHOW 函数用于展示各类数据。若对通过 DataKit 采集的数据来源、字段、标签等没有清晰的了解，可以在 DQL 查询查看器通过 SHOW 函数来查询。

下面通过 SHOW 函数查询“对象”和“日志”的来源、字段等数据。更多函数介绍可参考文档 [DQL 函数](https://www.yuque.com/dataflux/doc/ziezwr) 以及 [DQL 外层函数](https://www.yuque.com/dataflux/doc/wgrf10) 。

#### show_object_source()

展示 `object` 数据的指标集合。
![3.dql_9.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649333123422-abfbf296-be9d-477a-b66e-ebd42b4edc5e.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua260e20a&margin=%5Bobject%20Object%5D&name=3.dql_9.png&originHeight=674&originWidth=1351&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60368&status=done&style=stroke&taskId=u3baa8103-02b4-4299-9fdf-fabc79199fb&title=)

#### show_object_field()

展示对象的 `fileds` 列表。
![3.dql_10.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649333129097-c4caf82f-6bfa-4d60-80b7-4fa971f84bf9.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udee5ba9b&margin=%5Bobject%20Object%5D&name=3.dql_10.png&originHeight=700&originWidth=1352&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75486&status=done&style=stroke&taskId=u80440331-b216-4b2d-94cf-a9db57ba7b6&title=)
#### show_object_label()

展示对象包含的标签信息。
![3.dql_11.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649333138072-5897e71d-3a29-4d9f-a8a5-80e5de0d3508.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u2e1f5d20&margin=%5Bobject%20Object%5D&name=3.dql_11.png&originHeight=436&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=48500&status=done&style=stroke&taskId=ueb2c11dc-0d90-40c2-be43-d3d647b4cdd&title=)
#### show_logging_source()

展示日志数据的指标集合。
![3.dql_12.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649333146450-d1266658-e738-4bef-9f9f-512f837eaa69.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1d94986e&margin=%5Bobject%20Object%5D&name=3.dql_12.png&originHeight=702&originWidth=1354&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50344&status=done&style=stroke&taskId=ua9ea43e3-75c9-4c5f-8c49-0e5480b3b41&title=)
#### show_logging_field()

展示指定 `source` 下的所有 fileds 列表。
![3.dql_13.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649333155388-9ead993c-640f-4834-a2ee-04adc7ab3b2f.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue12de6b7&margin=%5Bobject%20Object%5D&name=3.dql_13.png&originHeight=704&originWidth=1354&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69249&status=done&style=stroke&taskId=u7ac037ff-8ee6-4dd3-98d1-573807390c5&title=)


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642755920880-f4d6e984-72ed-4bb0-baee-76737d23a1fe.png#crop=0&crop=0&crop=1&crop=1&from=url&id=zFmHC&margin=%5Bobject%20Object%5D&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)


