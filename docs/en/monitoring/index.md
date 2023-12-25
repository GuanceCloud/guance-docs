---
icon: zy/monitoring
---
# Monitoring
---


Guance has powerful anomaly monitoring capabilities, providing a series of monitoring templates including Docker, Elasticsearch, Host, etc. It also supports custom monitors, which, combined with alert notification functionality, can help you quickly identify, locate, and resolve issues. Additionally, Guance supports SLO (Service Level Objective) monitoring to accurately control service levels and objectives.


<div class="grid cards" markdown>

- [<font color=coral> :material-monitor-eye:{ .lg .middle } **Monitors**</font>](./monitor/index.md)
    
    ---
    
    *<font size=2>(formerly known as "Built-in Detection Library")</font>*
    
    Used to configure data metric detection and trigger alert events in real time. You can use Observation Cloud's out-of-the-box [monitoring templates](./monitor/template.md), or you can customize [new monitors](./monitor/index.md#rules) and set corresponding [detection rules](./monitor/index.md#detect).
    
    <br/>
    
- [<font color=coral> :material-eye-check:{ .lg .middle } **Intelligent Monitoring**</font>](./intelligent-monitoring/index.md)
    
    ---
    
    Intelligent monitoring can quickly locate abnormal nodes, suitable for business metrics and highly volatile metrics. It analyzes the scene to construct a key dimension for multi-dimensional metrics, and quickly locates and analyzes exceptions around the service calls and resource dependencies in microservices.
    
    <br/>
    
- [<font color=coral> :fontawesome-regular-object-ungroup:{ .lg .middle } **SLO**</font>](./slo.md)
    
    ---
    
    Observation Cloud SLO monitoring focuses on various DevOps metrics to test whether system services meet target availability. It not only helps users monitor the quality of services provided by service providers, but also protects service providers from SLA violations.
    
    <br/>
    
- [<font color=coral> :octicons-mute-16:{ .lg .middle } **Mute Management**</font>](./silent-management.md)
    
    ---
    
    Manages all silent rules for different monitors, intelligent inspections, custom inspections, SLOs, and alert strategies in the current space. Mute targets will not send alert notifications to any notification targets during silent periods.
    
    <br/>
    
- [<font color=coral> :octicons-light-bulb-16:{ .lg .middle } **Alert Strategies**</font>](./alert-setting.md)
    
    ---
    
    *<font size=2>(formerly known as "Grouping")</font>*
    
    Manages alert strategies for monitor detection results. By sending alert notification emails or group messages, you can promptly understand the abnormal data detected by monitoring and identify and resolve problems.
    
    <br/>
    
- [<font color=coral> :material-satellite-uplink:{ .lg .middle } **Notification Targets**</font>](.notify-object.md)
    
    ---
    
    Sets the notification targets for alert events, including [default notification targets](.notify-object.md#default) (DingTalk robots, WeChat Work robots, Feishu robots, custom Webhooks, email groups, and SMS groups) and [custom notification targets](.notify-object.md#custom).
    
    </div>