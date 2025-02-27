# 外部事件检测

外部事件检测用于接收第三方系统产生的异常记录并产生相关事件，通过检测规则中标准的 Webhook 地址在{{{ custom_key.brand_name }}}生成相应的监控器事件数据和相应的告警策略及可视化仪表板。

## 应用场景

将第三方系统产生的异常事件或记录通过指定 URL 地址，以 POST 请求方式发送到 HTTP 服务器后生成{{{ custom_key.brand_name }}}的事件数据。

## 默认配置


![](../img/third-party.png)


1. **监控器名称**：支持自定义名称

2. **Webhook 地址**：默认进入创建页面时生成 Webhook 地址，可自定义追加参数标记地址用途。

外部事件数据由第三方系统主动向{{{ custom_key.brand_name }}}中心上报，并提供必要的事件数据。只有检测并匹配到对应字段才能生成事件产生异常记录后进行告警。

必需字段可参见下图示例：必须包含 `event` 下的五大字段才能与{{{ custom_key.brand_name }}}侧匹配成功；`extra_data` 则为自定义添加的字段：

```
{
    "event": {
        "status": "warning",
        "title": "外部事件监控器测试1",
        "message": "你好，这是外部事件监控器的message",
        "dimension_tags": {"heros": "caiwenji"},
        "check_value": 20
    },
    "extraData": {
        "name": "xxxxxxxx"
    }
}
```

> 更多详情，可参考 [外部事件监控器事件接受](../../open-api/checker/receive.md)。

