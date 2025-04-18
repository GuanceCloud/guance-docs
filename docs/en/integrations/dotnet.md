---
title     : '.NET'
summary   : 'Collect related Metrics, Tracing, Logging, and Profiling information for .NET applications.'
__int_icon: 'icon/dotnet'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# .NET
<!-- markdownlint-enable -->

Collect related Metrics, Tracing, Logging, and Profiling information for .NET applications using [DDTrace](ddtrace.md).

## Installation and Configuration {#config}

### Supported Versions

| Version | Microsoft End-of-Life Status | Supported Version | Package Version |
| -- | -- | -- | -- |
|.NET 7 | - |GA |latest (>= 2.20.0)|
|.NET 6 | - |GA |latest (>= 2.0.0)|
|.NET 5 | - |GA |latest (>= 2.0.0)|
|.NET Core 3.1 |12/03/2022 |GA |latest|
|.NET Core 2.1 |08/21/2021 |GA |latest|
|.NET Core 3.0 |03/03/2020 |EOL |Not recommended|
|.NET Core 2.2 |12/23/2019 |EOL |Not recommended|
|.NET Core 2.0 |10/01/2018 |EOL |Not recommended|

### Install Agent
<!-- markdownlint-disable MD046 MD009 MD051-->
???+ info 
    
    You can install Datadog.NET Tracer at the machine level to detect all services on the machine or install it on a per-application basis to allow developers to manage detection through application dependencies. To view machine-wide installation instructions, click the `Windows` or `Linux` tab. To view installation instructions for each application, click the `NuGet` tab.

=== "Windows"
    
    To install the .NET Tracer at the machine level, follow these steps:

    1. Download the [.NET Tracer MSI](https://github.com/DataDog/dd-trace-dotnet/releases) installer. Select the MSI installer that matches the architecture of your operating system (x64 or x86).
    2. Run the .NET Tracer MSI installer with administrator privileges.
    You can also script the MSI installer by running the following command in `PowerShell`: `Start-Process -Wait msiexec -ArgumentList '/qn /i datadog-apm.msi'`.

=== "Linux"
     
    To install the .NET Tracer at the machine level, follow these steps:

    1. Download the [.NET Tracer MSI](https://github.com/DataDog/dd-trace-dotnet/releases) installer. Select the MSI installer that matches the architecture of your operating system (x64 or x86).
    2. Depending on your operating system, run the relevant package with appropriate permissions and create the directory for .NET tracer logs `/var/log/datadog/dotnet`:
    > **Debian or Ubuntu**  
    > `sudo dpkg -i ./datadog-dotnet-apm_<TRACER_VERSION>_amd64.deb && /opt/datadog/createLogPath.sh`  
    > **CentOS or Fedora**  
    > `sudo rpm -Uvh datadog-dotnet-apm<TRACER_VERSION>-1.x86_64.rpm && /opt/datadog/createLogPath.sh`  
    > **Alpine or other musl-based distributions**  
    > `sudo tar -C /opt/datadog -xzf datadog-dotnet-apm-<TRACER_VERSION>-musl.tar.gz && sh /opt/datadog/createLogPath.sh`  
    > **Other distributions**  
    > `sudo tar -C /opt/datadog -xzf datadog-dotnet-apm<TRACER_VERSION>-tar.gz && /opt/datadog/createLogPath.sh`  

=== "Nuget"

    ???+ info 
        Note: This installation will not detect applications running in `IIS`. For applications running in `IIS`, follow the machine-wide installation process for `Windows`.
    Add .NET Tracer to your application

    1. Use the [NuGet package](https://www.nuget.org/packages/Datadog.Trace.Bundle) to add `Datadog.Trace.Bundle` to your application.

### Enable Tracer for Applications {#tracer}

To enable the .NET Tracer for your service, set the required environment variables and restart the application.

For more information on setting environment variables, see the configuration flow [Environment Variables](dotnet.md#env).

=== "Windows"
    
    Internet Information Services (IIS):

    1. The .NET Tracer MSI installer adds all necessary environment variables. Additional environment variables need to be configured here.
    2. To automatically detect applications hosted in `IIS`, run the following commands as an administrator to fully stop and start `IIS`:
    ```bash
    net stop /y was
    net start w3svc
    ```
    ???+ info 
        Note: Always use the above commands to fully stop and restart `IIS` to enable the tracer. Avoid using the `IIS` Manager GUI application or `iisreset.exe`.

    Non-IIS Applications

    1. Set the following required environment variables for auto-detection to attach to your application:
    ```bash
    CORECLR_ENABLE_PROFILING=1
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    ```
    2. Restart the application.

=== "Linux"
    
    1. Add the required environment variables for auto-detection to your application:
    ```bash
    CORECLR_ENABLE_PROFILING=1  
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}  
    CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so  
    DD_DOTNET_TRACER_HOME=/opt/datadog  
    ```
    2. Restart the application


=== "Nuget"

    Add custom probes to .NET applications:

    1. In your application code, access the global tracer via the `Datadog.Trace.Tracer.Instance` property to create new `spans`.

### Environment Variable Configuration {#env}

To attach auto-detection to services, you must set the required environment variables before launching the application. Refer to the [Enable Tracer for Applications](dotnet.md#tracer) section to determine which environment variables should be set based on the .NET tracer installation method, and correctly set them according to the examples below based on the environment of the service being instrumented.

The following require corresponding variable information regardless of the method used:

> DD_TRACE_AGENT_PORT=9529

#### Windows

=== "Windows Service"

    ???+ info 
        Starting from v2.14.0, if the tracer is installed with the MSI, there is no need to set `CORECLR_PROFILER`.
    
    === "Registry Editor"

        In the registry editor, create a multi-string value named `Environment` under the key `HKLM\System\CurrentControlSet\Services\<SERVICE NAME>` and set the value data to:
        
        ```bash
        CORECLR_ENABLE_PROFILING=1
        CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
        ```
        ![Img](./imgs/dotnet_01.png)

    === "PowerShell"
    
        ```powershell
        [string[]] $v = @("CORECLR_ENABLE_PROFILING=1", "CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}")
        Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\<SERVICE NAME> -Name Environment -Value $v
        ```
        

=== "IIS"
    After installing the MSI, automatic detection of IIS sites requires no additional configuration. To set additional environment variables inherited by all IIS sites, follow these steps:

    1. Open the registry editor, find the multi-string value named `Environment` under the registry item `HKLM\System\CurrentControlSet\Services\WAS`, and then add environment variables, one per line. For example, to add log injection and runtime metrics, add the following lines to the value data:  
    ```bash
    DD_LOGS_INJECTION=true
    DD_RUNTIME_METRICS_ENABLED=true
    ```
    
    2. Run the following commands to restart IIS:
    ```bash
    net stop /y was
    net start w3svc
    # Additionally, any other services stopped when WAS shuts down have been restarted.
    ```
    ![Img](./imgs/dotnet-02.png)

=== "Console"

    To automatically detect console applications, set environment variables from a batch file before starting the application:

    ```powershell
    rem Set environment variables
    SET CORECLR_ENABLE_PROFILING=1
    rem Unless v2.14.0+ and you installed the tracer with the MSI
    SET CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    
    rem Set additional Datadog environment variables
    SET DD_LOGS_INJECTION=true
    SET DD_RUNTIME_METRICS_ENABLED=true
    
    rem Start application
    dotnet.exe example.dll
    ```

#### Linux

=== "Bash script"
    Before starting the application, set the required environment variables from `bash`:

    ```shell
    # Set environment variables
    export CORECLR_ENABLE_PROFILING=1
    export CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    export CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    export DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    export DD_LOGS_INJECTION=true
    export DD_RUNTIME_METRICS_ENABLED=true
    
    # Start your application
    dotnet example.dll
    ```

=== "Docker container"

    Configure environment variables in the `Docker container`:
    ```shell
    # Set environment variables
    ENV CORECLR_ENABLE_PROFILING=1
    ENV CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    ENV CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    ENV DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    ENV DD_LOGS_INJECTION=true
    ENV DD_RUNTIME_METRICS_ENABLED=true
    
    # Start your application
    CMD ["dotnet", "example.dll"]
    ```



=== "systemctl(per service)"
    When running a .NET application as a service using `systemctl`, you can add the required environment variables to load for a specific service.

    1. Create a file named `environment.env` containing:
    ```shell
    # Set environment variables
    CORECLR_ENABLE_PROFILING=1
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    DD_LOGS_INJECTION=true
    DD_RUNTIME_METRICS_ENABLED=true
    ```

    2. Reference it as `EnvironmentFile` in the service block of the service's configuration file:
    ```bash
    [Service]
    EnvironmentFile=/path/to/environment.env
    ExecStart=<command used to start the application>
    ```

    3. Restart the .NET service.


=== "systemctl(all service)"
    ???+ info 
        
        Note: The .NET runtime will attempt to load the profiler into any .NET process started after these environment variables are set. You should limit detection to only those applications that need tracing. Do not set these environment variables globally, as this will cause all .NET processes on the host to load the probe.

    When running .NET applications as services using `systemctl`, you can also set environment variables to load for all services run by `systemctl`.

    1. Set the required environment variables by running `systemctl-set-environment`:
    ```bash
    systemctl set-environment CORECLR_ENABLE_PROFILING=1
    systemctl set-environment CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    systemctl set-environment CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    systemctl set-environment DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    systemctl set-environment DD_LOGS_INJECTION=true
    systemctl set-environment DD_RUNTIME_METRICS_ENABLED=true
    ```

    2. Run `systemctl show environment` to verify that the environment variables have been set successfully.
    3. Restart the application service.
<!-- markdownlint-enable -->

## Metrics {#metric}
<!-- markdownlint-disable MD046 MD009 -->
???+ success "Runtime Metrics"
    
    Enable runtime metrics in `.NET Tracer 1.23.0+` by using the `DD_RUNTIME_METRICS_ENABLED=true` environment variable.
<!-- markdownlint-enable -->
### Runtime Metrics Compatibility

+ [ ]  .NET Framework 4.6.1+
+ [ ] .NET Core 3.1
+ [ ] .NET 5
+ [ ] .NET 6
+ [ ] .NET 7

### Collector

1. Enable the [`statsd`](statsd.md) collector in DataKit.
2. Default port is `8125`
3. If running the Agent as a container, ensure `DD_DOGSTATSD_NON_LOCAL_TRAFFIC` is set to `true` and that port `8125` on the Agent is open.

### Metric Information

[Detailed metric information](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/)


## Logs {#logging}

### File Directories

By default, log files are saved in the following directories. The paths can be changed using `DD_TRACE_LOG_DIRECTORY`.

| Platform | Directory |
| -- | -- |
| Windows | %ProgramData%\Datadog .NET Tracer\logs\ |
| Linux | `/var/log/datadog/dotnet/` |
| Linux (`when using Kubernetes library injection`) | `/datadog-lib/logs` |
| Azure App Service | `%AzureAppServiceHomeDirectory%\LogFiles\datadog` |

Note: On Linux, the log directory must be created first before enabling debug mode.

<!-- markdownlint-disable MD004 -->
- `dotnet-tracer-managed-{processName}-{timestamp}.log` contains configuration logs.

- `dotnet-tracer-native.log` contains diagnostic logs (if generated).
<!-- markdownlint-enable -->
## Profiler {#profiling}

Refer to the documentation [.NET profiling](profile-dotnet.md)

## Official Documentation {#docs}

[.NET Parameters Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/dotnet-core/?tab=environmentvariables)

[.NET Tracer](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/dotnet-core)

[.NET Logs](https://docs.datadoghq.com/tracing/troubleshooting/tracer_startup_logs/?code-lang=dotnet)

[.NET Runtime Metrics](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/)