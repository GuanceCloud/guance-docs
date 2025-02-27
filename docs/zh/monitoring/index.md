---
icon: zy/monitoring
---
# 监控
---


{{{ custom_key.brand_name }}}提供完善的异常监测体系，内置 Docker、Elasticsearch、Host 等十余种开箱即用的监控模板，同时支持完全自定义的监控器配置。通过灵活设置检测规则与智能告警通知，帮助快速完成从问题发现、定位到解决的全流程闭环。系统还集成 SLO（Service Level Objective）监控模块，支持对服务等级目标的量化管理与持续追踪，确保关键业务指标可控可视。


<div class="grid cards" markdown>

-   [<font color=coral> :material-monitor-eye:{ .lg .middle } __监控器__</font>](./monitor/index.md)

    ---

    *<font size=2>（原指“内置检测库”）</font>*    
    用于配置数据指标检测，从而即时触发告警事件。您可以使用{{{ custom_key.brand_name }}}内置开箱即用的[监控模板](./monitor/template.md)，也可以自定义[新建监控器](./monitor/index.md#rules)，并设置对应[检测规则](./monitor/index.md#detect)。

    <br/>

-   [<font color=coral> :material-eye-check:{ .lg .middle } __智能监控__</font>](./intelligent-monitoring/index.md)

    ---

    智能监控可以快速定位异常节点，适用于业务类指标和波动性强的指标。它通过分析场景构建对多维指标做关键维度的定位，并围绕微服务中服务的调用和资源依赖，快速定位分析异常。

    <br/>


-   [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } __SLO__</font>](./slo.md)

    ---

    SLO 监控是围绕 DevOps 各类指标，测试系统服务可用性是否满足目标需要，不仅可以帮助使用者监控服务商提供的服务质量，还可以保护服务商免受 SLA 违规的影响。

    <br/>

-   [<font color=coral> :octicons-mute-16:{ .lg .middle } __静默管理__</font>](./silent-management.md)

    ---

    即管理当前空间下针对不同的监控器、智能巡检、自建巡检、SLO、告警策略的全部静默规则，可使静默对象在静默时间内不向任一告警通知对象发送告警通知。

    <br/>

-   [<font color=coral> :octicons-light-bulb-16:{ .lg .middle } __告警策略管理__</font>](./alert-setting.md)

    ---

    *<font size=2>（原指“分组”）</font>*    
    即对监控器的检测结果进行告警策略管理，通过发送告警通知邮件或者群消息通知，可及时了解监测的异常数据情况，从而发现并解决问题。

    <br/>

-   [<font color=coral> :material-satellite-uplink:{ .lg .middle } __通知对象管理__</font>](./notify-object.md)

    ---

    即设置告警事件时的通知对象，包括系统[默认通知对象](./notify-object.md#default)（钉钉机器人、企业微信机器人、飞书机器人、Webhook自定义、邮件组和短信组）和[自建通知对象](./notify-object.md#custom)。

    </div>




