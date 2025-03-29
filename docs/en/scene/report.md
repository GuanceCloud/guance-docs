# Scheduled Reports {#report}

<<< custom_key.brand_name >>> supports exporting dashboards as reports and can push them to relevant personnel at scheduled intervals such as daily, weekly, or monthly through various channels.


## Create

### Basic Information

1. Dashboard: Select the dashboard for which you want to send a scheduled report;    
2. Modify View Variables: Customize and modify the view variables of the dashboard in the scheduled report;
3. Query Range: Set the time range of the dashboard when sending the report. The default is "Last 1 Day," but you can also manually enter a custom time range.      

???+ warning "Note"

    - The modified view variables apply only to the generated report and do not affect the original default configuration of the dashboard;
    - If the dashboard does not define view variables, this option will not be displayed.

### Scheduling Plan

1. Time Zone: Displays `UTC+08:00` by default and modification is currently unsupported.               
2. Report Time: Set the specific time for sending the scheduled report. Enter a positive integer with the following ranges: hours 0-23; minutes 0-59.               
3. Report Cycle: Set the frequency of sending scheduled reports. Available cycles include:

    - One-time: Send only once at the specified time;
    - Daily: Choose to send every day or specify specific dates (multiple selections supported);
    - Weekly: Choose the frequency based on a weekly time dimension;
    - Monthly: Choose to send every month or specify specific months and dates (multiple selections supported).              

### Notification Types

Currently supports 5 notification types: email groups, DingTalk bots, WeCom bots, Lark bots, Webhook.

1. Notification Targets: Recipients of the current scheduled report. You can create new notification targets in [Monitoring > Notification Targets Management](../monitoring/notify-target.md);               
2. Title: The name of the scheduled report that appears in emails.               
3. Content: The specific content of the scheduled report that appears in emails.               


### Sharing Methods

1. Images: Choose the image format for sharing scheduled reports, including dashboard screenshots or chart screenshots.
        
    - Email/DingTalk bot notifications: By default, the dashboard content is exported as an image. If the data query time range is too long, the data volume is too large, or it includes complex calculations, it may result in blank charts.
    - WeCom bot: Supports choosing between default mode and image mode (only images can be shared in this mode, text cannot be sent, and the image size should be limited to within 2MB)
    - Webhook: Share image links that allow access to the dashboard image via the link.

2. Sharing Methods:

    - Public Sharing: Choose a short link for public sharing of the scheduled report, which can be opened directly;

    - Encrypted Sharing: Requires setting a 4～8 character password consisting of English letters and numbers. After setting, the correct password must be entered to open the short link of the scheduled report.



## Manage Rules

On the scheduled report list page, you can view the name, associated dashboard, report cycle, and notification targets of scheduled reports, and perform the following operations:

- Hover over the dashboard name to display detailed information, including the dashboard name and view variables, and click to navigate to the corresponding dashboard page;
- Hover over the report cycle or notification targets to display corresponding detailed information;
- In the operation bar on the right side of the report, you can view the creator of the scheduled report and choose to disable, edit, or delete the report.