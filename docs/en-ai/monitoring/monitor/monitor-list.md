# Monitor List

---

All configured monitors are clearly displayed in the monitor list. You can quickly view key information related to each monitor, such as associated alert strategies, creators, and updaters, through the intuitive interface on the right side of the list. Additionally, you can efficiently manage the monitor list using functions like search, filter, and import. To further enhance the transparency and traceability of monitors, you can directly jump from the list to view specific monitor-triggered incident records and operation logs, thereby achieving comprehensive monitoring of monitor status and behavior.

## Operations Column {#options}

1. Enable/Disable: <<< custom_key.brand_name >>> supports enabling/disabling existing monitors. New monitors will be enabled by default. Disabled monitors will no longer take effect; disabled monitors can be re-enabled.
   
2. Click to clone the selected monitor directly.
   
3. You can re-edit existing monitors, including monitor status, rule configuration, etc.
   
4. Click to clone an already created monitor and re-edit the monitor status, rule configuration, etc., as needed.
   
5. Audit Trail: Click to view the operation records related to this monitor rule.
   
6. View Related Events: All alert events triggered by the same monitor are stored under the corresponding **Monitor**. By clicking **View Related Events**, you can directly jump to all unresolved events triggered by this rule for [Event Management](../../events/index.md).
   
7. View Related Views: Each monitor supports associating with a dashboard. Editing the monitor allows you to associate it with the required dashboard via the **Associated Dashboard** feature.
   
8. Manual Trigger Test: <<< custom_key.brand_name >>> supports manually triggering monitor checks. If the current check rule triggers, you can view relevant details in the event viewer. During manual testing, an event record is always generated and alert notifications are sent; mute rules still apply during manual tests.
   
9. You can delete existing monitors. Once a monitor is deleted, its data cannot be recovered, but event data is retained.

### Batch Operations

You can perform batch operations on specific monitors, including batch enable, disable, delete, and export.

Additionally, you can configure alert strategies for monitors directly here. In the alert configuration dropdown menu, you can quickly apply the selected alert strategy to the chosen monitors.

**Note**: If a monitor already has an alert strategy, the configuration done here will overwrite the existing alert settings.

## Search Query

In the left-hand **Quick Filter**, you can quickly locate target monitors based on alert strategies, status, tags, and monitor types.

You can also search directly in the search box based on monitor names or alert strategy names.

## Import

Monitors support creating monitors by importing :material-tray-arrow-down: JSON configuration files. Imported JSON files will be imported as monitors and grouped by default.

**Note**: The imported JSON file must be a configuration JSON file from <<< custom_key.brand_name >>>.

## Tag Display {#tags}

<<< custom_key.brand_name >>> supports adding tags to monitors. You can select existing tags or enter them manually, pressing Enter to create new tags. Events triggered by monitor checks will also include these tags.

<img src="../../img/tag-02.png" width="60%" >

Added tags will be displayed directly in the list after saving. You can quickly find monitors under specific tags using **Quick Filter > Tags**.

![](../img/tag-0822.png)

**Tag Logic Supplement**:

1. Tag value formats are not limited; they can be in `value` format, e.g., `aaa`, or `key:value`, e.g., `test:123`;
   
2. If your custom tag key duplicates other event attributes (except for tags), it will be discarded. For example, if you set a monitor by `host`, and the final event attribute is `host:guance_01`. If you add a tag `host:000` to the monitor, the custom tag `host:000` will be discarded and not written into the event attributes.

## SLO Integration

Monitors added as SLIs in SLOs will be displayed with a special icon:

![](../img/slo-0822.png)

Hover to view the associated SLO list, and click :fontawesome-solid-arrow-up-right-from-square: to open the corresponding SLO detail page.

## Alert Strategies

The alert strategy feature allows you to customize meaningful combinations of monitors when setting up monitors. You can filter out corresponding monitors via **Alert Strategies** for easy management of various monitors.

**Note**:

1. When configuring alert strategies for monitors, to ensure that data within the detection time range is not affected by network or database delays, a 2-minute waiting period is configured for anomaly event detection;
   
2. Each monitor must select an alert strategy upon creation, defaulting to **Default**;
   
3. When an alert strategy is deleted, monitors under the deleted strategy will automatically be categorized under **Default**.

> For more details, refer to [How to Create and Manage Alert Strategies](../alert-setting.md).