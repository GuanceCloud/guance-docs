# Scheduled Reports {#report}

Export dashboards as reports and schedule them to be sent via multiple channels according to time dimensions such as daily, weekly, or monthly.


## Create

### Basic Information

1. Dashboard: Select the dashboard for which you want to send a scheduled report;    
2. Modify View Variables: Customize and modify the view variables of the dashboard in the scheduled report;
3. Query Range: Set the time range of the dashboard when sending the report. The default is "Last 1 Day," but you can also manually input a custom time range.      

???+ warning "Note"

    - The modified view variables here apply only to the generated report and do not affect the original default configuration of the dashboard;
    - If no view variables are defined in the dashboard, this option will not appear.

### Scheduling Plan

1. Time Zone: Defaults to `UTC+08:00`, modification is temporarily unsupported.               
2. Report Time: Set the specific time for sending the scheduled report. Enter positive integers within the following ranges: hours 0-23; minutes 0-59.               
3. Report Frequency: Set the frequency of sending scheduled reports. Options include:

    - One-time: Sends only once at the specified time;
    - Daily: Choose to send every day or specify certain dates (supports multiple selections);
    - Weekly: Choose the frequency based on the weekly time dimension;
    - Monthly: Choose to send every month or specify certain months and dates (supports multiple selections).              

### Notification Types

Currently supports 5 notification types: email groups, DingTalk bots, WeCom bots, Lark bots, and Webhook.

1. Notification Targets: Recipients of the current scheduled report. You can create new notification targets in [Monitoring > Notification Targets Management](../monitoring/notify-target.md);               
2. Title: The name displayed in the email for the scheduled report;               
3. Content: The specific content displayed in the email for the scheduled report.               


### Sharing Methods

1. Image: Choose the image format for sharing the scheduled report, including dashboard screenshots or chart screenshots.
        
    - Email/DingTalk bot notifications: The dashboard content is exported as an image by default. If the data query time range is too long, the data volume is too large, or it contains complex calculations, the charts may appear blank.
    - WeCom bot: Supports default mode and image mode (in this mode, only images can be shared, text cannot be sent, and the image size should be limited to within 2MB).
    - Webhook: Supports sharing image links, accessible via the link to the dashboard image.

2. Sharing Method:

    - Public Sharing: Choose the short link for public sharing of the scheduled report, which can be opened directly;

    - Encrypted Sharing: Requires setting a 4-8 character password with English letters and numbers. After setting, the correct password must be entered to open the short link for the scheduled report.



## Manage Rules

On the scheduled reports list page, you can view information such as the name of the scheduled report, associated dashboard, report frequency, and notification targets, and perform the following actions:


- Hover over the dashboard name to display detailed information, including the dashboard name and view variables, and click to navigate to the corresponding dashboard page;
- Hover over the report frequency or notification targets to display the corresponding detailed information;
- In the operations bar on the right side of the report, you can view the creator of the scheduled report and choose to disable, edit, or delete the report.