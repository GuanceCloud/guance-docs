# Deploy on Host
---

## Install DataKit Agent

Before performing link data analysis for systems and applications, it is necessary to [deploy the Guance DataKit collector on each target host](../../../datakit/datakit-install.md) to collect essential trace data.


Add this command before the installation instructions: `DK_APM_INSTRUMENTATION_ENABLED=host` to enable APM auto-injection.

If DataKit is already installed, you only need to upgrade it. Use the following command for the upgrade operation:

```
DK_APM_INSTRUMENTATION_ENABLED=host DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

## Verification

Run the following command to verify. If the value of `instrumentation_enabled` is empty, manually set it to `host`:

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
java -jar springboot-server.jar
```