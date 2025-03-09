# Troubleshooting

## SDK Initialization Exception Check

**When the compilation and runtime platform is Android:**

Check `Logcat` to confirm whether there are logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
14:46:04.825 [FT-SDK] com.demo E Please install the SDK first (call FTSdk.install(FTSDKConfig ftSdkConfig) when the app starts)
```

**When the compilation and runtime platform is iOS:**

The SDK internally uses **assertions** to check the correctness of multiple configurations. When configurations are incorrect, the program will crash and output relevant warnings, but by default, this only takes effect in the Debug environment. It is recommended to [use an offline packaging project to create a custom debugging base](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/ios.html#how-to-use-offline-packaging-project-to-create-a-custom-debugging-base), and set it to take effect in the Release environment as well.

Click `project` -> `target` -> `Build Settings`, search for `ENABLE_NS_ASSERTIONS`, and change the corresponding setting for Release to Yes.

![uniapp_ios_assert](../img/uniapp_ios_assert.png)

> **It is recommended to configure this only in the debugging base**, use the default configuration for normal packaging and release.

If the above configuration has not been done, you can also [enable Debug mode](#debug-mode) and view the debug logs in the "Console" to determine if the SDK has initialized successfully based on the log content.

## Enable Debug Mode {#debug-mode}

You can enable the debug feature of the SDK through the following configuration.

```vue
	var ftMobileSDK = uni.requireNativePlugin("GCUniPlugin-MobileAgent");
  ftMobileSDK.sdkConfig({
				'serverUrl': SDKConst.SERVER_URL,
				'debug': true,
			});
```

> **It is recommended to disable this configuration when releasing a version**

**When the compilation and runtime platform is Android:**

Check `Logcat` logs with `Tag` prefixed with `[FT-SDK]`.

**When the compilation and runtime platform is iOS:**

View the SDK debug logs in the "Console" on a Mac.

"Console" usage:

Select `Operation` and check `Include brief information`, `Include debug information`.

Select the debugging device, click the `Start` button, and enter the search condition **[FTLog]** in the search box on the right. You can then view the SDK debug logs.

![console_app_use](../img/console_app_use.png)

> [Android Logcat](../android/app-troubleshooting.md#log_sample) and [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) log examples

## SDK Running Normally But No Data

* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running normally.

* Confirm that the SDK upload address `serverUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the synchronization logs in [Android Logcat](../android/app-troubleshooting.md#data_sync) or [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync).

* Check if Datakit is uploading data to the corresponding workspace and if it is in an offline state. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)

## Data Loss

### Partial Data Loss

* If RUM session data or Log, Trace data is missing, first check if `samplerate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config);

* If RUM data collection is incomplete, with no Resource or Action data:

    Resource and Action data are bound to Views, ensure that the [- startView](app-access.md#startview) operation is performed. Refer to the [RUM-View](app-access.md#rumview) documentation to implement View event collection.

* Investigate network and load issues with the device uploading data and the device running Datakit.

## More Related Content
* [Android Troubleshooting](../android/app-troubleshooting.md)
* [iOS Troubleshooting](../ios/app-troubleshooting.md)