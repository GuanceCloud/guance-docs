---

## 简介

观测云 支持您通过「事件」对异常检测库触发的事件进行实时监控、统一查询、未恢复事件统计、和数据导出。同时，系统支持快速聚合相关事件和匹配关联事件，您可快速定位异常并高效对异常数据进行分析。
## 
## 未恢复事件列表

进入「事件」，观测云 将默认为您展示「未恢复事件列表」，您可以查看到空间内持续被触发的全部未恢复事件，及不同告警级别下未恢复事件的数据量统计、告警信息详情等。

**注意**：若在异常检测库配置检测规则时，未设置恢复告警事件检测周期，则告警事件不会恢复，且一直会出现在「事件」-「未恢复事件列表」中。

### 数据状态

观测云 为帮助您快速识别告警事件，事件数据将依据异常检测规则设定的告警级别包括 critical（紧急）、error（错误）、warning(警告）和ok (正常) 进行分类。

### 查询与分析

在未恢复事件列表中，支持通过选择时间范围、搜索关键字，筛选等方式查询事件数据，帮助您快速在所有事件中定位到哪一时间范围、哪一功能模块、那一行为触发的事件。您可以

- 统计不同告警状态下的事件数量，包括「未恢复」、「紧急」、「错误」、「警告」
- 点击列表上方的告警状态，筛选出所有对应告警状态下的事件列表
- 通过列表上方的搜索和筛选栏，您可以基于标签、字段、文本（包含日志文本）进行关键词搜索、标签筛选、字段筛选、关联搜索
- 查看当前告警事件信息，包括该事件的检测维度、告警开始的时间、告警持续的时间，展开可查看最近 6 小时的window函数。

![9.event_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645520173124-9e1607db-f8c4-4ccb-b304-c28c2eee31b8.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue54f01a9&margin=%5Bobject%20Object%5D&name=9.event_1.png&originHeight=722&originWidth=1243&originalType=binary&ratio=1&rotation=0&showTitle=false&size=100731&status=done&style=stroke&taskId=u337175d1-42e6-4a12-9fb9-3d9c546735b&title=)

**注意**：在预览事件的 window 函数时，

   - 异常事件影响时间段展示为虚线边框的展示效果
   - 检测库规则类型为阈值、日志、应用性能指标、用户访问指标检测、安全巡检、异常进程、云拨测检测时，根据不同告警等级对应的色块可查看相关异常检测指标数据，包括紧急、错误、警告。
   - 检测库规则类型为突变、区间、水位时，根据图表“竖线”可快速识别出当前事件触发的时间点。

## 事件列表

进入「事件」，通过切换左上角的查看器至「事件列表」，你可以查看空间内全部事件列表。观测云支持通过柱状图堆叠的方式，统计当前事件列表内，不同时间点发生的不同告警级别的事件数量。
![9.event_1.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645520588423-f5f119f6-0a7f-4ab1-ad1a-e832966321e7.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u61ddba22&margin=%5Bobject%20Object%5D&name=9.event_1.1.png&originHeight=479&originWidth=1244&originalType=binary&ratio=1&rotation=0&showTitle=false&size=91960&status=done&style=stroke&taskId=uea191c8a-ad79-48cb-87af-51c4aa27406&title=)
### 事件查询

在事件列表中，观测云 支持通过选择时间范围、搜索关键字，筛选等方式查询事件数据，帮助您快速在所有事件中定位到哪一时间范围、哪一功能模块、那一行为触发的事件。您可以：

- 通过右上角的时间筛选组件，您可以筛选数据展示的时间范围
- 通过列表上方的搜索和筛选栏，您可以基于字段、文本（包含日志文本）进行关键词搜索、字段筛选、关联搜索
   - 输入框支持模糊匹配相关字段
   - “abc：123”形式， 回车后支持字段筛选
   - 输入框输入文本，支持关键字搜索
   - " abc AND cba / abc OR cba" 形式，回车后支持关联搜索
- 通过列表左侧的快捷筛选，您可以通过勾选快捷筛选的字段快速筛选数据，支持自定义添加筛选字段，支持通过“反选”进行快捷筛选，支持通过“重置”快速清除快捷筛选条件。

注意：搜索支持多个关键词搜索，只需要输入对应的关键词，使用空格或者逗号隔开即可。（当前搜索多个关键词时采用的是AND逻辑，输入的关键词越多数据匹配的范围越精准。）
### 分组聚合

通过分组功能，观测云支持根据检测项分组聚合和统计相关事件。
![9.event_1.2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645520959556-e0299ca1-9164-4169-bc9b-32ca61a5306f.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9997961d&margin=%5Bobject%20Object%5D&name=9.event_1.2.png&originHeight=474&originWidth=1250&originalType=binary&ratio=1&rotation=0&showTitle=false&size=65252&status=done&style=stroke&taskId=u934193c6-fdbc-43f4-aa16-cd682b4dae5&title=)
### 数据导出

在事件列表中，点击「导出」可导出当前事件列表的数据到CSV、仪表板和笔记。
![9.event_1.3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521093907-742f250c-7dd4-4733-a41a-da7f583376c0.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3fed0593&margin=%5Bobject%20Object%5D&name=9.event_1.3.png&originHeight=455&originWidth=1245&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90439&status=done&style=stroke&taskId=u864d10d5-5814-4d1a-a405-ae6d72a42db&title=)
## 事件详情页

在异常事件列表中点击事件，就可以查看事件详情，包括基础属性、状态&趋势、历史记录、关联事件和关联SLO。支持点击“复制事件完整内容”按钮，获取当前事件所对应的所有关键数据，若在配置监控器时关联了仪表板，可点击“关联仪表板”按钮跳转到对应的仪表板。
### 基础属性
支持查看事件的标签及属性、检测维度、事件内容以及其他的字段属性。
![5.event_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652957941001-2bfa76f5-2f95-48a3-876a-59f0efa85a3a.png#clientId=ud18be2f1-09f4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue40535eb&margin=%5Bobject%20Object%5D&name=5.event_1.png&originHeight=702&originWidth=1140&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126440&status=done&style=stroke&taskId=u0637ee9b-3ecb-4f49-8ef6-228389c309f&title=)
点击标签“监控器”，支持“添加到筛选”、“复制”和“跳转到监控器”。

- “添加到筛选”，即添加该标签至事件查看器，查看与该主机相关的全部事件数据
- “复制”，即复制该标签内容至剪贴板 
- “跳转到监控器”，即查看该事件配置的监控器详情。

![5.event_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652958084528-2ee82f92-aceb-4431-9686-4c328580ba30.png#clientId=ud18be2f1-09f4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u7be78a0a&margin=%5Bobject%20Object%5D&name=5.event_2.png&originHeight=250&originWidth=644&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47665&status=done&style=stroke&taskId=ua0f81eef-4dcc-4204-9786-c62b139276e&title=)
点击“添加到筛选”可添加标签到搜索栏筛选事件。
![5.event_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652958106716-13f0586b-5e66-4d25-b611-f08a66dc7a59.png#clientId=ud18be2f1-09f4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u80a1aff8&margin=%5Bobject%20Object%5D&name=5.event_3.png&originHeight=589&originWidth=1230&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89205&status=done&style=stroke&taskId=u5d7b575d-a8e4-4507-b446-c6f63129ec3&title=)

### 状态&趋势
支持查看事件的状态分布趋势、DQL函数和窗口函数折线图。
![9.event_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521542474-8378d8df-cbce-4bbe-ae07-192c5367a433.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u50de5fe8&margin=%5Bobject%20Object%5D&name=9.event_5.png&originHeight=791&originWidth=1140&originalType=binary&ratio=1&rotation=0&showTitle=false&size=83396&status=done&style=stroke&taskId=udc5584cf-e742-4011-8178-4fe6c1bd206&title=)

- 状态分布：展示选定时间范围内（默认展示最近6小时）的事件状态 (紧急、重要、警告、无数据)
- DQL查询语句：基于异常检测规则的自定义查询语句返回的实时指标数据，默认展示最近6小时的实时指标数据
- window 函数：基于异常检测规则，以选定的时间范围为窗口（记录集合），以检测频率为偏移，重新对每条记录执行统计计算，返回用于触发告警的实时异常检测指标数据。默认展示最近6小时的实时异常检测指标数据

![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1631094686281-cf6dfd16-07e7-40e6-a89b-9161d991daa5.png#clientId=u882ec291-7d0f-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=281&id=u1835bcb1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=281&originWidth=1172&originalType=binary&ratio=1&rotation=0&showTitle=false&size=26394&status=done&style=none&taskId=u689fe0a1-ee4a-452f-a8ff-157a2738080&title=&width=1172)**注意：**在事件详情中，观测云默认为您展示最近6小时的数据，

   - 当您选择的时间范围小于 ( < = ) 6小时，「状态分布」、「DQL函数」、「window函数」将展示当前时间范围的数据与指标趋势。
   - 当您选择的时间范围大于 ( > ) 6小时，「状态分布」与「DQL函数」将展示当前时间范围的数据，且出现一个可调节的区间滑块（显示范围最小支持15分钟，最大支持6小时）。通过移动区间滑块，可查看与之时间范围对应的「window函数」

### 历史记录
支持查看检测对象主机、异常/恢复时间和持续时长。
![9.event_6.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521580941-e9830b8e-ff7f-4a65-be8a-71018e2a58d8.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0183d6d3&margin=%5Bobject%20Object%5D&name=9.event_6.png&originHeight=229&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38111&status=done&style=stroke&taskId=ud3e506e1-a83f-4c94-89ef-569d1813b03&title=)
### 关联信息
支持查看触发当前事件的相关信息，如查看触发事件的相关日志。此“关联信息”仅支持 4 种监控器产生的事件：日志检测、安全巡检异常检测、进程异常检测以及可用性数据检测。
注意：若日志检测包含多个表达式查询，关联信息支持多个表达式查询的 tab 切换，若有两个表达式查询 A 和 B，则在关系信息包含 A 和 B 两个 tab 可切换查看。
![7.event_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651840390781-7afe937a-d03d-480e-8301-1a6fdbea5737.png#clientId=u62dee0eb-a9c5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u438a82e0&margin=%5Bobject%20Object%5D&name=7.event_1.png&originHeight=328&originWidth=1136&originalType=binary&ratio=1&rotation=0&showTitle=false&size=127857&status=done&style=stroke&taskId=u48e5f142-b151-41da-b17c-c1b4c9d849b&title=)
### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。
![9.event_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521632465-1c761c0a-4990-41f6-880f-1cd168941df2.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf493862e&margin=%5Bobject%20Object%5D&name=9.event_7.png&originHeight=300&originWidth=1140&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64300&status=done&style=stroke&taskId=u689f37a0-b22b-4ee8-b991-c06374aeccd&title=)
### 关联 SLO
若在监控配置了 SLO ，则可以查看关联 SLO ，包括 SLO 名称、达标率、剩余额度、目标等信息。
![9.event_8.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521672593-07b5553d-0438-4627-8eac-2e0862802c31.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue0272efd&margin=%5Bobject%20Object%5D&name=9.event_8.png&originHeight=171&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38569&status=done&style=stroke&taskId=u59550015-c73e-4a33-bb10-13528f31709&title=)

## 聚合事件详情页

在事件列表中，基于"检测项“分组后，可点击查看「聚合事件」。在聚合事件列表，可查看基于该检测项触发的全部事件，点击聚合事件详情，即可查看对应的基础属性、状态&趋势、和关联事件。支持点击“复制事件完整内容”按钮，获取当前事件所对应的所有关键数据，若在配置监控器时关联了仪表板，可点击“关联仪表板”按钮跳转到对应的仪表板。

### 基础属性
支持查看事件的标签及属性、检测维度、事件内容以及其他的字段属性。
![5.event_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652958499012-5a7848f2-c650-4dd0-8399-54856589867b.png#clientId=ud18be2f1-09f4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua79a7127&margin=%5Bobject%20Object%5D&name=5.event_4.png&originHeight=634&originWidth=1139&originalType=binary&ratio=1&rotation=0&showTitle=false&size=117061&status=done&style=stroke&taskId=u01d03b5b-3b3d-416b-abc1-4768dac2df4&title=)
### 状态&趋势
支持查看事件的状态分布趋势、DQL函数和窗口函数折线图。
![9.event_9.2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645524893304-c7d4cdfd-f30b-4d09-9774-3b8286aeb6e2.png#clientId=u173d6e13-2ffa-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1030b162&margin=%5Bobject%20Object%5D&name=9.event_9.2.png&originHeight=887&originWidth=1128&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103282&status=done&style=stroke&taskId=u2b9cd821-3125-47ec-b49f-881b0ce8fff&title=)
### 关联事件
支持通过筛选字段和所选取的时间组件信息，查看关联事件。
![9.event_9.3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645524972780-0b1a27d9-fd61-49c7-adea-0b04cc4f0a5e.png#clientId=u173d6e13-2ffa-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u97b9b4b3&margin=%5Bobject%20Object%5D&name=9.event_9.3.png&originHeight=305&originWidth=1139&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60295&status=done&style=stroke&taskId=u8cfe5da5-f822-471a-9581-edb3d6e58c7&title=)


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642758433136-7d12a992-41de-47b4-97ad-cadc7240f130.png#clientId=udddfbc39-561c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u805c3534&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=uc7618b9d-21df-448c-95ab-68955a6b2d5&title=)
