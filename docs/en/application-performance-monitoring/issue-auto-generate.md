# Clever Use of the Issue Auto-Discovery Feature for Rapid Anomaly Response
---

## Issue Auto-Discovery

In the <<< custom_key.brand_name >>> platform, we have introduced the **Issue Auto-Discovery** feature. This feature aims to automatically generate Issues in batches and notify relevant members based on errors detected by the Application Performance Monitoring (APM) and Real User Monitoring (RUM) modules.

Compared to traditional manual creation of Issues, this function is faster and more flexible, effectively accelerating the identification and resolution of anomalies.

![](img/issue-auto-generate.png)

Let's take a look at how to use the Issue Auto-Discovery feature.

## How to Use the Issue Auto-Discovery Feature

### Applicability and Permissions

The Issue Auto-Discovery feature applies to: Application Performance Monitoring (APM) > Error Tracking, Real User Monitoring (RUM) > Error Explorer.

Operation permissions: Owner, Administrator, Standard, and custom roles with **Issue Auto-Discovery** permissions.

### Configuring Issue Auto-Discovery

#### First Look: Issue Auto-Discovery

Members with operational permissions will see the text "Issue Auto-Discovery," an edit button, and an enablement indicator in the top-right corner when they enter APM > Error Tracking or RUM > Error Explorer.

- Clicking the edit button allows configuration of the Issue Auto-Discovery rules.
- The toggle button controls whether Issue Auto-Discovery is enabled.

![](img/issue-auto-generate-1.png)

![](img/issue-auto-generate-2.png)

#### Editing Issue Auto-Discovery Configuration

:material-numeric-1-circle: Concepts

Clicking the edit button brings up the configuration panel for setting up the Issue Auto-Discovery rules.

![](img/issue-auto-generate-3.png)

| Configuration Item | Description |
| --- | --- |
| Data Source | Automatically filled based on the menu location where auto-discovery is enabled. |
| Combination Dimensions | Selection rule: Default fields from APM > Error Tracking / RUM > Error Data dimensions.<br />Purpose: Classify Issues based on configured field combinations. If related fields and data exist in error data, an Issue will be automatically generated. |
| Detection Frequency | Issue Auto-Discovery can periodically check APM > Error Tracking / RUM > Error Data.<br />Customize the frequency here. |
| Issue Definition | Define the automatically discovered Issues. For Issue creation rules, refer to: [Create Issue](../exception/issue.md).<br />Template variables: Support for predefined template variables in Issue titles and descriptions. After adding template variables, the corresponding event details will be visible in the generated Issue. |

:material-numeric-2-circle: Additional Notes:

When configuring in APM > Error Tracking and RUM > Error Explorer, the options for **Combination Dimensions** and **Template Variables in Issues** differ, but the configuration logic remains the same.

1. Combination Dimensions: Automatically filled, with different fields.

- APM Combination Dimensions:

![](img/issue-auto-generate-4.png)

- RUM Combination Dimensions:

![](img/issue-auto-generate-5.png)

2. Template Variables: Title and description of Issues support template variables, with different categories available for APM and RUM.

![](img/issue-auto-generate-6.png)

:material-numeric-3-circle: After completing the Issue Auto-Discovery rule configuration, click "Save."

![](img/issue-auto-generate-7.png)

:material-numeric-4-circle: Enable the Issue Auto-Discovery button.

![](img/issue-auto-generate-8.png)

### Generating and Viewing Issues Using Issue Auto-Discovery

#### Issue Delivery

After configuring and enabling the Issue Auto-Discovery rules, the system will automatically detect errors according to the set frequency and generate Issues, which will be delivered to the configured channels.

![](img/issue-auto-generate-9.png)

#### Issue Display

Issues created via **Issue Auto-Discovery** will use the [Combination Dimensions] as a unique ID. If an Issue with the same combination dimensions already exists historically, a new Issue will not be created; instead, content will be appended to the historical Issue's reply section for updates. Generally, you can identify the status through special markers like "New Issue," "Duplicate Issue," or "Recurring Issue."

Special elements of auto-discovered Issue cards:

![](img/issue-auto-generate-10.png)

- Creator: Displayed as **Issue Auto-Discovery**, indicating its auto-generated nature.

- Combination Dimensions: Additional combination dimension group information displayed on the Issue card page and detail page.

- Special Markers: Auto-discovered Issues generally have three types of special markers: "New Issue," "Duplicate Issue," and "Recurring Issue."

    - New Issue: If no historical Issue with the same combination dimensions exists, a new Issue is created and marked as "New Issue" on the right side.

    - Duplicate Issue: If a historical Issue with the same combination dimensions exists and its status is Open or Pending, it indicates a recurring issue. The historical Issue is marked as "Duplicate Issue" on the right side.

    - Recurring Issue: If a historical Issue with the same combination dimensions exists and its status is Resolved, it indicates a previously resolved issue that has reappeared. The historical Issue is marked as "Recurring Issue" on the right side.

![](img/issue-auto-1.png)

Apart from these special fields and elements, other aspects such as title, content, priority, status, and replies follow the same logic as regular Issues.

## Frequently Asked Questions

:material-chat-question: Clicking the Issue Auto-Discovery enable button does not work.

If you are using this feature for the first time and have not yet edited the auto-discovery configuration, direct activation is not supported. You should first click the Issue Auto-Discovery edit button, configure the auto-discovery rules, and then activate it.

![](img/issue-auto-generate-11.png)

:material-chat-question: Entering APM > Error Tracking or RUM > Error Explorer does not show this feature.

The permission scope for this feature is: Owner, Administrator, Standard, and custom roles (configured with **Issue Auto-Discovery** permissions).

Therefore, please confirm your role under **Manage > Member Management**. If you have a custom role, ensure that this permission has been granted.

![](img/issue-auto-generate-12.png)