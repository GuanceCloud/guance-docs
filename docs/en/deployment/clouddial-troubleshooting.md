# Synthetic Tests Troubleshooting

## Testing Self-built Nodes Management Name or service not known {#service-not-known}

### Problem Overview {#overview}

【Self-built Nodes Management】reports `Name or service not known`.

![](img/selfnode-01.png)

### Error Cause {#error-cause}

- Due to load balancing issues with some cloud providers, the service cannot access its own ingress domain.

### Steps {#steps}


#### 1. Open Launcher and Modify Application Configuration {#step-one}

Access the Launcher service and click on `Modify Application Configuration` in the top right corner.

![](img/selfnode-02.png)


#### 2. Add Parameters {#step-two}

Modify the 「Namespace: forethought-core」 - 「core」 by adding the `internal_server` parameter:

```yaml
# Cloud testing service

DialingServer:
   ...
   internal_server: http://dialtesting.utils:9538
```

#### 3. Automatically Restart Related Services After Modifying Configuration {#step-three}

Check the box to automatically restart related services after modifying the configuration.

![](img/selfnode-03.png)



## Synthetic Tests Explorer Data Interruption {#no-data}

### Problem Overview {#overview}

This chapter will introduce how to troubleshoot data interruptions in the Synthetic Tests Explorer.

### Flowchart

![](img/boce-no-data_1.png)

### Troubleshooting Approach

#### Step One: Validate Configuration

1. First, check if the configuration file is correct.

- Check if the ConfigMap named `core` under the forethought-core Namespace is correctly configured.

```shell
# Cloud testing service
DialingServer:
  # Testing service center address configuration
  use_https: true
  port: 443                                     ## Modify according to actual conditions
  host: '<<< custom_key.dial_server_domain >>>'                 ## Modify according to actual conditions
  timeout: 10
```

> **<<< custom_key.dial_server_domain >>>** is the official testing center; if switching to a private testing center, refer to the ingress configuration.

- Check if the ConfigMap named dialtesting-config under the utils Namespace is correctly configured.

```shell
global:
    enable_inner_api: false
    stats_on: 256
    listen: ":9538"
    sys_external_id: "ak_R5Fxxxxxxxxx8Go8-wksp_system"
```

> **sys_external_id** is composed of the **uuid** + **external_id** from the **aksk** table below.

2. Confirm the data in the `aksk` table within the MySQL df_dialtesting database.

```sql
mysql -u <user_name> -p -h <mysql_address>
use df_dialtesting;
select * from aksk;
```

| id   | uuid                | accessKey            | secretKey                  | owner  | parent_ak | external_id | status | version | createAt      | updateAt      |
| ---- | ------------------- | -------------------- | -------------------------- | ------ | --------- | ----------- | ------ | ------- | ------------- | ------------- |
| 1    | ak_R5Fxxxxxxxxx8Go8 | asjTxxxxxxxxxxxxxXMJ | zeiX99gxxxxxxxxxxxxxxxx2h5 | system | -1        | wksp_system | OK     | 0       | 1,686,218,468 | 1,686,218,468 |

3. Compare with the data in the df_core database's main_config where `Keycode` is `DialingServerSet` to ensure consistency.

```sql
use df_core;
select * from main_config;
```

| id   | keyCode          | description  | value                                                        |
| ---- | ---------------- | ------------ | ------------------------------------------------------------ |
| 6    | DialingServerSet | Testing service configuration | "{\"ak\": \"asjTxxxxxxxxxxxxxXMJ\", \"sk\": \"zeiX99gxxxxxxxxxxxxxxxx2h5\", \"dataway\": \"http://deploy-openway.dataflux.cn?token={}\"}" |

4. Compare with the data in the `dialServiceAK` module of launcher for consistency.

Steps: Log in to the launcher interface ---> Top right button ---> Others

 ![](img/boce-no-data_2.png)

Correspondence table:

| Key name in aksk table | Key name in the dialServiceAK module of launcher others configuration |
| ---------------- | ------------------------------------------------- |
| uuid             | ak_id                                             |
| accessKey        | ak                                                |
| secretKey        | sk                                                |

> If inconsistencies are found, make modifications based on the database values.

5. If you have switched the testing center or made modifications, reactivate the license on the launcher page to rewrite the information.

> No need to change the license configuration, just activate it directly.

![](img/boce-no-data_3.png)

![](img/boce-no-data_4.png)

> Confirm the data gateway address matches the example format exactly. **token={}** does not require modification.

#### Step Two: Confirm Communication

On the **Testing Node** machine, use the `ping` command to confirm communication with the testing center and DataWay.

#### Step Three: Check if Data is Reported

Run the following commands on the testing node machine to check if data is reported.

- Check if I/O communication is normal

```shell
sudo datakit monitor -M IO

## DYNAMIC_DW represents the testing center service; Points(ok/total) being consistent indicates no issues.
┌IO Info───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│       Cat│ChanUsage│   Points(ok/total)│                     Bytes(ok/total/gz)                                                                                                                                                          │
│DYNAMIC_DW│      0/1│          626 /626 │         389.392 k/389.392 k(267.603 k)                                                                                                                                                          │
│         M│      0/1│1.7955 M/1.796043 M│560.715703 M/560.880362 M(240.616886 M)                                                                                                                                                          │
│         O│      0/1│  588.045 k/588.2 k│ 516.475667 M/516.613201 M(37.964566 M)


```

- Check if input is normal

```shell

sudo datakit monitor -M In
## Feeds and TotalPts of dialtesting being non-zero indicates data upload.
┌Inputs Info(11 inputs)────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                Input│Cat│    Feeds│ TotalPts│Filtered│      LastFeed│     AvgCost│Errors                                                                                                                                                 │
│          dialtesting│ L │     626 │     626 │      0 │25 minutes ago│          0s│  0                                                                                                                                                    │
│                  cpu│ M │ 112.71 k│ 112.71 k│      0 │ 6 seconds ago│   237.807?s│  0                                                                                                                                                    │

```

#### Step Four: Check Logs

Use the following command to view the `DataKit` logs on the testing node for further problem determination.

```shell
tail -f /var/log/datakit/log | grep dial
```