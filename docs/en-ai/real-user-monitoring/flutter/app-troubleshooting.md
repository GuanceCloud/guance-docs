# Troubleshooting
## Enable Debug Mode {#debug-mode}
You can enable the Debug feature of the SDK with the following configuration. After enabling, for Android systems, you can directly see the output Debug logs in the Flutter compilation tool. For iOS, you need to compile and run via Xcode or view through the MacOS Console.

```dart
FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true, // Enable debug mode
  );
```

**Note**: It is recommended to disable this configuration when releasing a Release version.

> [Android Logcat](../android/app-troubleshooting.md#log_sample) and [iOS Xcode Console](../ios/app-troubleshooting.md#log_sample) log examples

## SDK Running Normally but No Data

* [Troubleshoot Datakit](../../datakit/why-no-data.md) to ensure it is running normally.

* Confirm that the SDK upload address `datakitUrl` or `datawayUrl` is [configured correctly](app-access.md#base-setting) and initialized properly. In [debug mode](#debug-mode), check the synchronization logs in [Android Logcat](../android/app-troubleshooting.md#data_sync) or [iOS Xcode Console](../ios/app-troubleshooting.md#data_sync).

* Check if Datakit is uploading data to the corresponding workspace and whether it is offline. This can be confirmed by logging into <<< custom_key.brand_name >>> and checking the "Infrastructure".

	![](../img/17.trouble_shooting_android_datakit_check.png)

## Errors Occur During Pod Compilation

```bash
[!] CocoaPods could not find compatible versions for pod "FTMobileSDK/FTMobileAgent":
  In snapshot (Podfile.lock):
    FTMobileSDK/FTMobileAgent (= 1.3.9-alpha.14)

  In Podfile:
    ft_mobile_agent_flutter (from `.symlinks/plugins/ft_mobile_agent_flutter/ios`) was resolved to 0.0.2, which depends on
      FTMobileSDK/FTMobileAgent (= 1.3.10-beta.2)


You have either:
 * out-of-date source repos which you can update with `pod repo update` or with `pod install --repo-update`.
 * changed the constraints of dependency `FTMobileSDK/FTMobileAgent` inside your development pod `ft_mobile_agent_flutter`.
   You should run `pod update FTMobileSDK/FTMobileAgent` to apply changes you've made.

```

If you encounter similar version import issues while compiling an iOS app, you need to execute the following command in the terminal within the ios directory of your Flutter project:

```bash
pod install --repo-update
```

## Data Loss
### Partial Data Loss
* If RUM session data or a few pieces of data in Logs or Trace are missing, first check if `sampleRate < 1` is set in [FTRUMManager.setConfig](app-access.md#rum-config), [FTLogger.logConfig](app-access.md#log-config), [FTTracer.setConfig](app-access.md#trace-config).
* If RUM data collection is incomplete, with missing Resource or Action data?

	Resource and Action data are bound to Views. Ensure there is a `startView` operation. Refer to the [RUM-View](app-access.md#rum-view) documentation to implement View event collection.

* Investigate network and load issues with devices uploading data and Datakit installation devices.

## Further Reading

* [Android Troubleshooting](../android/app-troubleshooting.md)
* [iOS Troubleshooting](../ios/app-troubleshooting.md)