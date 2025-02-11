# Installation Configuration Example
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

Guance supports collecting vulnerabilities and anomalies in hosts, systems, containers, networks, etc., through Security Check and reporting them to the workspace. This article introduces an installation configuration example for Security Check.

### 1. Install DataKit

In the Guance workspace under "Integration" - "DataKit", select the DataKit installation method and obtain the "installation command" to execute on the host. For more details, refer to the [DataKit Installation Documentation](../datakit/datakit-install.md).

![](img/2.datakit.png)

### 2. Install Security Check Collector

Execute the following command on the host to install the security check collector. For more details, refer to the [Security Check Installation Documentation](scheck-install.md).

```shell
$ sudo datakit install --scheck
```

#### Field Description
| Field Name | Description |
| --- | --- |
| date | Time unit: microseconds |
| rule | Rule |
| host | Host name |
| category | Event classification, including: `network`, `storage`, `database`, `system`, `webserver`, `Kubernetes` |
| level | Security check event level, supporting: `info`, `warn`, `critical` |
| title | Title of the security check event |
| message | Content of the security check event |
| suggestion | Suggested content, including explanation, risk, impact, audit, remediation measures, etc. |

### 3. Configure Security Check Collector
Configure the inspection results to be output to DataKit by editing the configuration file `scheck.conf` in the `/usr/local/scheck` directory.

![](img/2.check_2.png)

Confirm whether the output configuration defaults to sending data to the DataKit interface.

![](img/2.check_3.png)

### 4. Restart Security Check Collector
Restart the security check collector and DataKit by executing the commands `service scheck restart` and `datakit --restart`.

![](img/2.check_4.png)

### 5. View Security Check Data in Guance Workspace
After installing, configuring, and restarting the security check collector, you can view the inspection events triggered by the host based on the security script in the "Security Check" section of the Guance workspace.

![](img/2.check_5.png)