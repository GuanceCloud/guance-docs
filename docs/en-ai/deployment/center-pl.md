### Introduction

This section introduces enabling the Pipeline feature in the center.

### Operating Steps

#### Step One: Studio Configuration
The center Pipeline feature has two configuration switches, **site-level** and **workspace-level**

**Site-level**: Configures the default "workspace-level central PL service" switch for newly created workspaces.

**Workspace-level**: Indicates whether the current workspace has the "workspace-level central PL service" enabled.

Currently, modifying the configuration requires connecting to the df_core database. You can obtain the database information through the following steps:

1. Visit the launcher address in your browser, click on the function key in the top right corner --> MySQL to get the df_core user information.
![center-pl-mysql-1.png](img/center-pl-mysql-1.png)
![center-pl-mysql-2.png](img/center-pl-mysql-2.png)
2. Connect to the df_core database using a MySQL client tool or from within the launcher container.
```shell
# Enter the launcher container
kubectl -n launcher get po | grep launcher
kubectl -n launcher exec -it launcher_podname bash
# Connect to MySQL
mysql -h mysql_host -P mysql_port -u df_core -p
```
3. Execute the corresponding SQL statements based on your scenario.

In actual use, we may have the following scenarios:

* **When deploying, enable the central PL feature for all workspaces**
```sql
-- [Enable] Central PL service switch
INSERT INTO `main_config` (`keyCode`, `description`, `value`) VALUES ('CentralPLServiceSwitch', 'Central PL service support status switch. When isOpen=true, newly created workspaces will have the custom central PL service support switch enabled by default, which corresponds to keyCode=CustomCentralPLServiceSwitch', '{\"isOpen\": true}') ON DUPLICATE KEY UPDATE description=VALUES(description),value=VALUES(value);
```
* After using the system for some time, **enable the central PL feature for all workspaces**
```sql
-- [Enable] Central PL service switch; Insert configuration items for unconfigured workspaces
insert into main_workspace_config (uuid, workspaceUUID, keyCode, config, creator, updator, createAt, deleteAt, updateAt)
select
    CONCAT('ctcf_', REPLACE(UUID(), '-', '')) as uuid,
    w.uuid as workspaceUUID,
    "CustomCentralPLServiceSwitch" as keyCode,
    '{"isOpen": true}' as config,
     'SYS' as creator,
     'SYS' as updator,
     UNIX_TIMESTAMP(NOW()) as createAt,
     '-1' as deleteAt,
     UNIX_TIMESTAMP(NOW()) as updateAt
from
    main_workspace as w
where
    status=0
    and uuid not in (
        select
            distinct(workspaceUUID)
        from
            main_workspace_config
        where
            status=0
            and keyCode='CustomCentralPLServiceSwitch'
    );
```
After enabling the central PL feature for existing workspaces, if you want new workspaces to also have it enabled, execute the following SQL statement (changing true to false in the value field will prevent new workspaces from having the central PL feature enabled):
```sql
INSERT INTO `main_config` (`keyCode`, `description`, `value`) VALUES ('CentralPLServiceSwitch', 'Central PL service support status switch. When isOpen=true, newly created workspaces will have the custom central PL service support switch enabled by default, which corresponds to keyCode=CustomCentralPLServiceSwitch', '{\"isOpen\": true}') ON DUPLICATE KEY UPDATE description=VALUES(description),value=VALUES(value);
```
* After using the system for some time, **enable the central PL feature for some workspaces**
```sql
-- [Enable] Central PL service switch; Insert configuration items for unconfigured workspaces
insert into main_workspace_config (uuid, workspaceUUID, keyCode, config, creator, updator, createAt, deleteAt, updateAt)
select
    CONCAT('ctcf_', REPLACE(UUID(), '-', '')) as uuid,
    w.uuid as workspaceUUID,
    "CustomCentralPLServiceSwitch" as keyCode,
    '{"isOpen": true}' as config,
     'SYS' as creator,
     'SYS' as updator,
     UNIX_TIMESTAMP(NOW()) as createAt,
     '-1' as deleteAt,
     UNIX_TIMESTAMP(NOW()) as updateAt
from
    main_workspace as w
where
    status=0
    and uuid in ('<workspace UUID1>')
    and uuid not in (
        select
            distinct(workspaceUUID)
        from
            main_workspace_config
        where
            status=0
            and keyCode='CustomCentralPLServiceSwitch'
    );
```

#### Step Two: Enable Kodo Service Central PL Configuration
During Kodo deployment, a configuration is required to determine whether workspaces can enable the central PL/blacklist feature. This needs to be added to the kodo and kodo-x ConfigMaps under the forethought-kodo namespace. After adding the content, restart the kodo and kodo-x services.
```yaml
pipeline:
    enable: true            
    pull_duration: "1m"    

# enable: Whether to enable the central Pipeline feature, true for enable, false for disable
# pull_duration: Script fetching interval
```
![kodo-cm.png](img/kodo-cm.png)