# Installation Configuration Example
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

<<< custom_key.brand_name >>> supports collecting vulnerabilities and anomalies in hosts, systems, containers, networks, etc., using Scheck, and reporting them to the workspace. This article describes an example of Scheck installation and configuration.

### 1. Install DataKit

In <<< custom_key.brand_name >>> workspace under "Integration" - "DataKit", choose the DataKit installation method and obtain the "Installation Command" to execute on the host. For more details, refer to the [DataKit Installation Documentation](../datakit/datakit-install.md).

![](img/2.datakit.png)

### 2. Install the Security Check Collector

Execute the following command on the host to install the security check collector. For more details, refer to the [Scheck Installation Documentation](scheck-install.md).

```shell
$ sudo datakit install --scheck
```

#### Field Description
| Field Name | Description |
| --- | --- |
| date | Time unit: microseconds |
| rule | Rule |
| host | Hostname |
| category | Event category, including: `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes` |
| level | Security check event level, supports: `info`, `warn`, `critical` |
| title | Title of the security check event |
| message | Content of the security check event |
| suggestion | Suggested content, including explanation, risk, impact, audit, remediation measures, etc. |

### 3. Configure the Security Check Collector
Configure the inspection results to be output to DataKit. In the `/usr/local/scheck` directory, edit the configuration file `scheck.conf`.

![](img/2.check_2.png)

Confirm that the output configuration defaults to sending data to the DataKit interface.

![](img/2.check_3.png)

### 4. Restart the Security Check Collector
Restart the security check and DataKit by executing the commands `service scheck restart` and `datakit --restart`.

![](img/2.check_4.png)

### 5. View Security Check Data in <<< custom_key.brand_name >>> Workspace
After installing, configuring, and restarting the security check collector, you can view the inspection events triggered by the host's security scripts in the <<< custom_key.brand_name >>> workspace under "Security Check".

![](img/2.check_5.png)