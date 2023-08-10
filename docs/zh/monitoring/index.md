---
icon: zy/monitoring
---
# 监控
---


观测云拥有强大的异常监测能力，不仅提供了包括 Docker、Elasticsearch、Host 等一系列监控模板，还支持自定义监控器，配合告警通知功能，可及时发现帮助您快速发现问题、定位问题、解决问题。同时，观测云支持 SLO (Service Level Objective) 监控，精准把控服务水准和目标。


<div class="grid cards" markdown>

-   [<font color=coral> :material-monitor-eye:{ .lg .middle } __监控器__</font>](./monitor/index.md)

    ---

    *<font size=2>（原指“内置检测库”）</font>*    
    用于配置数据指标检测，从而即时触发告警事件。您可以使用观测云内置开箱即用的[监控模板](./monitor/template.md)，也可以自定义[新建监控器](./monitor/index.md#rules)，并设置对应[检测规则](./monitor/index.md#detect)。

    <br/>

-   [<font color=coral> :material-eye-check:{ .lg .middle } __智能巡检__</font>](./bot-obs/index.md)

    ---

    基于观测云的智能检测算法，支持自动检测基础设施和应用程序问题，预见基础设施和应用程序的潜在问题，评估问题对系统运行的影响等级，从而确定排障工作的优先级，减少不确定性。

    <br/>


-   [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } __SLO__</font>](./slo.md)

    ---

    观测云 SLO 监控是围绕 DevOps 各类指标，测试系统服务可用性是否满足目标需要，不仅可以帮助使用者监控服务商提供的服务质量，还可以保护服务商免受 SLA 违规的影响。

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




