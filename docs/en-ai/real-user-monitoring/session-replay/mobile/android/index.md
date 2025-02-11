# Android Session Replay

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

## Prerequisites
* Ensure you have [configured and initialized the FTSdk RUM settings](../../../android/app-access.md) and enabled monitoring for Views.
* Android Session Replay is currently an alpha feature, requiring `ft-sdk:1.7.0` or higher.

## Configuration

```gradle
// Add SDK dependencies
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
// Enable session replay functionality
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay:[latest_version]'
// Support for session replay requires material components support
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay-material:[latest_version]'
```

## Code Usage {#code_sample}

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

| **Method Name** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setSampleRate | Float | No | Sets the sampling rate, range [0,1], where 0 means no collection and 1 means full collection. Default value is 1. |
| setPrivacy | SessionReplayPrivacy | No | `SessionReplayPrivacy.ALLOW`: does not mask privacy data; `SessionReplayPrivacy.MASK`: masks privacy data including text, CheckBox, RadioButton, Switch; `SessionReplayPrivacy.USER_INPUT` (recommended): masks part of user input data including text in input fields, CheckBox, RadioButton, Switch. Default is `SessionReplayPrivacy.MASK`. |
| addExtensionSupport | ExtensionSupport | No | Adds custom extension support. Using `ft-session-replay-material` allows using `MaterialExtensionSupport` to provide additional Material component collection support. |

## Code and Configuration References
 * [Android Demo Gradle Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/build.gradle#L159)
 * [Android Demo Code Usage](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L90)