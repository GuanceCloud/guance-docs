# Regular Reports {#report}

Guance enables you to export dashboards into reports, which are regularly pushed to relevant members in different forms according to different time dimensions such as daily/weekly/monthly.

Enter **Scenes > Regular Report**:

<img src="../img/report-9.png" width="40%" >

Or **Scenes > Dashboards > Regular Reports**:

![](img/report-1.png)


## Create


:material-numeric-1-circle: **Basic info**:

![](img/report-4.png)

:material-numeric-1-circle-outline: Dashboard: Select the dashboard you need to send the scheduled report.

:material-numeric-2-circle-outline: Modify view variables: You can choose to customize the view variables of the dashboard in the scheduled report.

**Note**:

- The modification here only affects the report and will not affect the default values of the dashboard;
- If there are no view variables in the dashboard, this option will not be shown to you.

:material-numeric-3-circle-outline: Query Scope: The time range of the dashboard query when sending the report; the default selection is "Last 1 day", you can manually enter the time range.

:material-numeric-2-circle: **Timing plan**:

![](img/report-5.png)

:material-numeric-1-circle-outline: Time Zone: The time zone by default is `UTC+08:00`, modification is not supported.

:material-numeric-2-circle-outline: Report time: The time to send the current scheduled report; you need to fill in a positive integer, range: hours 0-23; minutes 0-59.

:material-numeric-3-circle-outline: Report cycle: The frequency of the current scheduled report; includes "One-time", "Daily", "Weekly", "Monthly", you can choose as needed.

- One-time: If checked, the current report will only be sent at your specific time;
- Daily: You can choose every day; or you can choose the specific date to send the current scheduled report, multiple choices are supported;
- Weekly: You can choose to send it regularly based on the time dimension of the week;
- Monthly: You can choose every month; or you can choose the specific month and day to send the current scheduled report, multiple choices are supported.

:material-numeric-3-circle: **Notification method**:

Currently, 4 types of notifications are supported: Email group, DingTalk robot, Enterprise WeChat robot, Lark robot.

![](img/report-6.png)

:material-numeric-1-circle-outline: Notification object: The recipient of the current scheduled report; you can go to **Monitoring > Notification object management** to create a new notification object.

:material-numeric-2-circle-outline: Title: The name of the current scheduled report displayed in the email.

:material-numeric-3-circle-outline: Content: The content of the current scheduled report displayed in the email.

:material-numeric-4-circle: **Sharing Method**:

![](img/report-3.png)

:material-numeric-1-circle-outline: Type: You can choose the image form for sharing the scheduled report, including dashboard screenshots or icon screenshots.

**Note**: The default email notification will export the dashboard content as an image. If your dashboard data query time range is too long, the data volume is too large or there are complex calculations, the related charts may appear blank.

:material-numeric-2-circle-outline: Sharing Method:

- **Public Sharing**: The short link to the scheduled report with public sharing selected can be opened directly;

- **Encrypted Sharing**: You need to set a 4～8 digit English, numeric input password. After setting, the correct password must be entered to open the short link to the scheduled report.

After the scheduled report is created, each chart in the dashboard will generate corresponding images and send them to the corresponding email according to the settings.



## Report List

From the report list, you can do the following:

- Hover to **Dashboard Name**, display details including dashboard name and view variables;
- Hover to **Report Cycle**, display detailed cycle information for the current timing report.

![](img/report-8.gif)

- In the **Options** on the right side of the report, you can view the creator of the timed report, and you can choose to disable, edit, or delete the timed report.

