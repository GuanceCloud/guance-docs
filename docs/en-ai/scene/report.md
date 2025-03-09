# Scheduled Reports {#report}

<<< custom_key.brand_name >>> supports exporting dashboards as reports and sending them through various channels at scheduled intervals such as daily, weekly, or monthly to relevant personnel.

To access **Use Cases > Scheduled Reports**:

![Scheduled Report](../img/report-9.png)

Or **Use Cases > Dashboards > Scheduled Reports**:

![Scheduled Report from Dashboard](img/report-1.png)

On this page, you can view information about the scheduled report name, associated dashboard, report frequency, notification targets, etc.

![Scheduled Report Info](img/report-2.png)

## Create a Report

1. **Basic Information**:

![Basic Info](img/report-4.png)

:material-numeric-1-circle-outline: Dashboard: Select the dashboard for which you need to send the scheduled report.
:material-numeric-2-circle-outline: Modify View Variables: You can choose to customize and modify the view variables of the dashboard in the scheduled report.

**Note**:

- Modifications here only affect the report and do not impact the original default settings of the dashboard.
- If the dashboard does not have any view variables, this option will not be displayed.

:material-numeric-3-circle-outline: Query Range: This is the time range queried by the dashboard when sending the report; it defaults to "Last 1 Day," but you can manually enter a different time range.

2. **Schedule Settings**:

![Schedule Settings](img/report-5.png)

:material-numeric-1-circle-outline: Time Zone: The time zone defaults to `UTC+08:00` and currently cannot be modified.
:material-numeric-2-circle-outline: Report Time: The time at which the current scheduled report is sent; enter a positive integer within the ranges: hours 0-23, minutes 0-59.
:material-numeric-3-circle-outline: Report Frequency: The sending frequency of the current scheduled report; options include ["One-time"]["Daily"]["Weekly"]["Monthly"]. Choose based on your needs.

- One-time: If selected, the report will only be sent at the specified time.
- Daily: You can select every day or specific days for sending the scheduled report.
- Weekly: You can choose to send the report weekly.
- Monthly: You can select specific months and days for sending the scheduled report.

3. **Notification Methods**:

Currently supports 4 types of notifications: email group, DingTalk bot, WeCom bot, Lark bot.

![Notification Methods](img/report-6.png)

:material-numeric-1-circle-outline: Notification Targets: The recipients of the current scheduled report; you can create new notification targets under **Monitoring > Notification Targets Management**.
:material-numeric-2-circle-outline: Title: The title that appears in the email for the current scheduled report.
:material-numeric-3-circle-outline: Content: The content that appears in the email for the current scheduled report.

4. **Sharing Methods**:

![Sharing Methods](img/report-3.png)

:material-numeric-1-circle-outline: Image Format: You can choose the image format for sharing the scheduled report, including dashboard screenshots or chart screenshots.

**Note**: Email notifications default to exporting the dashboard content as an image. If the data query time range of your dashboard is too long, the data volume is too large, or there are complex calculations involved, charts may appear blank.

:material-numeric-2-circle-outline: Sharing Method:

- **Public Sharing**: The short link for publicly shared scheduled reports can be opened directly.
- **Encrypted Sharing**: Requires setting a 4-8 character password consisting of English letters and numbers. After setting, the correct password must be entered to open the short link of the scheduled report.

Once the scheduled report is created, each chart within the dashboard will generate a corresponding image and be sent to the specified email according to the set schedule.

## Manage Reports

In the report list, you can perform the following actions:

- Hover over the dashboard name to display detailed information, including the dashboard name and view variables; click to navigate to the corresponding dashboard page.
- Hover over the report frequency and notification targets to display detailed information.
- On the right side of the report under **Actions**, you can view the creator of the scheduled report and choose to disable, edit, or delete the report.