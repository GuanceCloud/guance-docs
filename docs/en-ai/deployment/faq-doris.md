## 1 Storage Engine Switched to Doris, Host List is Empty
### Problem Description:
After switching the storage engine to Doris, when creating a new workspace, data can be queried in logs, but the host list in infrastructure is empty with no information.
When the search end time is adjusted to one day after the current time, for example, if the current time is 4:00 PM on April 23rd, adjusting the query end time to 4:00 PM on April 24th allows content to be queried in the infrastructure.

### Solution:
Check the timezone configuration of the Doris cluster to ensure it is set to Asia/Shanghai. If not, change it to Asia/Shanghai.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show variables like '%time_zone%';
# If the result is not Asia/Shanghai, modify it using the following command
set global time_zone = "Asia/Shanghai";
```

## 2 Doris Insert Component Error: Insufficient Disk Space
### Problem Description:
Data reporting anomalies occur in Guance, with NSQ backlog, but no errors are reported in queries. Checking the Doris-logs insert component logs reveals insufficient disk space, which can also be verified using the `df -h` command.
![](img/faq-doris-1.png)

### Solution:
Remount the directory and restart the insert component. If this issue occurs frequently, consider upgrading the memory of the Doris-logs server.
```shell
# For machines with 16GB RAM, size=8G; for 32GB RAM, size=16G; for 64GB RAM, size=16G or size=32G
mount -o size=8G -t tmpfs none /data-tmp && sudo supervisorctl restart guance-insert
```

## 3 Doris BE Node Disk Usage at 100%
### Problem Description:
Data reporting and query anomalies occur in Guance, with NSQ backlog. Logs reveal that the disk usage of the BE node is at 100%.

### Solution:
Delete tables to free up disk space.
???+ warning "Note"
     In test environments, you can delete tables if the data is not needed. In production environments, deleting tables is prohibited; instead, expand the disk capacity.

#### Method One to Identify Large Tables:
If the BE is a single node, this might result in an error.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030

# Retrieve the names of large tables
select concat(table_schema, '.', table_name)
from information_schema.tables
where table_schema like 'db%'
order by data_length desc
limit 1;

# Drop the table 
drop table <table_name>;
```

#### Method Two to Identify Large Tables:
If self-monitoring is integrated, check the Doris dashboard item [Table Write QPS TOP 10] to identify large tables.
![](img/faq-doris-2.png)
Retrieve the accountID from this chart.
```sql
drop table db_<accountID>_0.L_default;
```
Free up disk space by deleting large tables using either method and then restart the BE.
```sql
# Remove bad disk marking on the BE node machine
sed -i '/broken/d' /home/doris/doris/be/conf/be_custom.conf
# Restart the BE
Log in to the manager web to restart the BE node
```

## 4 How to Verify Whether Hot Data Modification at Workspace Level is Effective
### Problem Description:
In the Guance backend, the retention period for hot data at the workspace level has been modified. How to verify whether the modification is effective.
![](img/faq-doris-3.png)

### Solution:
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show storage policy;
# CooldownTtl is the hot data duration (in seconds), PolicyName is the corresponding object, and the middle number is the workspace ID
```
![](img/faq-doris-4.png)

## 5 Doris Server User Password Expiration
### Problem Description:
The password for the doris user on the Doris server has expired, preventing the manager from properly managing the cluster.

### Solution:

#### Option One:
Modify the password expiration policy for the doris user.
```shell
# Check the password policy for the user
chage -l username
# -M -1 indicates the password never expires; refer to chage documentation for more details
chage -M -1 username
```

#### Option Two:
Change the passwords for all doris users on the Doris servers (ensure consistency across all passwords), then in the manager-web (fe01_ip:8004), unmanage the cluster and re-manage it.
![](img/faq-doris-5.png)

## 6 Doris Cluster BE Node Reduction
### Problem Description:
Due to reduced data volume, the Doris cluster configuration is too high and needs to reduce the number of BE nodes.

### Solution:
Offline the BE nodes in the manager-web.
![](img/faq-doris-6.png)
![](img/faq-doris-7.png)
Wait until the tablet count on the offline BE nodes is fully migrated.
```sql
# Connect to the cluster using MySQL command on the FE machine
mysql -uroot -h127.0.0.1 -P 9030
show backends;
# TabletNum and DataUsedCapacity should reduce to 0, indicating data migration completion
```
Reclaim the decommissioned node machines.