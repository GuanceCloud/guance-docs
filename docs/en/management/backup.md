# Backup Log
---

## Overview

After log backup rules is created, the local log would be uploaded (copied) to the backup space in real time to form a log backup. Based on the log backup feature, you can restore data to any point in time during the backup retention time.<br/> This article describes how to back up logs to Guance for viewing and analysis.<br/>

Log backups are supported in two ways:<br/><br/>
- Backup to Guance: The maximum storage time of Guance basic log is 60 days, and the maximum storage time of backup log is 720 days. See the doc [Data Storage Policy](../billing/billing-method/data-storage.md) for more info.     
- Backup to external storage: You can back up logs to Alibaba Cloud OSS, see the doc [Best Practices for Backing Up Log Data to OSS](../best-practices/partner/log-backup-to-oss-by-func.md) for more info.  


## Setup

### Create Rules

On the **Log Index** page, click **Create** under **Backup Log**. 
 
![](img/backup-log-en-1.png) 
 
Enter **Rule Name** to add a new rule.
 
![](img/backup-log-en-2.png) 


**Note:**

- Data Preview: Preview logs in the last 15 minutes.
- Rule Name: 30 characters are limited.   
- Synchronous Backup Extended Field: If this option is checked, the entire log data that meets the filter criteria would be backed up. You can go to the **Backup Log** details page to filter and view the information corresponding to the extended fields.  
- Filter: Logs can be filtered by adding filters.   

???+ attention

    - Only users of Guance Commercial Plan can use backup log, and users from Experience Plan  can [upgrade to commercial version](../billing/commercial-version.md) first;  
    - Backup Cycle: Rule verification and backup are performed every 5 minutes, you can see the backup log data after configuring backup rules for up to 5 minutes.     

## Backup Log

Enter **Log > Backup Log** to view the log data that meets the backup conditions.

- Time Widget: Selecting the generated time range of backup logs that you want to view.  
- Search and Filter: Positioning backup logs by searching for keywords or filtering fields.  
- Display column: If you check **Synchronous Backup Extended Field** when creating backup log rules, you can add customizing fields other than **Time** and **Message**.


- Backup Log Details: Click any log to view the log details, including log generation time, content and extended fields.  

![](img/backup-log-en-6.png)


### View Rules
 
After being created, **Backup Rule** would be stored in **Backup Log** under **Log Index** in a unified way. Click the **View** button to view the configured backup rule filters. 

> Once a rule is created, it cannot be edited, but can only be viewed and deleted. 

![](img/backup-log-en-4.png)


### Delete Rules

If you create a rule that is no longer needed or needs to be modified, you can delete the rule and then create a new backup rule. 

> After the rule is deleted, the backed-up data will not be deleted, but no new log backup data will be generated.

![](img/backup-log-en-5.png)


#### <u>Example</u>
 
In the following picture, the backup log rule name is `http_dial_testing`, and the extended fields need to be backed up synchronously. The filter matches the data whose source is `http_dial_testing`.

![](img/backup-log-en-3.png)

You can check the filtered backup logs that meet created rules in **Backup Log**. Click any log to enter details page and you can gain information on its sorce, message and extended fileds.




