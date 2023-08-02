# Regular Report {#report}

Guance enables you to export dashboards into reports, which are regularly pushed to relevant members in the form of emails according to different time dimensions such as daily/weekly/monthly.

Enter **Scenes > Regular Report**:

<img src="../img/report-9.png" width="60%" >

Or **Scenes > Dashboards > Regular Report**:

![](img/report-1.png)

On the current page, you can view information such as the name of the timed report, the dashboard associated with it and the reporting period.

![](img/report-2.png)

## Create Report

![](img/report-3.png)

:material-numeric-1-circle: **Basic Info**:

![](img/report-4.png)

| Field      | Description               |
| ----------- | ---------------- |
| Dashboard      | Select the relevant dashboard for which you want to send timed reports.               |
| Modify View Variable      | You can choose to customize and modify the view variables of the dashboard in the timed report.<br/>:warning: <br/><li>The modification here only affects the report, and will not affect the original default value configuration of the dashboard;<br/><li>If there are no view variables in the dashboard, the button will not be displayed to you.                 |
| Query Scope     | That is, the time range of dashboard query when sending the report; "Recent 1 Day" is selected by default, and you can enter the time range manually.               |

:material-numeric-2-circle: **Timing Plan**：

![](img/report-5.png)

| <div style="width: 80px"> Field </div>     | Description               |
| ----------- | ---------------- |
| Zone      | The time zone displays UTC+08: 00 by default, and modification is not supported for the time being.               |
| Report Time      | That is, the time when the current timing report is sent; You need to fill in a positive integer, hours: 0 to 23; minutes: 0 to 59.               |
| Report Cycle      | That is, the sending frequency period of the current timing report; Includes "Once", "By Day", "By Week" and "By Month", which you can choose according to your needs.<br/><li>Once: If checked, the current report will only be sent at the specific time you selected;<br/><li>By Day: You can check every day; Or you can check the specific date of sending the current timing report, and support multiple choices;<br/><li>By Week: You can choose to send it regularly according to the time dimension of week;<br/><li>Monthly: You can check every month; Or you can check the specific month and day for sending the current regular report, and multiple choices are supported.              |

:material-numeric-3-circle: **Email Notification**：

![](img/report-6.png)

| Field      | Description               |
| ----------- | ---------------- |
| Recipient      | That is, the recipient of the current regular report; You can manually enter an external mailbox.               |
| Title      | That is, the name of the current timing report displayed in the message.               |
| Message      | That is, what the current timing report displays in the message.               |

After you click **Confirm**, you can view the newly created report in the report list:

![](img/report-7.png)

## Report List

From the report list, you can do the following:

- Hover to **Dashboard Name**, display details including dashboard name and view variables;
- Hover to **Report Cycle**, display detailed cycle information for the current timing report.

![](img/report-8.gif)

- In the **Operate** on the right side of the report, you can view the creator of the timed report, and you can choose to disable, edit, or delete the timed report.

