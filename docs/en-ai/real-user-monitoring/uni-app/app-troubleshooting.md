# Troubleshooting

## SDK Initialization Exception Verification

**When the compilation and runtime platform is Android:**

Check `Logcat` to confirm if there are logs with `Level` set to `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
14:46:04.825 [FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
```

**When the compilation and runtime platform is iOS:**

The SDK internally uses **assertions** to check the correctness of multiple configurations, and crashes will occur along with relevant warnings when configurations are incorrect. However, by default, this only takes effect in the Debug environment. It is recommended to [use an offline packaging project to create a custom debugging base](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/ios.html#how-to-use-offline-packaging-project-to-create-a-custom-debugging-base) and set it to take effect in the Release environment as well.

Click `project` -> `target` -> `Build Settings`, search for `ENABLE_NS_ASSERTIONS`, and change the corresponding setting for Release to Yes.

![uniapp_ios_assert](../img/uniapp_ios_assert.png)

> **It is recommended to configure this only in the debugging base**, using the default configuration for normal packaging and release.

If the above configuration has not been performed, you can also [enable Debug mode](#debug-mode) and check the debug logs in the "Console" to determine whether the SDK has been initialized successfully based on the log content.

## Enable Debug Mode {#debug-mode}

You can enable the debug feature of the SDK through the following configuration.

```vue
	var ftMobileSDK = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  ftMobileSDK.sdkConfig({
				'serverUrl': SDKConst.SERVER_URL,
				'debug': true,
			});
```

> **It is recommended to disable this configuration when releasing versions**

**When the compilation and runtime platform is Android:**

Check `Logcat` logs with `Tag` prefixed with `[FT-SDK]`

**When the compilation and runtime platform is iOS:**

View SDK debug logs in the "Console" on a Mac.

How to use the "Console":

Select `Action` and check `Include brief information`, `Include debug information`.

Select the device being debugged, click the `Start` button, and enter the search condition **[FTLog]** in the search box on the right side. At this point, you can view the SDK's debug logs.

![console_app_use](../img/console_app_use.png)

> [Android Logcat](../android/app-troubleshooting.md#log_sample) and [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) log examples

## SDK Is Running Normally But No Data

* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running normally

* Confirm that the SDK upload address `serverUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the synchronization logs in [Android Logcat](../android/app-troubleshooting.md#data_sync) or [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync).

* Check if datakit is uploading data to the corresponding workspace and whether it is in an offline state. This can be confirmed by logging into Guance and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)

## Data Loss

### Partial Data Loss

* If RUM session data or Log, Trace data is missing, first check if `samplerate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config);

* If RUM data collection is incomplete, with no Resource or Action data:

    Resource and Action data are bound to Views. Ensure that there is a [- startView](app-access.md#startview) operation. Refer to the [RUM-View](app-access.md#rumview) documentation to implement View event collection.

* Investigate network and load issues with the device uploading data and the device running datakit.

## More Related Content
* [Android Troubleshooting](../android/app-troubleshooting.md)
* [iOS Troubleshooting](../ios/app-troubleshooting.md)