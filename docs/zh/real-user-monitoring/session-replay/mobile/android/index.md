# Android 会话重放

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

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

## 代码调用 {#code_sample}

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
| setPrivacy | SessionReplayPrivacy | 否 |`SessionReplayPrivacy.ALLOW` 不进行屏蔽隐私数据, `SessionReplayPrivacy.MASK` 屏蔽所有数据，包括文字、CheckBox，RadioButton，Switch； `SessionReplayPrivacy.USER_INPUT`（推荐）屏蔽用户输入的部份数据,包括输入框中文字、CheckBox，RadioButton，Switch, 默认，为 `SessionReplayPrivacy.MASK`。**即将废弃，可以兼容使用，建议优先使用 `setTouchPrivacy` 、`setTextAndInputPrivacy` 进行屏蔽设置**|
| setTextAndInputPrivacy | TextAndInputPrivacy | 否 |`TextAndInputPrivacy.MASK_SENSITIVE_INPUTS` 只对密码等信息进行屏蔽, `TextAndInputPrivacy.MASK_ALL_INPUTS` 屏蔽用户输入的部份数据，包括输入框中文字、CheckBox，RadioButton，Switch，`TextAndInputPrivacy.MASK_ALL`，屏蔽所有数据，包括文字、CheckBox，RadioButton，Switch。默认 `TextAndInputPrivacy.MASK_ALL`，**设置后覆盖 `setPrivacy` 的配置**，`ft-session-replay` 0.1.1-alpha01 以上版本支持， |
| setTouchPrivacy | TouchPrivacy | 否 |`TouchPrivacy.SHOW` 不进行触控数据屏蔽, `TouchPrivacy.HIDE` 屏蔽触控数据。**设置后覆盖 `setPrivacy` 的配置** `ft-session-replay` 0.1.1-alpha01 以上版本支持|
| addExtensionSupport | ExtensionSupport | 否 |添加额外自定义支持。使用 `ft-session-replay-material` 可以使用 `MaterialExtensionSupport` 提供额外 Material 组件采集支持  |

## 隐私覆盖 {#privacy_override}

> ft-session-replay 0.1.1-alpha01 以上版本支持

SDK 除了支持通过 `FTSessionReplayConfig` 配置全局屏蔽级别，还支持在视图级覆盖这些设置。

视图级隐私覆盖：

* 支持覆盖文本和输入屏蔽级别与触控屏蔽级别
* 支持设置完全隐藏特定视图

注意：

* 为了确保正确识别覆盖设置，应在视图生命周期中尽早应用它们。这可以防止 Session Replay 在应用设置的覆盖之前处理视图的情况。
* 隐私覆盖会影响视图及其子视图。这意味着，即使覆盖应用于可能不会立即生效的视图（例如，将图片覆盖应用于文本输入），覆盖仍会应用于所有子视图。
* **隐私覆盖优先级：子视图 > 父视图  > 全局设置**

### 文本和输入覆盖 {#text_and_input_override}

要覆盖文本和输入隐私，请在视图实例上使用 `PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(View,TextAndInputPrivacy)` 将其设为 `TextAndInputPrivacy` 枚举中的某个值。若需移除现有覆盖规则，直接将该属性设为 `null` 即可。

=== "Java"

	```java
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL);
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL)
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null)

	```

### 触控覆盖 {#touch_override}

要覆盖触控隐私，请在视图实例上使用 `PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(View,TouchPrivacy)` 将其设为 `TouchPrivacy` 枚举中的某个值。若需移除现有覆盖规则，直接将该属性设为 `null` 即可。

=== "Java"

	```java
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE);
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin 
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE)
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null)
	```


### 隐藏元素覆盖 {#privacy_hidden}

对于需要完全隐藏的敏感元素，请使用 `PrivacyOverrideExtensions.setSessionReplayHidden(View,Boolean)` 进行设置。

当设置某个元素为隐藏时 ，它将在重放中被标记为 "Hidden" 的占位符替换，并且不会记录其子视图。

**注意**：将视图标记为隐藏不会阻止在该元素上记录触控交互。要隐藏触控交互，除了将元素标记为隐藏外，还要使用[触控覆盖](#touch_override)。


=== "Java"

	```java
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

=== "Kotlin"

	```kotlin 
	// 对指定视图标记隐藏元素覆盖
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// 移除视图的隐藏元素覆盖设置
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

## Jetpack Compose 支持
目前暂不支持 Jetpack Compose 相关界面的 Session Replay 录制

## 代码和配置参考
 * [Android Demo Gradle 配置](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/build.gradle#L159)
 * [Android Demo 代码调用](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L90)


