查看器搜索说明

---


事件、基础设施、日志、应用性能监测、用户访问监测、可用性监测、安全巡检等查看器搜索栏合并搜索和筛选功能，支持字段、文本进行关键字搜索、字段筛选和关联搜索。

- 关键字搜索：支持通配符进行模糊搜索，如在日志搜索栏输入“关键字A”，返回含“关键字A”的搜索结果；如在日志搜索栏输入“关键字A*”，返回关键字含“关键字A”的搜索结果；

![13.search_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1654512002373-f99e235c-9814-44ee-94ee-a3737e1c97f6.png#clientId=u570c445f-5697-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u238b5473&margin=%5Bobject%20Object%5D&name=13.search_1.png&originHeight=492&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=127642&status=done&style=stroke&taskId=uc40a4d63-eecb-459c-8ecb-4548c753e50&title=)

- 字段筛选：支持按照“字段:值”的方式进行筛选，支持添加标签并按照“标签:值”的方式进行精确筛选或模糊筛选，如在日志搜索栏输入“status:”，可自动下拉选择对应的值如“info”进行精确查询，查询结果返回所有状态为info的筛选结果；在日志搜索栏输入“status:in*”，并选择wildcard查询可基于包含in的变量进行模糊查询。

![13.search_2.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1654512513903-7547ca77-b9de-49ac-b0b9-9ed99a76cef8.png#clientId=u570c445f-5697-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua815849f&margin=%5Bobject%20Object%5D&name=13.search_2.1.png&originHeight=570&originWidth=1236&originalType=binary&ratio=1&rotation=0&showTitle=false&size=169912&status=done&style=stroke&taskId=u2a60b71a-a167-47f1-bf55-7ab9f41f509&title=)
在搜索栏，点击“字段:值”，支持对“字段:值”进行修改。
![13.search_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1654512445099-3c35bc5b-3fe8-4271-934c-c64ea7286947.png#clientId=u570c445f-5697-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9e142ccb&margin=%5Bobject%20Object%5D&name=13.search_3.png&originHeight=320&originWidth=1230&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60369&status=done&style=stroke&taskId=u31a89574-335d-48da-a4ca-b7834fd6a79&title=)

- 关联搜索：支持按照 AND/OR/NOT 逻辑进行关联搜索。
   - AND可使用空格或者逗号隔开进行搜索，输入的关键字越多，数据匹配的范围就越精准，如在日志搜索栏输入“关键字A,关键字B”或者“关键字A 关键字B”或者“关键字A AND 关键字B”，返回同时包含“关键字A和关键字B”的搜索结果；
   - OR用于两者满足其一即都显示匹配的数据，如在日志搜索栏输入“关键字A OR 关键字B”，返回包含“关键字A”或则“关键字B”的搜索结果；
   - NOT用于排除显示匹配数据，如在日志搜索栏输入“NOT 关键字A”，返回不包含“关键字A”搜索结果。

![13.search_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1654512622916-00a17a82-7860-4366-b41b-93d207d23a94.png#clientId=u570c445f-5697-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u73d33198&margin=%5Bobject%20Object%5D&name=13.search_4.png&originHeight=418&originWidth=1244&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90899&status=done&style=stroke&taskId=uf712800f-3d85-4616-8f03-c08f8537efa&title=)
