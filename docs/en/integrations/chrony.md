---
title     : 'Chrony'
summary   : 'Collect metrics data related to the Chrony server'
__int_icon: 'icon/chrony'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Chrony collector is used to collect metrics data related to the Chrony server.

The Chrony collector supports remote collection, and the Datakit collector can run on various operating systems.

## Configuration {#config}

### Prerequisites {#requirements}

- Install the Chrony service

```shell
$ yum -y install chrony    # [On CentOS/RHEL]
...

$ apt install chrony       # [On Debian/Ubuntu]
...

$ dnf -y install chrony    # [On Fedora 22+]
...

```

- Verify correct installation by running the following command in the command line, and you should get similar results:

```shell
$ chronyc -n tracking
Reference ID    : CA760151 (202.118.1.81)
Stratum         : 2
Ref time (UTC)  : Thu Jun 08 07:28:42 2023
System time     : 0.000000000 seconds slow of NTP time
Last offset     : -1.841502666 seconds
RMS offset      : 1.841502666 seconds
Frequency       : 1.606 ppm slow
Residual freq   : +651.673 ppm
Skew            : 0.360 ppm
Root delay      : 0.058808800 seconds
Root dispersion : 0.011350543 seconds
Update interval : 0.0 seconds
Leap status     : Normal
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/chrony` directory under the DataKit installation directory, copy `chrony.conf.sample` and rename it to `chrony.conf`. Example:
    
    ```toml
        
    [[inputs.chrony]]
      ## (Optional) Collection interval, default is 10 seconds
      # interval = "10s"
    
      ## (Optional) Exec chronyc timeout, default is 8 seconds
      # timeout = "8s"
    
      ## (Optional) The binPath of chrony
      bin_path = "chronyc"
    
      ## (Optional) Remote chrony servers
      ## If using remote chrony servers, election must be true
      ## If using remote chrony servers, bin_paths should be shielded
      # remote_addrs = ["<ip>:22"]
      # remote_users = ["<remote_login_name>"]
      # remote_passwords = ["<remote_login_password>"]
      ## If using remote_rsa_path, remote_passwords should be shielded
      # remote_rsa_paths = ["/home/<your_name>/.ssh/id_rsa"]
      # remote_command = "chronyc -n tracking"
    
      ## Set true to enable election
      election = true
    
    [inputs.chrony.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (must be added as a default collector in ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_CHRONY_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_CHRONY_TIMEOUT**
    
        Timeout duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `timeout`
    
        **Default Value**: 8s
    
    - **ENV_INPUT_CHRONY_BIN_PATH**
    
        Path to Chrony
    
        **Field Type**: String
    
        **Collector Configuration Field**: `bin_path`
    
        **Default Value**: `chronyc`
    
    - **ENV_INPUT_CHRONY_REMOTE_ADDRS**
    
        Can use remote Chrony servers
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_addrs`
    
        **Example**: ["192.168.1.1:22","192.168.1.2:22"]
    
    - **ENV_INPUT_CHRONY_REMOTE_USERS**
    
        Remote login names
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_users`
    
        **Example**: ["user_1","user_2"]
    
    - **ENV_INPUT_CHRONY_REMOTE_PASSWORDS**
    
        Remote login passwords
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_passwords`
    
        **Example**: ["pass_1","pass_2"]
    
    - **ENV_INPUT_CHRONY_REMOTE_RSA_PATHS**
    
        Key file paths
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `remote_rsa_paths`
    
        **Example**: ["/home/your_name/.ssh/id_rsa"]
    
    - **ENV_INPUT_CHRONY_REMOTE_COMMAND**
    
        Execution command
    
        **Field Type**: String
    
        **Collector Configuration Field**: `remote_command`
    
        **Example**: "`chronyc -n tracking`"
    
    - **ENV_INPUT_CHRONY_ELECTION**
    
        Enable election
    
        **Field Type**: Boolean
    
        **Collector Configuration Field**: `election`
    
        **Default Value**: true
    
    - **ENV_INPUT_CHRONY_TAGS**
    
        Custom tags. If there are same-name tags in the configuration file, they will overwrite them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}



### `chrony`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`leap_status`|This is the leap status, which can be Normal, Insert second, Delete second or Not synchronized.|
|`reference_id`|This is the reference ID and name (or IP address) of the server to which the computer is currently synchronized.|
|`stratum`|The stratum indicates how many hops away from a computer with an attached reference clock we are.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`frequency`|This is the rate by which the system clock would be wrong if *chronyd* was not correcting it.|float|PPM|
|`last_offset`|This is the estimated local offset on the last clock update.|float|s|
|`residual_freq`|This shows the residual frequency for the currently selected reference source.|float|PPM|
|`rms_offset`|This is a long-term average of the offset value.|float|s|
|`root_delay`|This is the total of the network path delays to the stratum-1 computer from which the computer is ultimately synchronized.|float|s|
|`root_dispersion`|This is the total dispersion accumulated through all the computers back to the stratum-1 computer from which the computer is ultimately synchronized.|float|s|
|`skew`|This is the estimated error bound on the frequency.|float|PPM|
|`system_time`|This is the current offset between the NTP clock and system clock.|float|s|
|`update_interval`|This is the interval between the last two clock updates.|float|s|