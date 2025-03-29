---
icon: zy/monitoring
---
# Monitoring
---


<<< custom_key.brand_name >>> provides a comprehensive anomaly monitoring system, with built-in monitoring templates for more than ten types of solutions such as Docker, Elasticsearch, and HOST that are ready to use out of the box. It also supports fully customizable monitor configurations. By flexibly setting detection rules and intelligent alert notifications, it helps quickly complete the entire process from problem discovery, positioning to resolution. The system also integrates an SLO (Service Level Objective) monitoring module, supporting quantifiable management and continuous tracking of service level objectives, ensuring key business metrics are controllable and visible.


<div class="grid cards" markdown>

-   [<font color=coral> :material-monitor-eye:{ .lg .middle } __Monitors__</font>](./monitor/index.md)

    ---

    *<font size=2>(Formerly known as "Built-in Detection Library")</font>*    
    Used to configure data Metrics detection, thus triggering alert events instantly. You can use <<< custom_key.brand_name >>>'s built-in out-of-the-box [Monitoring Templates](./monitor/template.md), or you can customize [Create Monitors](./monitor/index.md#rules) and set corresponding [Detection Rules](./monitor/index.md#detect).

    <br/>

-   [<font color=coral> :material-eye-check:{ .lg .middle } __Intelligent Monitoring__</font>](./intelligent-monitoring/index.md)

    ---

    Intelligent Monitoring can quickly identify abnormal nodes, suitable for business-related Metrics and highly volatile Metrics. It analyzes scenarios to build key dimension positioning for multi-dimensional Metrics and quickly locates and analyzes anomalies around service calls and resource dependencies in microservices.

    <br/>


-   [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } __SLO__</font>](./slo.md)

    ---

    SLO Monitoring revolves around various DevOps Metrics, testing whether the system's service availability meets target needs. It not only helps users monitor the quality of services provided by service providers but also protects service providers from SLA violations.

    <br/>

-   [<font color=coral> :octicons-mute-16:{ .lg .middle } __Mute Management__</font>](./mute-management.md)

    ---

    That is, managing all Mute rules for different monitors, Intelligent Inspections, Self-built Inspections, SLOs, and Alert Strategies under the current workspace. It ensures that no alert notifications are sent to any notification targets during the Mute period.

    <br/>

-   [<font color=coral> :octicons-light-bulb-16:{ .lg .middle } __Alert Strategies__</font>](./alert-setting.md)

    ---

    *<font size=2>(Formerly known as "Grouping")</font>*    
    That is, managing alert strategies for the detection results of monitors. By sending alert notification emails or group messages, users can promptly understand abnormal data conditions and thereby discover and resolve issues.

    <br/>

-   [<font color=coral> :material-satellite-uplink:{ .lg .middle } __Notification Targets__</font>](./notify-target.md)

    ---

    That is, setting notification targets for alert events, including the system's [Default Notification Targets](./notify-target.md#default) (DingTalk bots, WeCom bots, Lark bots, Webhook customizations, email groups, and SMS groups) and [Self-built Notification Targets](./notify-target.md#custom).

    </div>