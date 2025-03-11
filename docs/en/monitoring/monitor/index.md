# Monitor
---

In <<< custom_key.brand_name >>>, you can use out-of-the-box monitoring [templates](../monitor/template.md) to [create a new monitor](#template); you can also [create a custom](#rules) monitor by setting up detection rules and trigger conditions through various methods such as threshold detection, log detection, mutation detection, range detection, and more than ten other [detection rules](#detect). Once the monitor is enabled, you will receive alerts for relevant incidents triggered by the detection rules.

## Start Creating {#new}

### Configure Rules

This involves quickly configuring [trigger rules](./monitor-rule.md) based on multiple detection rules provided officially by <<< custom_key.brand_name >>>.

### Official Template Library {#template}

<<< custom_key.brand_name >>> includes various out-of-the-box monitoring [templates](../monitor/template.md) that allow you to create official monitors for hosts, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, etc., with one click into the current workspace.

![](../img/monitoring-0725.png)

**Note**: Repeatedly creating monitors from templates can lead to duplicate monitors in the monitor list. <<< custom_key.brand_name >>> supports detecting duplicate monitors. You can choose "Yes" in the pop-up prompt to normally create all monitors from the template library or select "No" to create only non-duplicate monitors.

<img src="../img/image_8.png" width="60%" >

### Custom Template Library

You can save already created monitors as [templates](../monitor/custom-template.md) for easy addition or removal of monitor configuration conditions later.