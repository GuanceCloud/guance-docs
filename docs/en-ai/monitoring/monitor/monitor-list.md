# Monitor List

---

All configured monitors are clearly displayed in the monitor list. You can quickly view key information related to each monitor, such as associated alert policies, creator, updater, etc., through the intuitive interface on the right side of the list. Additionally, you can efficiently manage the monitor list using functions like search, filter, and import. To further enhance the transparency and traceability of monitors, you can directly jump from the list to view the incident records triggered by specific monitors and the operation logs of the monitors, thereby achieving comprehensive monitoring of monitor status and behavior.

## Operations Column {#options}

1. Enable/Disable: Guance supports enabling/disabling existing monitors. Newly created monitors will be enabled by default. Disabled monitors will no longer take effect; disabled monitors can be re-enabled.

2. Click to directly clone and copy the selected monitor.

3. You can re-edit existing monitors by clicking on the monitor name or **Edit**.

4. Click to directly clone an already created monitor and edit the rules as needed.

5. Operation Audit: Click to jump to the operation records related to this monitor rule.

6. View Related Events: Alerts triggered by the same monitor are uniformly stored under the corresponding **Monitor**. By clicking **View Related Events**, you can directly jump to all unresolved events triggered by this rule for [Event Management](../../events/index.md).

7. View Related Views: Each monitor supports associating with a dashboard. Editing the monitor allows you to associate the required dashboard via the **Associated Dashboard** function.

8. Manual Test Trigger: Guance supports manually triggering monitor checks. If the current check rule triggers, you can view relevant details in the event viewer. During manual testing, an event record will always be generated and alert notifications sent; mute rules still apply during manual tests.

9. You can **delete** existing monitors. Once a monitor is deleted, it cannot be recovered, but event data remains retained.

### Batch Operations

You can perform batch operations on specific monitors, including batch enable, disable, delete, and export.

Additionally, you can configure alert policies for monitors directly here. In the alert configuration dropdown menu, you can quickly apply the selected alert policy to the chosen monitors.

**Note**: If a monitor already has an alert policy, any configuration done here will overwrite the existing alert settings.

## Search Query

In the left-hand **Quick Filter**, you can quickly locate target monitors based on alert policies, status, tags, and monitor types.

You can also search directly in the search box based on monitor names and alert policy names.

## Import

Monitors support importing :material-tray-arrow-down: JSON files of monitor configurations to create monitors. Imported JSON files will be directly imported as monitors and grouped by default.

**Note**: The imported JSON file must be a configuration JSON file from Guance.

## Tag Display {#tags}

Guance supports adding tags to monitors. You can select existing tags or manually input new ones, which will be created after pressing Enter. Events triggered by monitor checks will also carry these tags.

<img src="../../img/tag-02.png" width="60%" >

Added tags will be displayed directly in the list. You can quickly find monitors under specific tags via **Quick Filter > Tags** on the left.

![](../img/tag-0822.png)

**Tag Logic Supplement**:

1. Tag value formats are not limited; they can be in `value` format, e.g., `aaa`, or `key:value`, e.g., `test:123`;

2. If custom-defined tag keys conflict with other event attributes (except for tags), they will be discarded. For example, if you set a monitor by `host`, and the final event attribute is `host:guance_01`. If you add a tag `host:000` to the monitor, the custom tag `host:000` will be discarded and not written into the event attributes.

## SLO Integration

Monitors added to SLO as SLIs will be displayed with a special identifier:

![](../img/slo-0822.png)

Hover to view the associated SLO list, and click :fontawesome-solid-arrow-up-right-from-square: to open the corresponding SLO detail page.

## Alert Policies

The alert policy feature allows you to customize meaningful monitor combinations when setting up monitors. You can filter out corresponding monitors through **Alert Policies**, making it easier to manage alert policies for various monitors.

**Note**:

1. When configuring alert policies for monitors, to ensure that data within the detection time range is not affected by network or database delays, a 2-minute waiting period is configured for detecting incidents;
2. Each monitor must choose an alert policy upon creation, defaulting to **Default**;
3. When an alert policy is deleted, monitors under that policy will automatically be categorized under **Default**.

> For more details, refer to [How to Create and Manage Alert Policies](../alert-setting.md).