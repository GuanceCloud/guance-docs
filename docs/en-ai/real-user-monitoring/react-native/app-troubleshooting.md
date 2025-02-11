# Troubleshooting

## SDK Initialization Exception Check

**When the compilation and runtime platform is Android:**

Check `Logcat` to confirm if there are logs with `Level` as `Error` and `Tag` prefixed with `[FT-SDK]`

```kotlin
14:46:04.825 [FT-SDK] com.demo E Please install the SDK (call FTSdk.install(FTSDKConfig ftSdkConfig) when the application starts)
```

**When the compilation and runtime platform is iOS:**

In Debug mode, after configuring the Guance SDK and running the application for the first time, please check your debugger console in Xcode. The SDK will use assertions to verify multiple configurations and crash with relevant warnings if there are configuration errors.

For example, if the Datakit Metrics write address is not set during SDK configuration, the program will crash and output a warning ⚠️ in the console.

```objective-c
*** Assertion failure in +[FTMobileAgent startWithConfigOptions:], FTMobileAgent.m:53
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Please set the Datakit Metrics write address'
```

## Enabling Debug Mode {#debug-mode}

You can enable the debug functionality of the SDK through the following configuration.

```tsx
 let config: FTMobileConfig = {
    serverUrl: Config.SERVER_URL,
    debug: true
 };
 FTMobileReactNative.sdkConfig(config);
```

> **It is recommended to disable this configuration when releasing the Release version**

**When the compilation and runtime platform is Android:**
Check `Logcat` logs with `Tag` prefixed with `[FT-SDK]`.

**When the compilation and runtime platform is iOS:**

The debug logs of the SDK are identified with the prefix **[FTLog]**.

* When using Xcode, you can directly view the SDK's debug logs in the Xcode debugger console.

* When running using terminal commands like `yarn ios` or `yarn react-native run-ios`, you can view the SDK debug logs in the Console on Mac.

Using the Console:

  Select `Action` and check `Include Brief Information`, `Include Debug Information`.

  Select the debugging device, click the `Start` button, and enter the search condition **[FTLog]** in the search box on the right side. You can now view the SDK debug logs.

  ![console_app_use](../img/console_app_use.png)

> [Android Logcat](../android/app-troubleshooting.md#log_sample) and [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) log samples

## SDK Running Normally But No Data

* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running correctly.

* Confirm that the SDK upload URL `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the synchronization logs in [Android Logcat](../android/app-troubleshooting.md#data_sync) or [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync).

* Verify whether Datakit is uploading data to the corresponding workspace and if it is offline. This can be confirmed by logging into Guance and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)

## Data Loss

### Partial Data Loss

* If RUM Session data or Log, Trace data is missing, first check if `sampleRate < 1` is set in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), [FTTraceConfig](app-access.md#trace-config);

* If RUM data collection is incomplete, without Resource or Action data?

    Resource and Action data are bound to View. Ensure that there is an `FTReactNativeRUM.startView` operation. Refer to the [RUM-View](app-access.md#rumview) documentation to implement View event collection.

* Investigate network issues and load problems with the device uploading data and the device running Datakit.


## Compatibility Issues
### React Native Navigation Compatibility Issue
#### ReactTextShadowNode.UNSET Symbol Not Found 
This issue is caused by a version compatibility problem with react-native-navigation. Refer to the related [issue here](https://github.com/wix/react-native-navigation/issues/7881#issuecomment-2164213896). Fix this issue by modifying or [downloading](https://static.guance.com/ft-sdk-package/react_navigation_fix/ReactTypefaceUtils.java) and replacing `ReactTypefaceUtils.java`.

### Module `react/jsx-runtime` Not Found

**Affected Versions: SDK Version 0.3.0 && React Version < 16.14.0**

**Reason**: The SDK internally uses `react/jsx-runtime`, which is supported only in React >= 16.14.0.

**Fix Recommendations**:

* Upgrade SDK version to >= 0.3.1 

  **Note:** It is not recommended to add the `@cloudcare/react-native-mobile` dependency library via a local path, as this may prevent the error from being fixed.

## More Related Content
* [Android Troubleshooting](../android/app-troubleshooting.md)
* [iOS Troubleshooting](../ios/app-troubleshooting.md)