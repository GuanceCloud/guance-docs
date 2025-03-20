<!-- markdownlint-disable MD025 -->
# New Relic For .NET
<!-- markdownlint-enable -->

---

> The .Net Agent of New Relic is an open-source project based on the .Net technology framework. It can be used for comprehensive performance monitoring of Apps built on the .NET technology framework. It can also be used for all languages compatible with the .NET technology framework, such as: C#, VB.NET, CLI.

---

## Prerequisites {#prerequisites-jobs}

- Domain name preparation and certificate generation and installation
- [Register a New Relic account](https://newrelic.com/signup?via=login){:target="_blank"}
- The currently supported version of the installed New Relic Agent is 6.27.0
- The currently supported installed version of .Net Framework is 3.0

## Install and Configure New Relic .NET Agent {#install-and-configure-new-relic-dotnet-agent}

First, confirm the installed version of `DotNet Framework` on the current `Windows OS`:

  Run `cmd` and input `reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP"` to view all installed versions on the current `OS`.

Then proceed with the installation of the New Relic Agent:

- You can [log in to your personal `New Relic` account](https://one.newrelic.com){:target="_blank"} for installation:

  After logging into the account, click the `+ Add Data` subdirectory under the left-hand directory bar, then select `.Net` from the `Application monitoring` in the `Data source` subdirectory on the right side and follow the installation guide to install.

- You can also install via the installation program:

  Open the [download directory](https://download.newrelic.com/dot_net_agent/6.x_release/){:target="_blank"} to download the `dotnet agent` version 6.27.0 and choose the corresponding installation program.

Configure `New Relic Agent`

- Configure necessary environment variables

  Right-click the `Windows` logo at the bottom left of the desktop and select System, then Advanced system settings, then Environment Variables, and check if the following environment variable configurations are included in the System Variables list:

    - `COR_ENABLE_PROFILING`: Numeric value 1, default enabled
    - `COR_PROFILER`: Character value, default filled by the system automatically with `ID`
    - `CORECLR_ENABLE_PROFILING`: Numeric value 1, default enabled
    - `NEW_RELIC_APP_NAME`: Character value, fill in the name of the observed `APP` (optional)
    - `NEWRELIC_INSTALL_PATH`: `New Relic Agent` installation path

- Configure `New Relic` through the configuration file

  Open the `newrelic.config` in the `New Relic Agent` installation directory and replace `{example value}` in the following example with real values, and fill in other values according to the example.

  ```xml
  <?xml version="1.0"?>
  <!-- Copyright (c) 2008-2017 New Relic, Inc.  All rights reserved. -->
  <!-- For more information see: https://newrelic.com/docs/dotnet/dotnet-agent-configuration -->
  <configuration xmlns="urn:newrelic-config" agentEnabled="true" agentRunID="{agent id (can be specified or left blank)}">
    <service licenseKey="{real license key}" ssl="true" host="{www.your-domain-name.com}" port="{Datakit port number}" />
    <application>
      <name>{Name of the monitored APP}</name>
    </application>
    <log level="debug" />
    <transactionTracer enabled="true" transactionThreshold="apdex_f" stackTraceThreshold="500" recordSql="obfuscated" explainEnabled="false" explainThreshold="500" />
    <crossApplicationTracer enabled="true" />
    <errorCollector enabled="true">
      <ignoreErrors>
        <exception>System.IO.FileNotFoundException</exception>
        <exception>System.Threading.ThreadAbortException</exception>
      </ignoreErrors>
      <ignoreStatusCodes>
        <code>401</code>
        <code>404</code>
      </ignoreStatusCodes>
    </errorCollector>
    <browserMonitoring autoInstrument="true" />
    <threadProfiling>
      <ignoreMethod>System.Threading.WaitHandle:InternalWaitOne</ignoreMethod>
      <ignoreMethod>System.Threading.WaitHandle:WaitAny</ignoreMethod>
    </threadProfiling>
  </configuration>
  ```

> Possible issues you may encounter:

- Where is the `New Relic license key`?

  If installing according to the guidance from the `New Relic` official website, the `license key` will be automatically filled out. If manually installing, the `license key` will be required during the installation process. The `license key` appears when [creating an account](https://newrelic.com/signup?via=login){:target="_blank"} or [creating data](newrelic-dotnet.md#install-and-configure-new-relic-dotnet-agent), and it is recommended to save it.

- TLS version incompatibility

  During the deployment of the `New Relic Agent`, if no data is reported and similar `ERROR` messages appear in the `New Relic` logs:

  ```log
  NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
  The request was aborted: Could not create SSL/TLS secure channel.
  ```

  ```log
  NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
  The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException:
  Received an unexpected EOF or 0 bytes from the transport stream.
  ```

  ```log
  NewRelic ERROR: Unable to connect to the New Relic service at collector.newrelic.com:443 : System.Net.WebException:
  The underlying connection was closed: An unexpected error occurred on a receive. ---> System.ComponentModel.Win32Exception:
  The client and server cannot communicate, because they do not possess a common algorithm.
  ```

  Please refer to the document [No data appears after disabling TLS 1.0](https://docs.newrelic.com/docs/apm/agents/net-agent/troubleshooting/no-data-appears-after-disabling-tls-10/){:target="_blank"} to troubleshoot the issue.

## Configure Host {#configure-host-for-newrelic}

Since the `New Relic Agent` requires configuring `HTTPS` for data transmission, complete the [certificate application](certificate.md#self-signed-certificate-with-openssl) before host configuration. Since the `New Relic Agent` needs to verify the validity of the certificate during startup, here you need to complete the self-signing of the `CA` and the issuance of the certificate signed by the self-signed `CA`. After issuing the certificate certification chain, refer to [<<< custom_key.brand_name >>> integration with NewRelic .NET probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"} and [How to import root certificates and intermediate certificates on Windows servers?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"} for the deployment of certificates.

After completing the certificate deployment, you need to configure the `hosts` file accordingly to meet the ability to resolve domain names locally. The `hosts` configuration is as follows:

```config
127.0.0.1    www.your-domain-name.com
```

Where `www.your-domain-name.com` is the domain name specified in the `service.host` item of the `newrelic.config` configuration file.

## Configure `Datakit` {#configure-datakit-for-newrelic}

Navigate to the `conf.d/` directory under the DataKit installation directory, copy `.conf.sample` and rename it to `.conf`. Example:

```toml
    
```

After completing the configuration, restart `Datakit` and `IIS`

```shell
datakit service -R

iisreset
```

## References {#newrelic-references}

- [Official Documentation](https://docs.newrelic.com/){:target="_blank"}
- [Code Repository](https://github.com/newrelic/newrelic-dotnet-agent){:target="_blank"}
- [Download](https://download.newrelic.com/){:target="_blank"}
- [<<< custom_key.brand_name >>> Integration with NewRelic .NET Probe](https://blog.csdn.net/liurui_wuhan/article/details/132889536){:target="_blank"}
- [How to Import Root Certificates and Intermediate Certificates on Windows Servers?](https://baijiahao.baidu.com/s?id=1738111820379111942&wfr=spider&for=pc){:target="_blank"}