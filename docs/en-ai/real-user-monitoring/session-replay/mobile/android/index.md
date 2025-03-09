# Android Session Replay

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

## Prerequisites
* Ensure you have [configured and initialized the FTSdk RUM settings](../../../android/app-access.md) and enabled monitoring for Views.
* Android Session Replay is currently an alpha feature, requiring version `ft-sdk:1.7.0` or higher.

## Configuration

```gradle
// Add SDK dependencies
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]'
// Enable session replay functionality
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay:[latest_version]'
// Support for session replay requires support for Material components
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay-material:[latest_version]'
```

## Code Invocation {#code_sample}

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
| setSampleRate | Float | No | Sets the sampling rate, with a range of [0,1]. 0 means no collection, 1 means full collection. The default value is 1. |
| setPrivacy | SessionReplayPrivacy | No | `SessionReplayPrivacy.ALLOW` does not obscure private data; `SessionReplayPrivacy.MASK` obscures private data, including text, CheckBox, RadioButton, Switch; `SessionReplayPrivacy.USER_INPUT` (recommended) partially obscures user input data, including text in input fields, CheckBox, RadioButton, Switch. The default is `SessionReplayPrivacy.MASK`. |
| addExtensionSupport | ExtensionSupport | No | Adds additional custom support. Using `ft-session-replay-material` allows using `MaterialExtensionSupport` to provide extra support for collecting Material components. |

## Code and Configuration References
 * [Android Demo Gradle Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/build.gradle#L159)
 * [Android Demo Code Invocation](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L90)