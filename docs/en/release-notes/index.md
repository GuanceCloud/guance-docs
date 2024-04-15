---
icon: zy/release-notes
---
# Release Notes (2024)
---

This document records the update content description released by Guance each time.

## March 13, 2024

### Guance Updates

- Monitoring > Monitors: Monitor type [Composite Detection](../monitoring/monitor/composite-detection.md) was launched. It supported combining the results of multiple monitors into one through expressions, and finally alerting based on the combined results.
- Service > Map: [Cross-workspace Servicemap query](../scene/service-manag.md#servicemap) was supported.

### Guance Deployment Plan Updates

- Management > Basic Information: "Used DK Quantity" display was added;
- Management > Users: The page [Group](../deployment/user.md#team) was added, based on group can configure associated workspace and role, users can get access to corresponding workspace through group.

## March 6, 2024

### Guance Updates

- Monitoring
    - Monitor > Detection Frequency: **[Crontab Custom Input](../monitoring/monitor/detection-frequency.md)** was enabled, meeting the need for detection only at specific times;
    - Mutation Detection: "Last 1 Minute" and "Last 5 Minutes" detection intervals were added;
    - Mute Management: When selecting a mute range, "Event attributes" was not required, and users could configure more granular matching rules as needed.
- DataFlux Func: [Function External Functions](../dql/dql-out-func.md) were added. Allowed third-party users to fully utilize Function's local cache and local file management service interface to write functions, and execute data analysis queries within the workspace.
- APM > [Traces](../application-performance-monitoring/explorer.md):
    - Title area UI display was optimized;
    - For flame graphs, waterfall charts, and Span lists with more than 10,000 Span results, users could view unshown Spans through **Offset** settings;
    - **Error Span** filtering entry was added; support for entering the resource name or Span ID corresponding to Span for search matching was supported.
- Scene
    - Charts: [Sankey diagram](../scene/visual-chart/sankey.md) was launched;
    - View Variables: **Selected** button was added, checked by default to select all current values, can be unchecked as needed.
- Account Management: [Account Deletion](../management/index.md#cancel) entry was added.
- Explorers:
    - UI display was optimized;
    - Regular match / reverse regular match mode were added in the filter function;
    - Wildcard filter and search supported Left * match.
- Events > Detail Page:【Alert Notification】tab page UI display was optimized.

### Guance Deployment Plan

- [login method selection](../deployment/setting.md#login-method) for unified management of login methods was added;
- [Delete](../deployment/user.md#delete) operation for local accounts and single sign-on accounts was added.

## January 31, 2024

### Guance Update

- Monitoring:
    - [Intelligent Monitoring](../monitoring/intelligent-monitoring/index.md):
        - The intelligent detection frequency of hosts, logs, and applications was adjusted to once every 10 minutes, and each detection calculation counted as 10 call costs;
        - To improve the accuracy of the algorithm, logs and application intelligent detections used the method of data rollover. After an intelligent monitor was turned on, the corresponding metric set and metric data were generated. This adjustment generated additional timelines, the specific number was the number of detection dimensions (service, source) * detection metric number filtered by the current monitor configuration. Since there was no storage of the monitor's filter conditions, if the monitor filter condition configuration was modified, an equal amount of new timelines was generated, so there was a situation of duplicate timeline billing on the day of modifying the monitor filter condition configuration, and it returned to normal the next day.
    - Alert Strategies:
        - Added [custom notification time configuration](../monitoring/alert-setting.md#custom), refine alert notification configuration by cycle, time interval;
        - Added new event option "Permanent" in Renotification.
    - Monitors
        - Alert Configuration: multiple alert strategies was supported; if multiple were configured, `df_monitor_name` and `df_monitor_id` were presented in multiple forms, separated by `;`;
        - Related issues: Added "Synchronously create Issue" switch, when an exception event recovers, it synchronously recovers the exception tracking issue;
        - Added [Clone Button](../monitoring/monitor/index.md#options) in Monitor List.
    - Notification Targets: Added [Simple HTTP Notification Type](../monitoring/notify-object.md#http), directly receive alert notifications through the Webhook address;
- Scenes:
    - Charts: Added Currency option; Advanced Configuration > Same Period Comparison changed to `YoY`;
    - Service Management > Resource Call: Added TOP / Bottom quantity selection in the ranking.
- Explorers: Added "Time Column" switch in Display Column > Settings.
- Billing:
    - Added [New Workspace](../billing/cost-center/workspace-management.md#lock) Entry in Workspace Lock popup page;
    - Optimized AWS Registration Process.

### Guance Deployment Plan Updates

- Supported [LDAP Single Sign-On](../deployment/ldap.md);
- Workspace Management > Data Storage Strategy: Added Custom Option, with its range less than 1800 Days (5 Years); Among them, the metric added optional items 720 days, 1080 days and other storage durations;
- User: Supported one-click configuration assignment of workspace and role for user accounts;
- Added Audit Event Viewing Entry, enabling to view all workspace related operation audits;
- Added Management Background MFA Authentication.

## January 11, 2024

### Guance Updates

- Logs:
    - Added BPF Network Log Collection and Log Detail Page; JSON Format conversion was supported; Readable Display Mode was enabled in details page;
    - You could bind "Related Network Log";
    - Data Access: Batch Operation was added.
- Regular Reports: Added optional sharing method "Public Sharing" or "Encrypted Sharing".
- Dashboards:
    - View Variable: Added "All Variable Values" parameter option was added;
    - Time Series Chart: Added sorting logic (new engine only); support sorting returned results.
- Generate Metrics: Supported Batch Operation; standard and above permissions members supported cloning.
- Monitors:
    - Notification Targets: adapt New DingTalk Robot; "secret" option was not required when creating, quickly associating DingTalk Robot.
    - Optimized SLO deduction logic was optimized.
- RUM: Public network Dataway supports IP conversion to geographic location information.