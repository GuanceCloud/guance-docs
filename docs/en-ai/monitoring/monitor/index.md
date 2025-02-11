# Monitors
---

In Guance, you can use the ready-to-use monitoring [templates](../monitor/template.md) to [create new monitors](#template); you can also [create custom](#rules) monitors by setting up detection rules and trigger conditions through various methods such as threshold detection, log detection, mutation detection, range detection, and more than ten other [detection rules](#detect). Once a monitor is activated, you will receive alerts for related incidents triggered by the detection rules.

## Start Creating {#new}

### Configure Rules

This involves quickly configuring [trigger rules](./monitor-rule.md) based on multiple detection rules provided officially by Guance.

### Official Template Library {#template}

Guance includes a variety of ready-to-use monitoring [templates](../monitor/template.md) that allow you to create official monitors for hosts, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, etc., in your current workspace with one click.

![](../img/monitoring-0725.png)

**Note**: Repeatedly creating monitors from templates may result in duplicate monitors appearing in the monitor list. Guance supports detecting duplicate monitors. You can choose "Yes" in the pop-up prompt to normally create all monitors from the template library or choose "No" to create only non-duplicate monitors.

<img src="../img/image_8.png" width="60%" >

### Custom Template Library

You can save already created monitors as [templates](../monitor/custom-template.md), making it easier for you to quickly add or remove monitor configuration conditions later.