# Log Backup
---

## Introduction

Guance Cloud basic log is stored for up to 60 days. If it needs to be stored and viewed for a longer time, it needs to be backed up. Log backups are supported in two ways:

- Backup to Guance Cloud: Support backup log storage for up to 720 days.
- Backup to external storage: Support for backing up logs to Alibaba Cloud OSS, refer to the documentation [best practices for backing up log data to OSS](../best-practices/partner/log-backup-to-oss-by-func.md).

Guance Cloud basic log is stored for up to 60 days. If you need to store and view for a longer time, it needs to be backed up. Log backups are supported in two ways: 
 
-Backup to Guance Cloud: Support backup log storage for up to 720 days,we support 180d /360d /720d three options to choose. 
-Backup to external storage: Support for backing up logs to Alibaba Cloud OSS, refer to the documentation [Best Practices for Backing Up Log Data to OSS] (../best-practices/partner/log-backup-to-oss-by-func.md). 


## Backup to Guance Cloud

### Create Rule

On the Log Index page, click New Rule under Backup Log. 
 
![](img/7.backup_1.png) 
 
Enter "Rule Name" to add a new rule, which supports more accurate positioning of logs to be backed up by adding filters, and saves the storage cost of backup logs. 
 
![](img/7.backup_2.png) 


**Note**

-Backup cycle: Rule verification and backup are performed every 5 minutes, you can see the backup log data after configuring backup rules for up to 5 minutes 
-Data Preview: Preview the last 15 minutes log 
-Filter: Log can be filtered by filter criteria 
-Rule name: Limit input to 30 characters 
-Free users: Unable to back up log data 


#### Example
 
In the following picture, the log backup rule name is ` datakit_backup `, and log data with filter matching source ` datakit ` or content containing ` data ` is backed up. 


![](img/7.backup_3.png)

### View Rule
 
After the backup rule is created, the "backup log" stored under the log index is unified. Once a rule is created, it cannot be edited, but can only be viewed and deleted. Click the "View" button to view the configured backup rule filters. 

![](img/7.backup_4.png)

### Delete Rule

If you create a rule that is no longer needed or needs to be modified, you can delete the rule and then create a new backup rule. After the rule is deleted, the backed-up data will not be deleted, but no new log backup data will be generated.

![](img/7.backup_5.png)

## Backup Explorer

Enter the "Log"-"Backup Log" page to view the log data that meets the backup conditions, and query and analyze the log by selecting time range, searching keywords, filtering, etc. Click on the log to view the log details, including the time and content of the log. 
 
Note: Backup logs only back up the time and contents of the logs. 

![](img/8.log_backup_1.png)

