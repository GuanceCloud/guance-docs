# 移动端会话重放（Session Replay Moible）
移动端会话重放通过以录制重播每次用户交互来扩展对移动应用程序的可观测性，从而可以更轻松地重现崩溃和错误当时的场景，此外还能通过录制还能发现用户的实际交互体验，对产品的交互体验提供帮助。目前这功能处于 alpha 阶段，适用 Android 和 iOS 的原生应用。

## 采集器配置 {#datakit_setup}

在使用会话重放之前，使用本地部署方式需要先 [安装 Datakit](../../../datakit/datakit-install.md) ，然后开启 [RUM 采集器](../../../integrations/rum.md) 会话重放对应的参数 `session_replay_endpoints`。使用公网 DataWay 不需要额外的配置。

**注意**：会话重放功能需要升级 DataKit 版本至 1.5.5 及以上。


## 查看会话重放
移动端上的会话重放与 web 查看方式相同，可以参考 [web 会话重放访问方式](../web/index.md#view_replay)


## 第三方库支持
* [dd-sdk-android-session-replay](https://github.com/DataDog/dd-sdk-android/tree/develop/features/dd-sdk-android-session-replay)
* [dd-sdk-ios/DatadogSessionReplay](https://github.com/DataDog/dd-sdk-ios/tree/develop/DatadogSessionReplay)
