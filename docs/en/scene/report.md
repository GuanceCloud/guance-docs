# Scheduled Reports {#report}

<<< custom_key.brand_name >>> supports exporting dashboards as reports and can automatically send them to relevant personnel through various channels based on time dimensions such as daily, weekly, or monthly.


## Create

### Basic Information

1. Dashboard: Select the dashboard for which you need to send a scheduled report;    
2. Modify View Variables: Customize and modify the view variables of the dashboard in the scheduled report;
3. Query Range: Set the time range of the dashboard when sending the report. The default is "Last 1 Day," but you can also manually input a custom time range.      

???+ warning "Note"

    - The modified view variables here apply only to the generated report and do not affect the original default configuration of the dashboard;
    - If the dashboard does not define any view variables, this option will not be displayed.

### Scheduling Plan

1. Time Zone: Default display is `UTC+08:00`, modification is temporarily unsupported.               
2. Report Time: Set the specific time for sending the scheduled report. Enter positive integers within the following ranges: hour 0-23; minute 0-59.               
3. Report Cycle: Set the frequency of sending scheduled reports. Options include:

    - One-time: Send only once at the specified time;
    - Daily: Choose to send every day or specify certain dates (multiple selections supported);
    - Weekly: Choose the frequency based on the weekly time dimension;
    - Monthly: Choose to send every month or specify certain months and dates (multiple selections supported).              

### Notification Methods

Currently supports 5 types of notifications: email groups, DingTalk bots, WeCom bots, Lark bots, Webhook.

1. Notification Targets: Recipients of the current scheduled report. You can create new notification targets in [Monitoring > Notification Targets Management](../monitoring/notify-object.md);               
2. Title: The name displayed in the email for the scheduled report.               
3. Content: The specific content displayed in the email for the scheduled report.               


### Sharing Methods

1. Image: Choose the image format for sharing the scheduled report, including dashboard screenshots or chart screenshots.
        
    - Email/DingTalk bot notifications: By default, the dashboard content is exported as an image. If the data query time range of the dashboard is too long, contains too much data, or includes complex calculations, it may result in blank charts.
    - WeCom bot: Supports default mode and image mode (under this mode, only images can be shared, text cannot be sent, and the image size should be limited to within 2MB)
    - Webhook: Supports sharing image links, accessible via the link to the dashboard image.

2. Sharing Method:

    - Public Sharing: Short links for publicly shared scheduled reports can be opened directly;

    - Encrypted Sharing: Requires setting a 4～8 character password using English letters and numbers. After completion, the correct password must be entered to open the short link of the scheduled report.



## Manage Rules

On the scheduled report list page, you can view information such as the name of the scheduled report, associated dashboard, report cycle, and notification targets, and perform the following operations:


- Hover over the dashboard name to display detailed information, including the dashboard name and view variables, and navigate to the corresponding dashboard page by clicking;
- Hover over the report cycle or notification targets to display corresponding detailed information;
- In the action bar on the right side of the report, you can view the creator of the scheduled report and choose to disable, edit, or delete the report.