# Android 会话重放

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

## 前置条件
* 确保您已[设置并初始化 FTSdk RUM 配置](../../../android/app-access.md)，并开启 View 的监控采集。
* Android Session Replay 目前为 alpha 功能，需要使用 `ft-sdk:1.7.0` 以上的版本

## 配置

```gradle
//添加 SDK 的依赖
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]
//需要开启 session replay 功能
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay:[latest_version]'
//需要支持 session replay 需要支持 material 组件
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay-material:[latest_version]'

```

## 代码调用

=== "Java"

	```java
	FTSdk.initSessionReplayConfig(new FTSessionReplayConfig().setSampleRate(1f)
                .setPrivacy(SessionReplayPrivacy.ALLOW)
                .addExtensionSupport(new MaterialExtensionSupport()), context);
	```

=== "Kotlin"

	```kotlin
	FTSdk.initSessionReplayConfig(FTSessionReplayConfig().setSampleRate(1f)
                .setPrivacy(SessionReplayPrivacy.ALLOW)
                .addExtensionSupport(MaterialExtensionSupport()), context)
	```

| **方法名** | **类型** | **必须** | **含义** |
| --- | --- | --- | --- |
| setSampleRate | Float | 否 | 设置采集率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。 |
| setPrivacy | SessionReplayPrivacy | 否 |`SessionReplayPrivacy.ALLOW` 不进行遮蔽隐私数据, `SessionReplayPrivacy.MASK` 遮蔽隐私数据，包括文字、CheckBox，RadioButton，Switch； `SessionReplayPrivacy.USER_INPUT`（推荐）遮蔽用户输入的部份数据,包括输入框中文字、CheckBox，RadioButton，Switch, 默认，为 `SessionReplayPrivacy.MASK` |
| addExtensionSupport | ExtensionSupport | 否 |添加额外自定义支持。使用 `ft-session-replay-material` 可以使用 `MaterialExtensionSupport` 提供额外 Material 组件采集支持  |


