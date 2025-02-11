---
icon: zy/monitoring
---
# Monitoring
---


Guance has powerful incident detection capabilities, not only providing a series of monitoring templates including Docker, Elasticsearch, Host, etc., but also supporting custom monitors. Combined with alert notification features, it can help you quickly identify, locate, and resolve issues. Meanwhile, Guance supports SLO (Service Level Objective) monitoring to precisely control service levels and objectives.


<div class="grid cards" markdown>

-   [<font color=coral> :material-monitor-eye:{ .lg .middle } __Monitors__</font>](./monitor/index.md)

    ---

    *<font size=2>(formerly known as "built-in detection library")</font>*    
    Used for configuring metrics detection to trigger alert events instantly. You can use Guance's built-in [monitor templates](./monitor/template.md), or create [new monitors](./monitor/index.md#rules) and set corresponding [detection rules](./monitor/index.md#detect).

    <br/>

-   [<font color=coral> :material-eye-check:{ .lg .middle } __Intelligent Monitoring__</font>](./intelligent-monitoring/index.md)

    ---

    Intelligent Monitoring can quickly pinpoint abnormal nodes, suitable for business-related metrics and highly volatile metrics. It analyzes scenarios to locate critical dimensions of multi-dimensional metrics and quickly identifies anomalies around microservices calls and resource dependencies.

    <br/>


-   [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } __SLO__</font>](./slo.md)

    ---

    Guance SLO monitoring revolves around various DevOps metrics, testing whether system service availability meets target needs. It helps users monitor the quality of services provided by service providers and protects them from SLA violations.

    <br/>

-   [<font color=coral> :octicons-mute-16:{ .lg .middle } __Mute Management__</font>](./silent-management.md)

    ---

    Manages all mute rules for different monitors, intelligent inspections, user-defined inspections, SLOs, and alert policies within the current workspace. This ensures that muted objects do not send alert notifications to any notification targets during the mute period.

    <br/>

-   [<font color=coral> :octicons-light-bulb-16:{ .lg .middle } __Alert Policy Management__</font>](./alert-setting.md)

    ---

    *<font size=2>(formerly known as "group")</font>*    
    Manages alert policies for monitor detection results. By sending alert notification emails or group messages, you can promptly understand abnormal data conditions and address issues.

    <br/>

-   [<font color=coral> :material-satellite-uplink:{ .lg .middle } __Notification Targets Management__</font>](./notify-object.md)

    ---

    Sets notification targets for alert events, including system [default notification targets](./notify-object.md#default) (DingTalk bot, WeChat Work bot, Feishu bot, Webhook custom, email groups, and SMS groups) and [user-defined notification targets](./notify-object.md#custom).

    </div>