---
title     : '.NET'
summary   : '采集 .NET 应用相关 Metrics、Tracing、Logging 和 Profiling 信息。'
__int_icon: 'icon/dotnet'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# .NET
<!-- markdownlint-enable -->

通过 [DDTrace](ddtrace.md) 采集 .NET 应用相关 Metrics、Tracing、Logging 和 Profiling 信息。

## 安装配置 {#config}

### 支持版本

| 版本 | 微软终止状态 | 支持的版本 | 包版本 |
| -- | -- | -- | -- |
|.NET 7 | - |GA |latest (>= 2.20.0)|
|.NET 6 | - |GA |latest (>= 2.0.0)|
|.NET 5 | - |GA |latest (>= 2.0.0)|
|.NET Core 3.1 |12/03/2022 |GA |latest|
|.NET Core 2.1 |08/21/2021 |GA |latest|
|.NET Core 3.0 |03/03/2020 |EOL |Not recommended|
|.NET Core 2.2 |12/23/2019 |EOL |Not recommended|
|.NET Core 2.0 |10/01/2018 |EOL |Not recommended|

### 安装 Agent
<!-- markdownlint-disable MD046 MD009 MD051-->
???+ info 
    
    可以在机器范围内安装 Datadog.NET Tracer，以便检测机器上的所有服务，也可以在每个应用程序的基础上安装它，以允许开发人员通过应用程序的依赖关系来管理检测。要查看机器范围内的安装说明，请单击`Windows`或`Linux`选项卡。要查看每个应用程序的安装指示，请单击`NuGet`选项卡。

=== "Windows"
    
    要在机器范围内安装.NET Tracer，请执行以下操作：

    1. 下载 [.NET Tracer MSI](https://github.com/DataDog/dd-trace-dotnet/releases) 安装程序。为与操作系统（x64或x86）匹配的体系结构选择MSI安装程序。
    2. 使用管理员权限运行.NET Tracer MSI安装程序。
    您还可以通过在`PowerShell`中运行以下命令来编写MSI安装程序的脚本：`Start-Process -Wait msiexec -ArgumentList '/qn /i datadog-apm.msi'`。

=== "Linux"
     
    要在机器范围内安装.NET Tracer，请执行以下操作：

    1. 下载 [.NET Tracer MSI](https://github.com/DataDog/dd-trace-dotnet/releases) 安装程序。为与操作系统（x64或x86）匹配的体系结构选择MSI安装程序。
    2. 根据操作系统运行以下相关安装包，并使用适当的权限创建`.NET`跟踪程序日志的目录`/var/log/datadog/dotnet`：
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
        注意：此安装不会检测`IIS`中运行的应用程序。对于在`IIS`中运行的应用程序，请遵循`Windows`计算机范围的安装过程。
    为应用添加 .NET Tracer 

    1. 使用 [NuGet package](https://www.nuget.org/packages/Datadog.Trace.Bundle) 为应用添加` Datadog.Trace.Bundle` 。

### 为应用程序开启 Tracer {#tracer}

应用服务开启.NET Tracer，需要设置所需的环境变量并重新启动应用程序。

有关设置环境变量的不同方法的信息，请参阅配置流程[环境变量](dotnet.md#env)。

=== "Windows"
    
    Internet Information Services (IIS)：

    1. .NET Tracer MSI安装程序会添加所有必需的环境变量。这里需要配置其他的环境变量。
    2. 要自动检测`IIS`中托管的应用程序，请以管理员身份运行以下命令，完全停止和启动`IIS`：
    ```bash
    net stop /y was
    net start w3svc
    ```
    ???+ info 
        注意：始终使用上面的命令完全停止并重新启动`IIS`以启用跟踪器。避免使用`IIS`管理器`GUI`应用程序或`iisreset.exe`。

    非 IIS 应用

    1. 为要附加到应用程序的自动检测设置以下必需的环境变量：
    ```bash
    CORECLR_ENABLE_PROFILING=1
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    ```
    2. 重启应用程序。

=== "Linux"
    
    1. 为应用程序添加自动检测所必须的环境变量：
    ```bash
    CORECLR_ENABLE_PROFILING=1  
    CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}  
    CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so  
    DD_DOTNET_TRACER_HOME=/opt/datadog  
    ```
    2. 重启应用程序


=== "Nuget"

    为 .NET 应用添加自定义探针：

    1. 在应用程序代码中，通过`Datadog.Trace.Tracer.Instance`属性访问全局跟踪器以创建新的 `span`。


### 环境变量配置 {#env}

要将自动检测附加到服务，必须在启动应用程序之前设置所需的环境变量。请参考 [为应用程序开启 tracer](dotnet.md#tracer) 部分，以确定要基于.NET tracer安装方法设置的环境变量，并按照以下示例根据插入指令的服务的环境正确设置环境变量。

#### Windows

=== "Windows 服务"

    ???+ info 
        从v2.14.0开始，如果使用MSI安装跟踪器，则不需要设置`CORECLR_PROFILER`。
    
    === "Registry Editor"

        在注册表编辑器中，在`HKLM\System\CurrentControlSet\Services\<SERVICE NAME>`键中创建一个名为`Environment`的多字符串值，并将值数据设置为：
        
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
        

=== "ISS"
    安装MSI后，无需额外配置即可自动检测IIS站点。要设置由所有IIS站点继承的其他环境变量，请执行以下步骤：

    1. 打开注册表编辑器，在`HKLM\System\CurrentControlSet\Services\WAS`注册表项中找到名为`Environment`的多字符串值，然后添加环境变量，每行一个。例如，要添加日志注入和运行时度量，请在值数据中添加以下行：  
    ```bash
    DD_LOGS_INJECTION=true
    DD_RUNTIME_METRICS_ENABLED=true
    ```
    
    2. 运行以下命令以重新启动IIS：
    ```bash
    net stop /y was
    net start w3svc
    # 此外，WAS 关闭时会停止的任何其他服务已启动的服务。
    ```
    ![Img](./imgs/dotnet-02.png)

=== "Console"

    要自动检测控制台应用程序，请在启动应用程序之前从批处理文件中设置环境变量：

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
    在启动应用程序之前，从`bash`中设置所需的环境变量：

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

    在`Docker container`中配置环境变量：
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
    当使用`systemctl`将 .NET 应用程序作为服务运行时，可以添加要为特定服务加载的所需环境变量。

    1. 创建一个名为`environment.env`的文件，其中包含：
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

    2. 在服务的配置文件中，将其作为服务块中的`EnvironmentFile`引用：
    ```bash
    [Service]
    EnvironmentFile=/path/to/environment.env
    ExecStart=<command used to start the application>
    ```

    3. 重启 .NET 服务。


=== "systemctl(all service)"
    ???+ info 
        
        注意：.NET 运行时会尝试将探查器加载到设置了这些环境变量后启动的任何 .NET 进程中。您应该将检测仅限于需要跟踪的应用程序。不要全局设置这些环境变量，因为这会导致主机上的所有.NET进程都加载探针。

    当使用`systemctl`将 .NET 应用程序作为服务运行时，还可以为`systemctl`运行的所有服务设置要加载的环境变量。

    1. 通过运行`systemctl-Set-environment`设置所需的环境变量：
    ```bash
    systemctl set-environment CORECLR_ENABLE_PROFILING=1
    systemctl set-environment CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
    systemctl set-environment CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
    systemctl set-environment DD_DOTNET_TRACER_HOME=/opt/datadog

    # Set additional Datadog environment variables
    systemctl set-environment DD_LOGS_INJECTION=true
    systemctl set-environment DD_RUNTIME_METRICS_ENABLED=true
    ```

    2. 运行`systemctl show environment`来检验是否成功设置了环境变量。
    3. 重启应用服务。
<!-- markdownlint-enable -->

## 指标 {#metric}
<!-- markdownlint-disable MD046 MD009 -->
???+ success "运行时度量指标"
    
    使用`DD_RUNTIME_METRICS_ENABLED=true`环境变量在`.NET Tracer 1.23.0+`中启用运行时度量指标。
<!-- markdownlint-enable -->
### 运行时指标兼容性

+ [ ]  .NET Framework 4.6.1+
+ [ ] .NET Core 3.1
+ [ ] .NET 5
+ [ ] .NET 6
+ [ ] .NET 7

### 采集器

1. 在 DataKit 中开启 [`statsd`](statsd.md) 采集器。
2. 默认端口为 `8125`
3. 如果将 Agent 作为容器运行，请确保`DD_DOGSTATSD_NON_LOCAL_TRAFFIC`设置为`true`，并且 Agent 上的端口`8125`处于打开状态。

### 指标信息

[详细指标信息](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/)


## 日志 {#logging}

### 文件目录

默认情况下，日志文件保存在以下目录中。使用`DD_TRACE_LOG_DIRECTORY`设置可以更改这些路径。

| 平台 | 目录 |
| -- | -- |
| Windows | %ProgramData%\Datadog .NET Tracer\logs\ |
| Linux | `/var/log/datadog/dotnet/` |
| Linux (`when using Kubernetes library injection`) | `/datadog-lib/logs` |
| Azure App Service |`%AzureAppServiceHomeDirectory%\LogFiles\datadog` |

注意：在 Linux 上，必须先创建日志目录，然后才能启用调试模式。

<!-- markdownlint-disable MD004 -->
- `dotnet-tracer-managed-{processName}-{timestamp}.log` 包含配置日志。

- `dotnet-tracer-native.log` 包含诊断日志（如果生成）。
<!-- markdownlint-enable -->
## Profiler {#profiling}

参考文档[.NET profiling](profile-dotnet.md)

## 官方文档 {#docs}

[.NET 参数文档](https://docs.datadoghq.com/tracing/trace_collection/library_config/dotnet-core/?tab=environmentvariables)

[.NET Tracer](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/dotnet-core)

[.NET 日志](https://docs.datadoghq.com/tracing/troubleshooting/tracer_startup_logs/?code-lang=dotnet)

[.NET Runtime Metrics](https://docs.datadoghq.com/tracing/metrics/runtime_metrics/dotnet/)
