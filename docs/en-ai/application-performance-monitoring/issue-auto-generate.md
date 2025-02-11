# Clever Use of the Issue Auto-Discovery Feature for Rapid Anomaly Response
---

## Issue Auto-Discovery

In the Guance platform, we have introduced the **Issue Auto-Discovery** feature. This aims to automatically generate Issues in batches and notify relevant members based on errors detected by the Application Performance Monitoring (APM) and Real User Monitoring (RUM) modules.

Compared to traditional manual creation of Issues, this function is faster and more flexible, effectively accelerating the identification and resolution of anomalies.

![](img/issue-auto-generate.png)

Let's explore how to use the Issue Auto-Discovery feature.

## How to Use the Issue Auto-Discovery Feature

### Applicability and Permissions

The Issue Auto-Discovery feature applies to:
- APM > Error Tracking
- RUM > Error Viewer

Operation permissions: Owner, Administrator, Standard, Custom roles with **Issue Auto-Discovery** permissions.

### Configuring Issue Auto-Discovery

#### First Look: Issue Auto-Discovery

Members with operational permissions will see the text "Issue Auto-Discovery," an edit button, and an enablement indicator in the upper right corner when they enter APM > Error Tracking or RUM > Error Viewer.

- Clicking the edit button allows configuration of Issue Auto-Discovery rules.
- The toggle switch controls whether Issue Auto-Discovery is enabled.

![](img/issue-auto-generate-1.png)

![](img/issue-auto-generate-2.png)

#### Editing Issue Auto-Discovery Configuration

:material-numeric-1-circle: Concept Explanation

Click the edit button to bring up the configuration panel and set up the Issue Auto-Discovery rules.

![](img/issue-auto-generate-3.png)

| Configuration Item | Description |
| --- | --- |
| Data Source | Automatically filled based on the menu location where auto-discovery is enabled. |
| Grouping Dimensions | Selection rule: Default dimensions from APM > Error Tracking / RUM > Error Data.<br />Function: Based on configured fields, Issues are categorized. If there are related field groups and corresponding data in error data, an Issue will be automatically generated. |
| Detection Frequency | Issue Auto-Discovery can regularly check APM > Error Tracking / RUM > Error Data.<br />Customize the frequency here. |
| Issue Definition | Define the rules for auto-generated Issues. Refer to [Creating Issues](../exception/issue.md).<br />Template Variables: Support for predefined template variables in Issue titles and descriptions. After adding template variables, detailed information about the corresponding events will be visible in the generated Issues. |

:material-numeric-2-circle: Additional Notes:

When configuring in APM > Error Tracking and RUM > Error Viewer, the options for **Grouping Dimensions** and **Template Variables** differ, but the configuration logic remains consistent.

1. Grouping Dimensions: Automatically filled, with different fields depending on the context.

   - APM Grouping Dimensions:

   ![](img/issue-auto-generate-4.png)

   - RUM Grouping Dimensions:

   ![](img/issue-auto-generate-5.png)

2. Template Variables: Titles and descriptions support template variables, which differ between APM and RUM.

   ![](img/issue-auto-generate-6.png)

:material-numeric-3-circle: After completing the Issue Auto-Discovery rule configuration, click "Save."

![](img/issue-auto-generate-7.png)

:material-numeric-4-circle: Enable the Issue Auto-Discovery toggle.

![](img/issue-auto-generate-8.png)

### Generating and Viewing Issues Using Issue Auto-Discovery

#### Issue Delivery

After configuring and enabling the Issue Auto-Discovery rules, the system will automatically detect errors at the specified frequency and generate Issues, delivering them to the configured channels.

![](img/issue-auto-generate-9.png)

#### Issue Display

Issues created via **Issue Auto-Discovery** will use the [Grouping Dimensions] as a unique ID. If an Issue with the same grouping dimensions already exists, a new Issue will not be created; instead, content will be appended to the existing Issue's reply section for updates. Generally, you can identify the status using special markers like "New Issue," "Duplicate Issue," and "Recurring Issue."

Key elements of auto-discovered Issue cards:

![](img/issue-auto-generate-10.png)

- Creator: Displayed as **Issue Auto-Discovery**, indicating it was auto-generated.
- Grouping Dimensions: New grouping dimension information displayed on the Issue card page and detail page.
- Special Markers: Auto-discovered Issues typically have three types of special markers:
  - New Issue: If no historical Issue with the same grouping dimensions exists, a new Issue is created and marked as "New Issue."
  - Duplicate Issue: If a historical Issue with the same grouping dimensions exists and its status is Open or Pending, it is marked as "Duplicate Issue."
  - Recurring Issue: If a historical Issue with the same grouping dimensions exists and its status is Resolved, it is marked as "Recurring Issue."

![](img/issue-auto-1.png)

Apart from these special fields and elements, other aspects such as title, content, priority, status, and replies follow the same logic as regular Issues.

## Common Questions

:material-chat-question: Clicking the Issue Auto-Discovery enable button has no effect.

If this is your first time using this feature and you haven't edited the auto-discovery configuration yet, direct activation is not supported. Please click the Issue Auto-Discovery edit button to configure the rules before enabling.

![](img/issue-auto-generate-11.png)

:material-chat-question: Entering APM > Error Tracking or RUM > Error Viewer does not show this feature.

This feature is available only to users with the following roles: Owner, Administrator, Standard, Custom roles (configured with **Issue Auto-Discovery** permissions).

Please go to **Management > Member Management** to confirm your role. If you have a custom role, ensure that this permission has been granted.

![](img/issue-auto-generate-12.png)