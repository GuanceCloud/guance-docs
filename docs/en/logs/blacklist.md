# Blacklist
---

Guance supports filtering qualified logs by setting log blacklists, after configuring log blacklists, qualified log data will no longer be reported to the "Guance" workspace, helping users save log data storage costs.

## Create Blacklist Rule 

In the "Guance" workspace, click "Log"-"Blacklist"-"New Blacklist".

![](img/4.log_blacklist_1.png)

Select "Source", add one or more log filtering rules, and click "OK" to open the log filtering rules by default. You can view all log filtering rules through Log Blacklist. 
 
- Source: All log sources or single log sources can be selected     
- Filtering: Two conditional choices are supported, "any" and "all". "Any" means at least match one condition,"All" means must match all of conditions.    
- Field name: Manual input of field name is supported, which must be an accurate value. You can view the field name to be matched in the "Display Column" of the log viewer.    
- Field value: support manual input of field value, support input of single value, multi-value; Support regular matching, such as abc*, *abc*, *abc,. *, etc     
- Matching options: 4 modes of ` in/not in/match/not match ` are supported, ` in/not in ` is precise match, and ` match/not match ` is fuzzy match (regular match)     


![](img/4.log_blacklist_2.png)

### Example

In the following example, datakit's log satisfies ` status ` as ` ok or info `, and ` host ` as ` cc-testing-cluster-001 `, and ` message ` contains the word ` kodo `, meaning that data satisfying all three matching rules is filtered and no longer reported to the workspace.

![](img/4.log_blacklist_3.png)

## Opeartion

### Edit

On the right side of the log blacklist, click the "Edit" icon to edit the log filtering rules that have been created. In the following example, datakit's log satisfies ` status ` as ` ok or info `, or ` host ` as ` cc-testing-cluster-001 `, or ` message ` contains the word ` kodo `, data satisfying any of these three matching rules is filtered and no longer reported to the workspace.

![](img/4.log_blacklist_4.png)

### Delete

On the right side of the log blacklist, click the "Delete" icon to delete the existing log filtering rules. After the filtering rules are deleted, the log data will be reported to the workspace normally.

![](img/1.log_5.png)

### Batch operation

In the Guance workspace "Log"-"Blacklist", click "Batch Operation" to "Batch Export" or "Batch Delete" blacklist.

???- attention

    This function is only displayed for workspace owners, administrators and ordinary members, and read-only members are not displayed.

![](img/2.log_blacklist_1.png)

### Import / Export

You can create blacklist by importing/exporting JSON file. Click "import/export blacklist" in "log"-"blacklist" of Guance workspace.

???- attention

    The imported JSON file needs to be the configuration JSON file from Guance.

