# Deploy on Host
---

## Install DataKit Agent

Before performing link data analysis for systems and applications, you need to [deploy <<< custom_key.brand_name >>> DataKit collector](../../../datakit/datakit-install.md) on each target host to collect necessary link data.

Add the command `DK_APM_INSTRUMENTATION_ENABLED=host` before the installation instructions to enable APM auto-injection.

If DataKit is already installed, you only need to upgrade it. Use the following command for the upgrade operation.

```
DK_APM_INSTRUMENTATION_ENABLED=host DK_DEF_INPUTS="ddtrace" DK_UPGRADE=1 bash -c "$(curl -L https://static.<<< custom_key.brand_main_domain >>>/datakit/install.sh)"
```

## Verification

Run the following command to verify. If the value of `instrumentation_enabled` is empty, you need to manually set it to `host`:

```
$ cat /usr/local/datakit/conf.d/datakit.conf | grep instru
instrumentation_enabled = "host"
```

Then restart DataKit:

```
datakit service -R
```

## Restart Application

After installation, restart the application. The following is an example of restarting a Java application:

```
java -jar  springboot-server.jar
```