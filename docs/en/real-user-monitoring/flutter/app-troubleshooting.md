# Troubleshooting
## Enable Debug Mode
You can enable the SDK's debug functionality through the following configuration. Once enabled, on Android, you can directly see the output debug logs in the Flutter compilation tool. For iOS, you'll need to compile and run using Xcode. You can also check the logs by using the macOS 'Console' application.

```dart
FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true, // enable debug mode
    );
```

> **It is recommended to disable this configuration when releasing the version.**

## Running Normally But No Data

* [Ensure Datakit](../../datakit/why-no-data.md) is running properly. 

* Confirm that the SDK's upload address `serverUrl ` is [configured correctly](app-access.md#base-setting) and initialized properly. In debug mode, you can use the following logs to identify issues with the upload address configuration.

=== "Android"

    ```java
    	// Check datakit address
    	11:15:38.137 [FT-SDK]FTHttpConfigManager com.demo D serverUrl:http://10.0.0.1:9529

    	// Network connect error log
    	10:51:48.879 [FT-SDK]OkHttpEngine com.demo E failed to connect to /10.0.0.1.166 (port 9529) from /10.0.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常
        10:51:48.880 [FT-SDK]SyncTaskManager com.demo E 同步数据失败-[code:2,response:failed to connect to /10.0.0.1 (port 9529) from /10.100.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常]

    	// Sync data success
    	10:51:48.996 [FT-SDK]NetProxy com.demo D HTTP-response:[code:200,response:]
        10:51:48.996 [FT-SDK]SyncTaskManager com.demo D **********************同步数据成功**********************

    ```

=== "iOS"

    ```objective-c
    // Sync data success
    [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:] [line 143] 开始上报事件(本次上报事件数:2)
    [FTLog][INFO] -[FTRequestLineBody getRequestBodyWithEventArray:] [line 149]
    Upload Datas Type:RUM
    Line RequestDatas:
    ...... datas ......
    [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:]_block_invoke [line 157] Upload Response statusCode : 200

    // Before version 1.3.10, it won't print "Upload Response statusCode : 200". You can check the console for error logs. If there are no error logs, it indicates a successful upload.
    //Error Log:
    //Network failure: .....` 或 服务器异常 稍后再试 ......

    ```

* Check if Datakit is uploading data to the corresponding workspace and whether it's in an offline state. You can confirm this by logging into Observability Cloud and checking the "Infrastructure" section.

	![](../img/17.trouble_shooting_android_datakit_check.png)

## pod install error

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

If you encounter version import issues while compiling an iOS app, you need to run the following command in the terminal within your Flutter project's `ios` directory:

```bash
pod install --repo-update
```

## Data Loss
### Partial Data Loss
* If you're missing certain Session data in RUM or logs in Trace, first make sure that you haven't set `sampleRate < 1` in [FTRUMConfig](app-access.md#rum-config), [FTLoggerConfig](app-access.md#log-config), or [FTTraceConfig](app-access.md#trace-config).
* If you're not capturing all RUM data, such as missing Resource or Action data:

Resource and Action data are bound to Views. Ensure that you're using the `startView` operation. You can refer to the [RUM-View](app-access.md#rum-view) documentation for implementing View event capturing.

* Investigate network issues on devices uploading data and on devices running Datakit.

## More Related
* [Android Troubleshooting](../android/app-troubleshooting.md)
* [iOS Troubleshooting](../ios/app-troubleshooting.md)