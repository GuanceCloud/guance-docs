### Introduction

This section introduces the function of enabling Pipeline in the center.

### Procedure

#### Step One: Studio Configuration
The center Pipeline feature has two switches, **site-level** and **workspace-level**.

**Site-level**: Configure the default **workspace-level center PL service** switch for newly created workspaces.

**Workspace-level**: Indicates whether the current workspace enables the **workspace-level center PL service**.

At this stage, modifying the configuration requires connecting to the df_core database. Follow these steps to obtain the database information:

1. Visit the launcher address in your browser, click the function key in the top-right corner --> MySQL to get the df_core user information.
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
3. Execute the following SQL based on your scenario.

In actual use, you may encounter the following scenarios:

* **Enabling the center PL feature for all workspaces during deployment**
```sql
-- [Enable] Center PL service switch
INSERT INTO `main_config` (`keyCode`, `description`, `value`) VALUES ('CentralPLServiceSwitch', 'Center PL service support status switch. When isOpen=true, newly created workspaces will have the custom center PL service support switch enabled by default, which corresponds to keyCode=CustomCentralPLServiceSwitch', '{\"isOpen\": true}') ON DUPLICATE KEY UPDATE description=VALUES(description),value=VALUES(value);
```
* Enabling the center PL feature for **all existing workspaces** after some system usage
```sql
-- [Enable] Center PL service switch; insert configuration items for unconfigured workspaces
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
After enabling the center PL feature for existing workspaces, if you want subsequent new workspaces to also have it enabled, execute the following SQL (change the value field to false if you do not want new workspaces to enable the center PL feature).
```sql
INSERT INTO `main_config` (`keyCode`, `description`, `value`) VALUES ('CentralPLServiceSwitch', 'Center PL service support status switch. When isOpen=true, newly created workspaces will have the custom center PL service support switch enabled by default, which corresponds to keyCode=CustomCentralPLServiceSwitch', '{\"isOpen\": true}') ON DUPLICATE KEY UPDATE description=VALUES(description),value=VALUES(value);
```
* Enabling the center PL feature for **specific workspaces** after some system usage
```sql
-- [Enable] Center PL service switch; insert configuration items for unconfigured workspaces
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
    and uuid in ('<workspaceUUID1>')
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

#### Step Two: Enable Kodo Service Center PL Configuration
When deploying Kodo, an additional configuration is required: whether to allow workspaces to enable the center PL/blacklist feature. Modify the ConfigMaps kodo and kodo-x under the forethought-kodo namespace and add the following content. After adding, restart the kodo and kodo-x services.
```yaml
pipeline:
    enable: true            
    pull_duration: "1m"    

# enable: Whether to enable the center Pipeline feature, true for enabled, false for disabled
# pull_duration: Script fetch interval
```
![kodo-cm.png](img/kodo-cm.png)