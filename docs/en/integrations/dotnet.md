---
title     : '.NET'
summary   : 'Collect relevant metrics, traces, logs, and profiling information for.NET applications through DDTrace'
__int_icon: 'icon/dotnet'
dashboard :
  - desc  : 'No'
    path  : '-'
monitor   :
  - desc  : 'No'
    path  : '-'
---


<!-- markdownlint-disable MD025 -->
# .NET
<!-- markdownlint-enable -->

Use metrics, traces, logs, and profiling information for.NET applications through [DDTrace](ddtrace.md).

## Installation Configuration{#config}

### Support Version

| VERSION | MICROSOFT END OF LIFE | SUPPORT LEVEL | PACKAGE VERSION |
| -- | -- | -- | -- |
|.NET 7 | - |GA |latest (>= 2.20.0)|
|.NET 6 | - |GA |latest (>= 2.0.0)|
|.NET 5 | - |GA |latest (>= 2.0.0)|
|.NET Core 3.1|12/03/2022 |GA |latest|
|.NET Core 2.1|08/21/2021 |GA |latest|
|.NET Core 3.0 |03/03/2020 |EOL |Not recommended|
|.NET Core 2.2 |12/23/2019 |EOL |Not recommended|
|.NET Core 2.0 |10/01/2018 |EOL |Not recommended|

### Install Agent
<!-- markdownlint-disable MD046 MD009 MD051-->
???+ info
    

=== "Windows"

    To install the .NET Tracer machine-wide:

    1. Download the [ .NET Tracer MSI ](https://github.com/DataDog/dd-trace-dotnet/releases) installer. Select the MSI installer for the architecture that matches the operating system (x64 or x86).

    2. Run the .NET Tracer MSI installer with administrator privileges.

    You can also script the MSI setup by running the following in PowerShell: `Start-Process -Wait msiexec -ArgumentList '/qn /i datadog-apm.msi'`

=== "Linux"
    
    1. Download the latest [ .NET Tracer MSI ](https://github.com/DataDog/dd-trace-dotnet/releases) package that supports your operating system and architecture.
    2. Run one of the following commands to install the package and create the .NET tracer log directory `/var/log/datadog/dotnet` with the appropriate permissions:
    
    To install the .NET Tracer machine-wide:

    > ** Debian or Ubuntu **
    >  `sudo dpkg -i./datadog-dotnet-apm_<TRACER_VERSION>_amd64.deb &&/opt/datadog/createLogPath.sh`
    > ** CentOS or Fedora **
    >  `sudo rpm -Uvh datadog-dotnet-apm<TRACER_VERSION>-1.x86_64.rpm &&/opt/datadog/createLogPath.sh`
    > ** Alpine or other musl-based distributions **
    >  `sudo tar -C/opt/datadog -xzf datadog-dotnet-apm-<TRACER_VERSION>-musl.tar.gz && sh/opt/datadog/createLogPath.sh`
    > ** Other distributions **
    >  `sudo tar -C/opt/datadog -xzf datadog-dotnet-apm<TRACER_VERSION>-tar.gz &&/opt/datadog/createLogPath.sh`

=== "Nuget"


    1. Use [ NuGet package](https://www.nuget.org/packages/Datadog.Trace.Bundle) to add ` Datadog.Trace.Bundle` to the application.

### Open Tracer for Application{#tracer}

To enable the .NET Tracer for your service, set the required environment variables and restart the application.

For information about the different methods for setting environment variables, see Configuring process [environment variables](dotnet.md#env).

=== "Windows"
    

    1. The.NET Tracer MSI installer adds all required environment variables. Other environment variables need to be configured here.
    2. To automatically detect applications hosted in `IIS`, run the following command as an administrator to stop and start `IIS` completely:
    ```bash
    net stop /y was
    net start w3svc
    ```
    ???+ info
        Note: Always use the above command to stop completely and restart `IIS` to enable the tracker. Avoid using `IIS` Manager `GUI` applications or `iisreset.exe`.

    Non-IIS applications

    1. Set the following required environment variables for automatic detection to be attached to the application:
    ```bash
    CORECLR_ENABLE_PROFILING=1
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    ```
    2. Restart the application.

=== "Linux"
    
    1. Add environment variables necessary for automatic detection to your application:
    ```bash
    CORECLR_ENABLE_PROFILING=1  
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}  
    CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so  
    DD_DOTNET_TRACER_HOME=/opt/datadog  
    ```
    2. Restart the application


=== "Nuget"


    1. In application code, access the global tracker through the `Datadog.Trace.Tracer.Instance` property to create a new `span`.


### Environment variable configuration{#env}

To attach automatic detection to a service, you must set the required environment variables before starting the application. Refer to the [Open tracer for application](dotnet.md#tracer) section to determine the environment variables to be set based on the .NET tracer installation method, and follow the example below to set the environment variables correctly based on the service's environment for the insert instructions.

Regardless of which method is used, corresponding variable information needs to be added.

> DD_TRACE_AGENT_PORT=9529

#### Windows

=== "Windows Services"

    

        
        ```bash
        CORECLR_ENABLE_PROFILING=1
        CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
        ```

    
        ```powershell
        [string[]] $v = @("CORECLR_ENABLE_PROFILING=1", "CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}")
        Set-ItemProperty HKLM:SYSTEM\CurrentControlSet\Services\<SERVICE NAME> -Name Environment -Value $v
        ```
        

=== "ISS"

    1. Open the Registry Editor, find a multi-string value named `HKLM\System\CurrentControlSet\Services\WAS` in the registry key, and add environment variables one per line. For example, to add log injection and runtime metrics, add the following lines to the value data:
    ```bash
    DD_LOGS_INJECTION=true
    DD_RUNTIME_METRICS_ENABLED=true
    ```
    
    2. Run the following command to restart IIS:
    ```bash
    net stop /y was
    net start w3svc
    # Also, start any other services that were stopped when WAS was shut down.
    ```
    ! [Img](./imgs/dotnet-02.png)

=== "Console"


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

    1. Create a file named `environment.env` that contains:
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

    2. In the service's configuration file, refer to it as `EnvironmentFile` in the service block:
    ```bash
    [Service]
    EnvironmentFile=/path/to/environment.env
    ExecStart=<command used to start the application>
    ```

    3. Restart the.NET service.


=== "`systemctl`(all service)"
        


    1. Set the required environment variables by running `systemctl-Set-environment`
    ```bash
    systemctl set-environment CORECLR_ENABLE_PROFILING=1
    systemctl set-environment CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    systemctl set-environment CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    systemctl set-environment DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    systemctl set-environment DD_LOGS_INJECTION=true
    systemctl set-environment DD_RUNTIME_METRICS_ENABLED=true
    ```

    2. Run `systemctl show environment` to verify that the environment variable was successfully set.
    3. Restart the application service.
<!-- markdownlint-enable -->

## Metric {#metric}
<!-- markdownlint-disable MD046 MD009 -->
???+ Success "Runtime Metrics"
    Enable runtime metrics collection in the `.NET Tracer 1.23.0+` with the `DD_RUNTIME_METRICS_ENABLED=true` environment variable.
    
<!-- markdownlint-enable -->
### Runtime Metric Compatibility

- [x] .NET Framework 4.6.1+
- [x] .NET Core 3.1
- [x] .NET 5
- [x] .NET 6
- [x] .NET 7

### Collector

1. Turn on the [ `statsd`] (statsd.md) collector in the DataKit.
2. The default port is `8125`
3. If you run Agent as a container, make sure that `DD_DOGSTATSD_NON_LOCAL_TRAFFIC` is set to `true` and that the port `8125` on the Agent is open.

### Metric Information

[Detailed Metric Information](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/ )


## Logging {#logging}

**File Location:**

Log files are saved in the following directories by default. Use the DD_TRACE_LOG_DIRECTORY setting to change these paths.

|PLATFORM| PATH |
| -- | -- |
| Windows |%ProgramData%\Datadog .NET Tracer\logs\|
| Linux | `/var/log/datadog/dotnet/`|
| Linux ( `when using Kubernetes library injection`)| `/datadog-lib/logs` |
| Azure App Service | `%AzureAppServiceHomeDirectory%\LogFiles\datadog`|

**Note**: On Linux, you must create the logs directory before you enable debug mode.

<!-- markdownlint-disable MD004 -->
- `dotnet-tracer-managed-{processName}-{timestamp}.log` contains the configuration logs.

- `dotnet-tracer-native.log` contains the diagnostics logs, if any are generated.

<!-- markdownlint-enable -->
## Profiler{#profiling}

Reference Document [.NET profiling](profile-dotnet.md)

## Documents{#docs}

[.NET Parameters Document](https://docs.datadoghq.com/tracing/trace_collection/library_config/dotnet-core/?tab=environmentvariables)

[.NET Tracer](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/dotnet-core)

[.NET Log](https://docs.datadoghq.com/tracing/troubleshooting/tracer_startup_logs/?code-lang=dotnet)

[.NET Runtime Metrics](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/)
