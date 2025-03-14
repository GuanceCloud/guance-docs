## 1 Host List is Empty After Switching Storage Engine to Doris
### Problem Description:
After switching the storage engine to Doris, when creating a new workspace, data can be queried in logs, but the host list in infrastructure is empty with no information.
When adjusting the search end time to one day after the current time (e.g., if the current time is April 23 at 4 PM, adjust the query end time to April 24 at 4 PM), content can be queried in the infrastructure.

### Solution:
Check the timezone configuration of the Doris cluster to ensure it is set to Asia/Shanghai. If not, modify it to Asia/Shanghai.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show variables like '%time_zone%';
# If the result is not Asia/Shanghai, use the following command to modify
set global time_zone = "Asia/Shanghai";
```

## 2 Doris Insert Component Error: Insufficient Disk Space
### Problem Description:
<<< custom_key.brand_name >>> data reporting anomalies occur, NSQ has backlog, but there are no errors in queries. Checking the Doris-logs insert component log reveals insufficient disk space, which can also be verified using the `df -h` command.
![](img/faq-doris-1.png)

### Solution:
Remount the directory and restart the insert component. If this issue occurs frequently, consider upgrading the memory of the Doris-logs server.
```shell
# For a machine with 16G RAM, size=8G; for 32G RAM, size=16G; for 64G RAM, size=16G or size=32G
mount -o size=8G -t tmpfs none /data-tmp && sudo supervisorctl restart guance-insert
```

## 3 Doris BE Node Disk Usage Reaches 100%
### Problem Description:
<<< custom_key.brand_name >>> data reporting and query anomalies occur, NSQ has backlog. Checking the logs reveals that the BE node disk usage is 100%.

### Solution:
Delete tables to free up disk space.
???+ warning "Note"
     In test environments, you can delete unnecessary tables. In production environments, deleting tables is prohibited; instead, expand the disk.

#### Method 1 to Identify Large Tables:
If BE is a single node, it might execute an error.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030

# Retrieve table names with large data volumes
select concat(table_schema, '.', table_name)
from information_schema.tables
where table_schema like 'db%'
order by data_length desc
limit 1;

# Drop the table 
drop table <table_name>;
```

#### Method 2 to Identify Large Tables:

If self-monitoring is integrated, check the Doris dashboard's [Top 10 Table Write QPS] item to identify large tables.
![](img/faq-doris-2.png)
From this graph, obtain the accountID 
```sql
drop table db_<accountID>_0.L_default;
```
Use either method to delete large tables and free up disk space, then restart BE.
```sql
# Remove bad disk marking on BE node machine
sed -i '/broken/d' /home/doris/doris/be/conf/be_custom.conf
# Restart BE
Log in to manager web to restart the BE node
```

## 4 How to Verify Whether Hot Data Modification at Workspace Level is Effective
### Problem Description:
In the <<< custom_key.brand_name >>> backend, the retention period for hot data at the workspace level was modified. How to verify if the modification is effective.
![](img/faq-doris-3.png)

### Solution:
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show storage policy;
# CooldownTtl is the hot data duration (in seconds), PolicyName is the corresponding object, and the middle number is the workspace ID
```
![](img/faq-doris-4.png)

## 5 Doris Server Doris User Password Expiration
### Problem Description:
The Doris user password on the Doris server expires, causing the manager to fail to manage the cluster properly.

### Solution:

#### Option 1:

Modify the Doris user password expiration policy
```shell
# Check the password policy for the user
chage -l username
# -M -1 means the password never expires; refer to chage documentation for more details
chage -M -1 username
```

#### Option 2:

Change the Doris user password on all Doris servers (ensure the passwords are consistent), then cancel and re-manage the cluster on manager-web (fe01_ip:8004).
![](img/faq-doris-5.png)

## 6 Doris Cluster BE Node Reduction
### Problem Description:
Due to reduced data volume, the Doris cluster configuration is too high and needs to reduce BE nodes.

### Solution:

Offline BE nodes via manager-web.
![](img/faq-doris-6.png)
![](img/faq-doris-7.png)
Wait until the tablet count of the offline BE node decreases to zero.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show backends;
# TabletNum and DataUsedCapacity should reduce to 0, indicating data migration is complete
```
Reclaim the decommissioned node machine.

## 7 Clicking Host Object Page Results in Error: Kodo Service API Request Error: Service Unavailable

### Problem Description:
Clicking the host object results in a Kodo service API request error: Service Unavailable.

### Solution:

Check the GuanceDB for logs select component log and find the error 

``` shell
connect: connection refused" (Unavailable; AuthenticateBasicToken)
```

Log in to the Doris manager web, check the BE role parameters, and notice that the `arrow_flight_sql_port` parameter does not exist. Add the `arrow_flight_sql_port` parameter for the BE node in the manager.

```shell
arrow_flight_sql_port = 9090 
```

After adding, restart the BE node.