# 故障排查
## 开启 Debug 调试
您可以通过以下配置，开启 SDK 的 Debug 功能，开启之后 Android 系统，您可以直接在 Flutter 编译工具上看到输出的 Debug 日志，iOS 您需要通过 Xcode 编译运行，Xcode 编译，或者通过 MacOS 控制台应用查看。

```dart
FTMobileFlutter.sdkConfig(
      serverUrl: serverUrl,
      debug: true, // 开启 debug 模式
    );
```

**注意**：建议 Release 版本发布时，关闭这个配置。

## SDK 正常运行但是没有数据

* [排查 Datakit](../../datakit/why-no-data.md) 是否正常运行

* 确认 SDK 上传地址`serverUrl `[配置正确](app-access.md#base-setting)，并正确初始化。debug 模式下，可以下列日志来判断上传地址配置问题。

=== "Android"

    ```java
    	//检查上传地址是否正确进入 SDK 配置
    	11:15:38.137 [FT-SDK]FTHttpConfigManager com.demo D serverUrl:http://10.0.0.1:9529

    	//以下是连接错误日志
    	10:51:48.879 [FT-SDK]OkHttpEngine com.demo E failed to connect to /10.0.0.1.166 (port 9529) from /10.0.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常
        10:51:48.880 [FT-SDK]SyncTaskManager com.demo E 同步数据失败-[code:2,response:failed to connect to /10.0.0.1 (port 9529) from /10.100.0.2 (port 48254) after 10000ms,检查本地网络连接是否正常]

    	//以下是正常同步日志
    	10:51:48.996 [FT-SDK]NetProxy com.demo D HTTP-response:[code:200,response:]
        10:51:48.996 [FT-SDK]SyncTaskManager com.demo D **********************同步数据成功**********************

    ```

=== "iOS"

    ```objective-c
    //以下是正常同步日志
    [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:] [line 143] 开始上报事件(本次上报事件数:2)
    [FTLog][INFO] -[FTRequestLineBody getRequestBodyWithEventArray:] [line 149]
    Upload Datas Type:RUM
    Line RequestDatas:
    ...... datas ......
    [FTLog][INFO] -[FTTrackDataManger flushWithEvents:type:]_block_invoke [line 157] Upload Response statusCode : 200

    //在 1.3.10 版本之前并不会打印 Upload Response statusCode : 200  ，可以查看控制台是否有错误日志，没有错误日志即上传成功。
    //错误日志:
    //Network failure: .....` 或 服务器异常 稍后再试 ......

    ```

* datakit 是否往对应工作空间上传数据，是否处于离线状态。这个可以通过登录观测云，查看「基础设施」来确认这个问题。

	![](../img/17.trouble_shooting_android_datakit_check.png)

## 编译过程中 pod 发生错误

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

如果编译 iOS 应用时碰到类似版本导入这个问题，您需要在终端在 flutter 项目的 ios 文件，执行以下命令：

```bash
pod install --repo-update
```

## 数据丢失
### 丢失部份数据
* 如果丢失 RUM 某一个 Session 数据或 Log，Trace 中的几条数据时，首先需要排除是否在 [FTRUMManager.setConfig](app-access.md#rum-config), [FTLogger.logConfig](app-access.md#log-config), [FTTracer.setConfig](app-access.md#trace-config) 设置了 `sampleRate <  1`。
* 采集到 RUM 数据不全，没有 Resource 或 Action 数据？

	Resource 和 Action 数据是与 View 进行绑定的，需要确保有 startView 操作，可参考 [RUM-View](app-access.md#rum-view}) 文档来实现 View 事件采集。

* 排查上传数据设备网络与安装 datakit 设备网路与负载问题。

## 更多阅读

* [Android 故障排查](../android/app-troubleshooting.md)
* [iOS 故障排查](../ios/app-troubleshooting.md)