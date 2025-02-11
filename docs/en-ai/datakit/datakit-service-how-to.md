# DataKit Service Management
---

[DataKit Installation](datakit-install.md) After the installation is complete, it's necessary to provide a basic introduction to the installed DataKit.

## DataKit Directory Introduction {#install-dir}

DataKit currently supports three major platforms: Linux/Windows/Mac:

| Operating System                            | Architecture                | Installation Path                                                                       |
| ------------------------------------------- | ---------------------------- | ---------------------------------------------------------------------------------------- |
| Linux kernel 2.6.23 or higher               | amd64/386/arm/arm64          | `/usr/local/datakit`                                                                     |
| macOS 10.13 or higher[^1]                   | amd64                       | `/usr/local/datakit`                                                                     |
| Windows 7, Server 2008R2 or higher          | amd64/386                    | 64-bit: `C:\Program Files\datakit`<br />32-bit: `C:\Program Files (x86)\datakit`        |

[^1]: Golang 1.18 requires macOS-amd64 version 10.13.

After installation, the DataKit directory structure looks roughly like this:

``` not-set
├── [4.4K]  conf.d
├── [ 160]  data
├── [ 64M]  datakit
├── [ 192]  externals
├── [1.2K]  pipeline
├── [ 192]  gin.log   # Windows platform
└── [1.2K]  log       # Windows platform
```

Where:

- `conf.d`: Contains configuration examples for all collectors. The main DataKit configuration file *datakit.conf* is located in this directory.
- `data`: Stores data files required for DataKit operation, such as IP address databases.
- `datakit`: Main DataKit program, *datakit.exe* on Windows.
- `externals`: Some collectors are not integrated into the main DataKit program and are placed here.
- `pipeline`: Stores scripts used for text processing.
- `gin.log`: DataKit can receive external HTTP data input, and this log file acts as an HTTP access log.
- `log`: DataKit runtime logs (on Linux/Mac platforms, DataKit runtime logs are stored in the `/var/log/datakit` directory).

<!-- markdownlint-disable MD046 -->
???+ tip "View Kernel Version"

    - Linux/Mac: `uname -r`
    - Windows: Run the `cmd` command (hold down the Win key + `r`, type `cmd` and press Enter), then input `winver` to get system version information.
<!-- markdownlint-enable -->

## DataKit Service Management {#manage-service}

You can manage DataKit directly using the following commands:

```shell
# On Linux/Mac, you may need to add sudo
datakit service -T # stop
datakit service -S # start
datakit service -R # restart
```

<!-- markdownlint-disable MD046 -->
???+ tip

    You can view more help information by running `datakit help service`.
<!-- markdownlint-enable -->

### Handling Service Management Failures {#when-service-failed}

Sometimes, due to bugs in certain components of DataKit, service operations may fail (e.g., after running `datakit service -T`, the service does not stop). In such cases, you can handle it forcefully as follows.

On Linux, if the above commands fail, you can use the following commands instead:

```shell
sudo service datakit stop/start/restart
sudo systemctl stop/start/restart datakit
```

On Mac, you can use the following commands instead:

```shell
# Start DataKit
sudo launchctl load -w /Library/LaunchDaemons/cn.dataflux.datakit.plist
# Or
sudo launchctl load -w /Library/LaunchDaemons/com.guance.datakit.plist

# Stop DataKit
sudo launchctl unload -w /Library/LaunchDaemons/cn.dataflux.datakit.plist
# Or
sudo launchctl unload -w /Library/LaunchDaemons/com.guance.datakit.plist
```

### Uninstalling and Reinstalling the Service {#uninstall-reinstall}

You can uninstall or reinstall the DataKit service directly using the following commands:

> Note: Uninstalling DataKit here will not delete related DataKit files.

```shell
# On Linux/Mac shell
datakit service -I # re-install
datakit service -U # uninstall
```

## FAQ {#faq}

### :material-chat-question: Failure to Start on Windows {#windows-start-fail}

DataKit runs as a service on Windows and writes many Event logs upon startup. As logs accumulate, you might encounter the following error:

``` not-set
Start service failed: The event log file is full.
```

This error can prevent DataKit from starting. You can resolve this by [adjusting the Windows Event settings](https://stackoverflow.com/a/13868216/342348){:target="_blank"} (using Windows Server 2016 as an example):

![Modify Windows Event Settings](https://static.guance.com/images/datakit/set-windows-event-log.gif)