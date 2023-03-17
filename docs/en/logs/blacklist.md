# Blacklist
---

## Overview

Guance supports filtering qualified logs by setting log blacklists, after configuring log blacklists, qualified log data will no longer be reported to the Guance workspace, helping users save log data storage costs.

## Opeartions

### Create 

In the Guance workspace, go to **Log > Blacklist > Create**.

![](img/log-blacklist-en-1.png)

Select **Source**, add one or more log filtering rules, and click **Confirm** to open the log filtering rules by default. You can view all log filtering rules through **Blacklist**. 
 
- Source: All log sources or single log sources can be selected.     
- Filtering: Two conditional choices are supported, "any" and "all". "Any" means at least match one condition,"All" means must match all of conditions.    
- Field name: Manual input of field name is supported, which must be an accurate value. You can view the field name to be matched in the **Display Column** of the log explorer.    
- Field value: Manual input of field value, input of single value and multi-value and regular matching such as abc*, *abc*, *abc and .* is supported.    
- Matching options: 4 modes of `in/not in/match/not match` are supported; `in/not in` is precise match, and `match/not match` is fuzzy match (regular match).     


![](img/log-blacklist-en-2.png)

#### <u>Example</u>

In the following example, datakit's log satisfies `status` as `ok or info`, and `host` as `cc-testing-cluster-001`, and `message` contains the word `kodo`, meaning that data satisfying all three matching rules is filtered and no longer reported to the workspace.

![](img/log-blacklist-en-3.png)

### Edit

On the right side of **Log Blacklist**, click **Edit** to edit the log filtering rules that have been created. In the following example, datakit's log satisfies `status` as `ok or info`, or `host` as `cc-testing-cluster-001`, or `message` contains the word `kodo`, data satisfying any of these three matching rules is filtered and no longer reported to the workspace.

![](img/log-blacklist-en-3.png)

### Delete

On the right side of **Log Blacklist**, click **Delete** to delete the existing log filtering rules. After the filtering rules are deleted, the log data will be reported to the workspace normally.

![](img/log-blacklist-en-4.png)

### Batch

In the Guance workspace **Log > Blacklist**, click **Batch** to **Batch Export** or **Batch Delete** blacklist.

???- attention

    This function is only displayed for workspace owners, administrators and stabdard members, and read-only members are not displayed.

![](img/log-blacklist-en-5.png)

### Import / Export

You can create blacklist by importing or exporting JSON file. Click **Import** or **Export** in **Log > Blacklist** of Guance workspace.

???- attention

    The imported JSON file needs to be the configuration JSON file from Guance.

