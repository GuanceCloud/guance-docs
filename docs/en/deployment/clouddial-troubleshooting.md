# Troubleshooting Availability Monitoring

## Managing Self-built Nodes for Synthetic Tests Name or service not known {#service-not-known}

### Problem Overview {#overview}

The "Name or service not known" error occurs in the self-built node management.

![](img/selfnode-01.png)

### Error Cause {#error-cause}

- Due to load balancing issues with some cloud providers, services cannot access their own ingress domain.

### Steps {#steps}

#### 1. Open Launcher and Modify Application Configuration {#step-one}

Access the Launcher service and click on `Modify Application Configuration` in the top-right corner.

![](img/selfnode-02.png)

#### 2. Add Parameters {#step-two}

Edit the `internal_server` parameter under the namespace `forethought-core` - `core`:

```yaml
# Cloud Synthetic Tests service

DialingServer:
   ...
   internal_server: http://dialtesting.utils:9538
```

#### 3. Automatically Restart Related Services After Modifying Configuration {#step-three}

Select the option to automatically restart related services after modifying the configuration.

![](img/selfnode-03.png)

## Data Discontinuity in Synthetic Tests Explorer {#no-data}

### Problem Overview {#overview}

This section describes how to troubleshoot data discontinuity issues in the Synthetic Tests Explorer.

### Flowchart

![](img/boce-no-data_1.png)

### Troubleshooting Approach

#### Step One: Verify Configuration

1. First, check if the configuration files are correct:

- Verify the ConfigMap named `core` under the `forethought-core` Namespace:

```shell
# Synthetic Tests service
DialingServer:
  # Address configuration for the Synthetic Tests center
  use_https: true
  port: 443                                     ## Modify based on actual conditions
  host: 'dflux-dial.guance.com'                 ## Modify based on actual conditions
  timeout: 10
```

> **dflux-dial.guance.com** is the official Synthetic Tests center. If switching to a private Synthetic Tests center, please refer to the ingress configuration.

- Verify the ConfigMap named `dialtesting-config` under the `utils` Namespace:

```shell
global:
    enable_inner_api: false
    stats_on: 256
    listen: ":9538"
    sys_external_id: "ak_R5Fxxxxxxxxx8Go8-wksp_system"
```

> **sys_external_id** consists of the **uuid** + **external_id** from the **aksk** table below.

2. Confirm the data in the `aksk` table within the MySQL `df_dialtesting` database:

```sql
mysql -u <user_name> -p -h <mysql_address>
use df_dialtesting;
select * from aksk;
```

| id   | uuid                | accessKey            | secretKey                  | owner  | parent_ak | external_id | status | version | createAt      | updateAt      |
| ---- | ------------------- | -------------------- | -------------------------- | ------ | --------- | ----------- | ------ | ------- | ------------- | ------------- |
| 1    | ak_R5Fxxxxxxxxx8Go8 | asjTxxxxxxxxxxxxxXMJ | zeiX99gxxxxxxxxxxxxxxxx2h5 | system | -1        | wksp_system | OK     | 0       | 1,686,218,468 | 1,686,218,468 |

3. Compare with the data in the `main_config` table in the `df_core` database where `keyCode` is `DialingServerSet`:

```sql
use df_core;
select * from main_config;
```

| id   | keyCode          | description  | value                                                        |
| ---- | ---------------- | ------------ | ------------------------------------------------------------ |
| 6    | DialingServerSet | Synthetic Tests service configuration | "{\"ak\": \"asjTxxxxxxxxxxxxxXMJ\", \"sk\": \"zeiX99gxxxxxxxxxxxxxxxx2h5\", \"dataway\": \"http://deploy-openway.dataflux.cn?token={}\"}" |

4. Compare with the data in the `dialServiceAK` module in launcher:

Steps: Log in to the launcher interface ---> Top-right button ---> Others

 ![](img/boce-no-data_2.png)

Correspondence table:

| Key name in aksk table | Key name in dialServiceAK module of launcher others configuration |
| ---------------------- | ------------------------------------------------------------------ |
| uuid                   | ak_id                                                             |
| accessKey              | ak                                                                |
| secretKey              | sk                                                                |

> If there are inconsistencies, make changes according to the database.

5. If you have switched the Synthetic Tests center or made modifications, reactivate the license on the launcher page to rewrite the information.

> No need to change the license configuration; just reactivate it.

![](img/boce-no-data_3.png)

![](img/boce-no-data_4.png)

> Confirm that the data gateway address matches the example format exactly. **token={}** does not need to be modified.

#### Step Two: Confirm Communication

Use the `ping` command on the **Synthetic Tests node** machine to confirm communication with the Synthetic Tests center and DataWay.

#### Step Three: Check Data Reporting

Run the following commands on the Synthetic Tests node machine to check if data is being reported:

- Check I/O communication:

```shell
sudo datakit monitor -M IO

## DYNAMIC_DW represents the Synthetic Tests center service; Points(ok/total) being consistent indicates no issues.
┌IO Info───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│       Cat│ChanUsage│   Points(ok/total)│                     Bytes(ok/total/gz)                                                                                                                                                          │
│DYNAMIC_DW│      0/1│          626 /626 │         389.392 k/389.392 k(267.603 k)                                                                                                                                                          │
│         M│      0/1│1.7955 M/1.796043 M│560.715703 M/560.880362 M(240.616886 M)                                                                                                                                                          │
│         O│      0/1│  588.045 k/588.2 k│ 516.475667 M/516.613201 M(37.964566 M)


```

- Check input:

```shell

sudo datakit monitor -M In
## Feeds and TotalPts of dialtesting not being zero means data is being uploaded.
┌Inputs Info(11 inputs)────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                Input│Cat│    Feeds│ TotalPts│Filtered│      LastFeed│     AvgCost│Errors                                                                                                                                                 │
│          dialtesting│ L │     626 │     626 │      0 │25 minutes ago│          0s│  0                                                                                                                                                    │
│                  cpu│ M │ 112.71 k│ 112.71 k│      0 │ 6 seconds ago│   237.807?s│  0                                                                                                                                                    │

```

#### Step Four: Check Logs

Use the following command to view the `DataKit` logs on the Synthetic Tests node for further troubleshooting.

```shell
tail -f /var/log/datakit/log | grep dial
```