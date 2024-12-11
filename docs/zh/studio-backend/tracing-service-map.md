# 拓扑图图表数据结构

## 【服务关系图】数据结构说明

```
{
  "services": [
    {
      "data": {
        "__size": 10,
        "__fill": 10,
        "fieldA": "1.0",
        "fieldB": "test"
      },
      "name": "demo_web",
      "type": "web"
    },
    {
      "data": {
        "__size": 10,
        "__fill": 10,
        "fieldA": "1.0",
        "fieldB": "test"
      },
      "name": "demo_framework",
      "type": "framework"
    }
  ],
  "maps": [
    {
      "source": "demo_web",
      "target": "demo_framework"
    }
  ]
}
```

字段说明：

| 参数名 | 类型  | 说明  |
| --- | --- | --- |
| maps | arrary | 拓扑图的有向边列表 |
| maps.source | string | 源服务名称 |
| maps.target | string | 目标服务名称 |
| services | arrary | 拓扑图服务节点列表 |
| services.name | string | 服务名称 |
| services.type | string | 服务类型，目前有的服务类型为<br/>["app", "framework", "cache", "message_queue", "custom", "db", "web", "aws_lambda"]<br/>也可填入自定义类型 |
| services.data | json | 服务节点数据 |
| services.data.__size | double | 圆圈大小字段的值，该值无范围<br/>按照设置的大小自适应显示 |
| services.data.__fill | double | 填充颜色字段的值，该值的范围为<br/>设置的**渐变色系**的最大和最小值 |
| services.data.fieldA | string | 显示在 tooltip 的字段 |
| services.data.fieldB | string | 显示在 tooltip 的字段 |

## 【资源关系图】数据结构说明

```
{
  "services": [
    {
      "data": {
        "__fill": 10,
        "avg_per_second_title": "AAA",
        "avg_per_second": 1,
        "p99_title": "AAA",
        "p99": 1,
        "error_rate_title": "AAA",
        "error_rate": 1
      },
      "name": "demo_web",
      "type": "web"
    },
    {
      "data": {
        "__fill": 10,
        "avg_per_second_title": "AAA",
        "avg_per_second": 1,
        "p99_title": "AAA",
        "p99": 1,
        "error_rate_title": "AAA",
        "error_rate": 1
      },
      "name": "demo_framework",
      "type": "framework"
    }
  ],
  "maps": [
    {
      "source": "demo_web",
      "target": "demo_framework"
    }
  ]
}
```

字段说明：

| 参数名 | 类型  | 说明  |
| --- | --- | --- |
| maps | arrary | 拓扑图的有向边列表 |
| maps.source | string | 源服务名称 |
| maps.target | string | 目标服务名称 |
| services | arrary | 拓扑图服务节点列表 |
| services.name | string | 服务名称 |
| services.type | string | 服务类型，目前有的服务类型为<br/>["app", "framework", "cache", "message_queue", "custom", "db", "web", "aws_lambda"]<br/>也可填入自定义类型 |
| services.data | json | 服务节点数据 |
| services.data.__fill | double | 填充颜色字段的值，该值的范围为<br/>设置的**渐变色系**的最大和最小值 |
| services.data.avg_per_second_title | string | 左边字段的标题 |
| services.data.avg_per_second | double | 左边字段的值 |
| services.data.p99_title | string | 中间字段的标题 |
| services.data.p99 | double | 中间字段的值 |
| services.data.error_rate_title | string | 右边字段的标题 |
| services.data.error_rate | double | 右边字段的值 |