# Backup Log
---

## Overview

Guance basic log is stored for up to 60 days. If you need to store and view for a longer time, it needs to be backed up. Log backups are supported in two ways: 
 
- Backup to Guance: Support backup log storage for up to 720 days, we support 180d / 360d / 720d three options to choose.     
- Backup to external storage: Support for backing up logs to Alibaba Cloud OSS, see [Best Practices for Backing Up Log Data to OSS](../best-practices/partner/log-backup-to-oss-by-func.md) for detailed operations.   


## Backup to Guance

### Create Rules

On the **Log Index** page, click **Create** under **Backup Log**. 
 
![](img/backup-log-en-1.png) 
 
Enter **Rule Name** to add a new rule, which supports more accurate positioning of logs to be backed up by adding filters, and saves the storage cost of backup logs. 
 
![](img/backup-log-en-2.png) 


**Note:**

- Backup cycle: Rule verification and backup are performed every 5 minutes, you can see the backup log data after configuring backup rules for up to 5 minutes.    
- Data Preview: Preview logs in the last 15 minutes.
- Filter: Logs can be filtered by filter criteria.    
- Rule name: 30 characters are limited.    
- Free users: Unable to back up log data.    


#### <u>Example</u>
 
In the following picture, the backup log rule name is `datakit_backup`, and log data that matches the filter source  `datakit` or contains `data` is backed up. 

![](img/backup-log-en-3.png)

### View Rules
 
After being created, **Backup Rule** would be stored in **Backup Log** under **Log Index** in a unified way. Once a rule is created, it cannot be edited, but can only be viewed and deleted. Click the **View** button to view the configured backup rule filters. 

![](img/backup-log-en-4.png)

### Delete Rules

If you create a rule that is no longer needed or needs to be modified, you can delete the rule and then create a new backup rule. After the rule is deleted, the backed-up data will not be deleted, but no new log backup data will be generated.

![](img/backup-log-en-5.png)

## Backup Log

Enter the **Log > Backup Log** page to view the log data that meets the backup conditions, and query and analyze the log by selecting time range, searching keywords, filtering, etc. Click on the log to view the log details, including the time and content of the log.     
 
Note: Backup logs only back up the time and contents of the logs.     

![](img/backup-log-en-6.png)

