# Troubleshooting Synthetic Tests

## Managing User-defined Nodes for Synthetic Tests Name or service not known {#service-not-known}

### Problem Overview {#overview}

The "User-defined Node Management" reports `Name or service not known`.

![](img/selfnode-01.png)

### Cause of Error {#error-cause}

- Due to load balancing issues with some cloud providers, the service cannot access its own ingress domain.

### Steps to Resolve {#steps}

#### 1. Open Launcher to Modify Application Configuration {#step-one}

Access the Launcher service and click on `Modify Application Configuration` in the top-right corner.

![](img/selfnode-02.png)

#### 2. Add Parameters {#step-two}

Modify the `forethought-core` namespace - `core` by adding the `internal_server` parameter:

```yaml
# Cloud Synthetic Tests Service

DialingServer:
   ...
   internal_server: http://dialtesting.utils:9538
```

#### 3. Automatically Restart Related Services After Configuration Changes {#step-three}

Check the box to automatically restart related services after modifying the configuration.

![](img/selfnode-03.png)

## Data Discontinuity in Synthetic Tests Explorer {#no-data}

### Problem Overview {#overview}

This section will guide you through troubleshooting data discontinuities in the Synthetic Tests Explorer.

### Flowchart

![](img/boce-no-data_1.png)

### Troubleshooting Approach

#### Step One: Validate Configuration

1. First, check if the configuration files are correct.

- Verify the ConfigMap named `core` under the `forethought-core` namespace is correctly configured.

```shell
# Cloud Synthetic Tests Service
DialingServer:
  # Address configuration for the Synthetic Testing Center
  use_https: true
  port: 443                                     ## Modify according to actual conditions
  host: 'dflux-dial.guance.com'                 ## Modify according to actual conditions
  timeout: 10
```

> **dflux-dial.guance.com** is the official dial testing center. If switching to a private dial testing center, review the ingress configuration.

- Verify the ConfigMap named `dialtesting-config` under the `utils` namespace is correctly configured.

```shell
global:
    enable_inner_api: false
    stats_on: 256
    listen: ":9538"
    sys_external_id: "ak_R5Fxxxxxxxxx8Go8-wksp_system"
```

> **sys_external_id** is composed of the **uuid** and **external_id** from the **aksk** table below.

2. Confirm the data in the `aksk` table within the MySQL `df_dialtesting` database.

```sql
mysql -u <user_name> -p -h <mysql_address>
use df_dialtesting;
select * from aksk;
```

| id   | uuid                | accessKey            | secretKey                  | owner  | parent_ak | external_id | status | version | createAt      | updateAt      |
| ---- | ------------------- | -------------------- | -------------------------- | ------ | --------- | ----------- | ------ | ------- | ------------- | ------------- |
| 1    | ak_R5Fxxxxxxxxx8Go8 | asjTxxxxxxxxxxxxxXMJ | zeiX99gxxxxxxxxxxxxxxxx2h5 | system | -1        | wksp_system | OK     | 0       | 1,686,218,468 | 1,686,218,468 |

3. Compare this with the `main_config` table in the `df_core` database where `keyCode` is `DialingServerSet`.

```sql
use df_core;
select * from main_config;
```

| id   | keyCode          | description  | value                                                        |
| ---- | ---------------- | ------------ | ------------------------------------------------------------ |
| 6    | DialingServerSet | Dial Testing Service Configuration | "{\"ak\": \"asjTxxxxxxxxxxxxxXMJ\", \"sk\": \"zeiX99gxxxxxxxxxxxxxxxx2h5\", \"dataway\": \"http://deploy-openway.dataflux.cn?token={}\"}" |

4. Compare this with the data in the `dialServiceAK` module in Launcher.

Steps: Log in to the Launcher interface ---> Top-right button ---> Other

 ![](img/boce-no-data_2.png)

Correspondence Table:

| Key name in aksk table | Key name in dialServiceAK module of Launcher's other configurations |
| ---------------------- | ------------------------------------------------------------------ |
| uuid                   | ak_id                                                             |
| accessKey              | ak                                                                |
| secretKey              | sk                                                                |

> If inconsistencies are found, modify them based on the database.

5. If the dial testing center has been switched or modified, reactivate the license on the Launcher page to rewrite the information.

> No need to change the license configuration; just reactivate it.

![](img/boce-no-data_3.png)

![](img/boce-no-data_4.png)

> Confirm that the data gateway address matches the example format exactly. **token={}** should not be modified.

#### Step Two: Confirm Communication

Use the `ping` command on the **dial testing node** machine to confirm connectivity with the dial testing center and DataWay.

#### Step Three: Check if Data is Reported

Run the following commands on the dial testing node to check if data is being reported.

- Check if I/O communication is normal

```shell
sudo datakit monitor -M IO

## DYNAMIC_DW represents the service of the dial testing center; Points(ok/total) being consistent indicates no issues.
┌IO Info───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│       Cat│ChanUsage│   Points(ok/total)│                     Bytes(ok/total/gz)                                                                                                                                                          │
│DYNAMIC_DW│      0/1│          626 /626 │         389.392 k/389.392 k(267.603 k)                                                                                                                                                          │
│         M│      0/1│1.7955 M/1.796043 M│560.715703 M/560.880362 M(240.616886 M)                                                                                                                                                          │
│         O│      0/1│  588.045 k/588.2 k│ 516.475667 M/516.613201 M(37.964566 M)


```

- Check if input is normal

```shell

sudo datakit monitor -M In
## Feeds and TotalPts of dialtesting not being zero indicates data upload.
┌Inputs Info(11 inputs)────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                Input│Cat│    Feeds│ TotalPts│Filtered│      LastFeed│     AvgCost│Errors                                                                                                                                                 │
│          dialtesting│ L │     626 │     626 │      0 │25 minutes ago│          0s│  0                                                                                                                                                    │
│                  cpu│ M │ 112.71 k│ 112.71 k│      0 │ 6 seconds ago│   237.807?s│  0                                                                                                                                                    │

```

#### Step Four: Review Logs

Use the following command to view `DataKit` logs on the dial testing node to further diagnose the issue.

```shell
tail -f /var/log/datakit/log | grep dial
```