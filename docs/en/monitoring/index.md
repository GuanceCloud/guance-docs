---
icon: zy/monitoring
---
# Monitoring
---


<<< custom_key.brand_name >>> provides a comprehensive anomaly detection system, with built-in monitoring templates for Docker, Elasticsearch, Host, and more than ten other out-of-the-box solutions. It also supports fully customizable monitor configurations. By flexibly setting detection rules and intelligent alert notifications, it helps quickly complete the entire process from problem discovery, localization to resolution. The system also integrates an SLO (Service Level Objective) monitoring module, supporting quantified management and continuous tracking of service level objectives, ensuring key business metrics are controllable and visible.


<div class="grid cards" markdown>

-   [<font color=coral> :material-monitor-eye:{ .lg .middle } __Monitors__</font>](./monitor/index.md)

    ---

    *<font size=2>(formerly known as "built-in detection library")</font>*    
    Used to configure data metric detection, thereby triggering alert events in real time. You can use <<< custom_key.brand_name >>>'s built-in [monitor templates](./monitor/template.md), or create [new monitors](./monitor/index.md#rules) and set corresponding [detection rules](./monitor/index.md#detect).

    <br/>

-   [<font color=coral> :material-eye-check:{ .lg .middle } __Intelligent Monitoring__</font>](./intelligent-monitoring/index.md)

    ---

    Intelligent monitoring can quickly locate abnormal nodes, suitable for business-related metrics and highly volatile metrics. It analyzes scenarios to pinpoint critical dimensions of multi-dimensional metrics and quickly locates and analyzes anomalies around microservices calls and resource dependencies.

    <br/>


-   [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } __SLO__</font>](./slo.md)

    ---

    SLO monitoring revolves around DevOps metrics, testing whether the system's service availability meets target requirements. It not only helps users monitor the quality of service provided by service providers but also protects service providers from SLA violations.

    <br/>

-   [<font color=coral> :octicons-mute-16:{ .lg .middle } __Mute Management__</font>](./silent-management.md)

    ---

    Manages all mute rules for different monitors, intelligent inspections, user-defined inspections, SLOs, and alert strategies within the current workspace. This ensures that muted objects do not send any alert notifications during the mute period.

    <br/>

-   [<font color=coral> :octicons-light-bulb-16:{ .lg .middle } __Alert Strategies__</font>](./alert-setting.md)

    ---

    *<font size=2>(formerly known as "groups")</font>*    
    Manages alert strategies for monitor detection results. By sending alert notification emails or group messages, you can promptly understand abnormal data conditions and address issues timely.

    <br/>

-   [<font color=coral> :material-satellite-uplink:{ .lg .middle } __Notification Targets Management__</font>](./notify-object.md)

    ---

    Sets notification targets for alert events, including system [default notification targets](./notify-object.md#default) (DingTalk bot, WeCom bot, Lark bot, Webhook custom, email groups, and SMS groups) and [user-defined notification targets](./notify-object.md#custom).

    </div>