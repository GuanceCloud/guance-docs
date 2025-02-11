# Scheduled Reports {#report}

Guance supports exporting dashboards as reports and sending them to relevant personnel through various channels based on daily/weekly/monthly time dimensions.

To access **Scenes > Scheduled Reports**:

![Scheduled Report](../img/report-9.png)

Or **Scenes > Dashboards > Scheduled Reports**:

![](img/report-1.png)

On this page, you can view information such as the scheduled report name, associated dashboard, report cycle, notification targets, etc.

![](img/report-2.png)

## Create a New Report

1. **Basic Information**:

![](img/report-4.png)

:material-numeric-1-circle-outline: Dashboard: Select the dashboard for which you need to send a scheduled report.
:material-numeric-2-circle-outline: Modify View Variables: You can choose to customize and modify the view variables of the dashboard in the scheduled report.

**Note**:

- These modifications only affect the report and do not impact the original default settings of the dashboard.
- If the dashboard does not have any view variables, this option will not be displayed.

:material-numeric-3-circle-outline: Query Range: This is the time range queried by the dashboard when sending the report; the default is set to "Last 1 Day," but you can manually input a custom time range.

2. **Scheduling**:

![](img/report-5.png)

:material-numeric-1-circle-outline: Time Zone: The time zone defaults to `UTC+08:00` and is currently not modifiable.
:material-numeric-2-circle-outline: Report Time: The time at which the current scheduled report will be sent; enter a positive integer within the ranges: hours 0-23; minutes 0-59.
:material-numeric-3-circle-outline: Report Cycle: The frequency at which the scheduled report is sent; options include ["One-time"]["Daily"]["Weekly"]["Monthly"], choose as needed.

- One-time: If selected, the report will be sent only once at the specified time.
- Daily: You can select every day or specific dates for sending the scheduled report.
- Weekly: Choose the days of the week for scheduled sending.
- Monthly: You can select monthly or specific month and day combinations for sending the scheduled report.

3. **Notification Methods**:

Currently, four types of notifications are supported: email groups, DingTalk bots, WeChat Work bots, and Feishu bots.

![](img/report-6.png)

:material-numeric-1-circle-outline: Notification Targets: The recipients of the scheduled report; you can create new notification targets via **Monitoring > Notification Targets Management**.
:material-numeric-2-circle-outline: Title: The name displayed in the email subject line for the scheduled report.
:material-numeric-3-circle-outline: Content: The content displayed in the email body for the scheduled report.

4. **Sharing Options**:

![](img/report-3.png)

:material-numeric-1-circle-outline: Image Format: Choose the image format for sharing the scheduled report, including dashboard screenshots or chart screenshots.

**Note**: Email notifications default to exporting the dashboard content as an image. If your dashboard query time range is too long, data volume is too large, or involves complex calculations, some charts may appear blank.

:material-numeric-2-circle-outline: Sharing Method:

- **Public Sharing**: A short link for publicly shared scheduled reports can be opened directly.
- **Encrypted Sharing**: Requires setting a 4-8 character password (letters and numbers). After setting, the correct password must be entered to open the short link for the scheduled report.

Once the scheduled report is created, each chart within the dashboard will generate a corresponding image and be sent to the designated email address according to the settings.

## Manage Reports

In the report list, you can perform the following actions:

- Hover over the dashboard name to display detailed information, including the dashboard name and view variables; click to navigate to the corresponding dashboard page.
- Hover over the report cycle and notification targets to display detailed information.
- On the right side of the report under **Actions**, you can view the creator of the scheduled report and choose to disable, edit, or delete the report.