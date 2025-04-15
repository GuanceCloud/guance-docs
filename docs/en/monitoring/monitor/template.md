# Official Monitor Template Library
---


The system provides various ready-to-use monitoring templates, supporting one-click creation for dozens of monitoring templates including HOST, Docker, Elasticsearch, Redis, Alibaba Cloud RDS, Alibaba Cloud SLB, Flink, and more. After creating a template, the corresponding official monitor will be automatically added to the current workspace.

???+ warning "Note"

    Before creating a template, you need to [install DataKit](../../datakit/datakit-install.md) on the host and enable the configuration of related collectors; otherwise, the monitors corresponding to the template will not generate alert events.

![](../img/monitor_template.png)

## Create Template {#create}


1. Go to **Monitors > Official Template Library**;
2. Select a monitoring template;
3. Start configuring.

You can choose to create a single or batch of templates without manual configuration, quickly putting them into use.

## Manage Templates

On the left are all types of monitoring templates, and on the right are all detection rules under the template type. On this page, you can perform the following actions:

- Select a specific detection library in the **Detection Library** on the left for filtering;
- Paginate through the detection rules or input a name in the search bar for real-time searching;
- Multi-select detection rules on the right to batch-create monitors;
- After successful creation, return to the monitor list, click to open a certain monitor, then you can edit the detection rules and save them.