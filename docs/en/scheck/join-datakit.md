# Scheck Connection with Datakit Solution

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64


To address the aforementioned security issues, DataFlux has developed Scheck, which offers a new secure scripting method to ensure all actions are safe and controllable:
1. Scheck uses Lua language to write detection scripts, which are executed periodically. The Lua runtime is provided by Scheck, ensuring that only safe operations can be performed within the script (command execution restrictions, local IO restrictions, network IO restrictions).
2. Each detection rule in Scheck consists of a script and a manifest file. The manifest file defines the format of the detection results, which will be reported as logs through a unified network model.

Additionally, Scheck provides a vast, updatable repository of rule scripts covering system, container, network, and security inspections.

# Prerequisites

| Service Name | Version                                                         | Mandatory Installation | Purpose            |
| ------------ | --------------------------------------------------------------- | ---------------------- | ------------------ |
| DataKit      | 1.1.6 or later [Installation Method](../datakit/datakit-install.md) | Yes                    | Accepts Scheck signals |

# Using DataFlux to Collect Host Security Status in Real Time (Enabled by Default)
Scheck supports sending detection results to DataKit, so install DataKit first.

After installing Scheck, edit the configuration file `scheck.conf` located in `/usr/local/scheck/`:

```toml
...
[scoutput]
   # ## Messages generated during security checks can be sent to local, http, or Alibaba Cloud SLS.
   # ## Remote server, e.g., http(s)://your.url
  [scoutput.http]
    enable = true
    output = "http://127.0.0.1:9529/v1/write/security"
...

```
Edit the Scheck configuration file (usually located at `/usr/local/scheck/scheck.conf`), set the `output` to DataKit's time series data interface and set `enable` to `true`:

```toml
output = 'http://localhost:9529/v1/write/security' # Supported by DataKit version 1.1.6 and above
```

Place the written detection rules in the directory specified by `rule_dir` in the configuration file. Scheck will automatically execute these rules periodically.

Next, when an event is triggered (for example, monitoring changes to the `passwd` file on Linux), Scheck will send the collected logs to DataKit, which will then forward them to DataFlux. You can view the corresponding logs on the DataFlux platform:
![](https://security-checker-prod.oss-cn-hangzhou.aliyuncs.com/img/security-checker_a.png)