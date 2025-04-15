# Android SESSION REPLAY

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

## Prerequisites
* Ensure you have [set up and initialized the FTSdk RUM configuration](../../../android/app-access.md), and enabled View monitoring.
* Android Session Replay is currently an alpha feature, requiring the use of `ft-sdk:1.7.0` or later versions.

## Configuration

```gradle
// Add SDK dependencies
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]
// Enable session replay functionality
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay:[latest_version]'
// Material component support required for session replay
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

| **Method Name** | **Type** | **Required** | **Meaning** |
| --- | --- | --- | --- |
| setSampleRate | Float | No | Set the sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setPrivacy | SessionReplayPrivacy | No | `SessionReplayPrivacy.ALLOW` does not mask privacy data, `SessionReplayPrivacy.MASK` masks all data including text, CheckBox, RadioButton, Switch; `SessionReplayPrivacy.USER_INPUT` (recommended) masks part of user input data including text in input fields, CheckBox, RadioButton, Switch. Default is `SessionReplayPrivacy.MASK`. **Deprecated soon, can be used for compatibility, it is recommended to prioritize using `setTouchPrivacy` and `setTextAndInputPrivacy` for masking settings**|
| setTextAndInputPrivacy | TextAndInputPrivacy | No | `TextAndInputPrivacy.MASK_SENSITIVE_INPUTS` only masks password information, `TextAndInputPrivacy.MASK_ALL_INPUTS` masks part of user input data including text in input fields, CheckBox, RadioButton, Switch, `TextAndInputPrivacy.MASK_ALL`, masks all data including text, CheckBox, RadioButton, Switch. Default is `TextAndInputPrivacy.MASK_ALL`. **This setting overrides `setPrivacy` configuration**, supported in `ft-session-replay` version 0.1.1-alpha01 and above. |
| setTouchPrivacy | TouchPrivacy | No | `TouchPrivacy.SHOW` does not mask touch data, `TouchPrivacy.HIDE` masks touch data. **This setting overrides `setPrivacy` configuration**, supported in `ft-session-replay` version 0.1.1-alpha01 and above. |
| addExtensionSupport | ExtensionSupport | No | Add extra custom support. Use `ft-session-replay-material` to enable `MaterialExtensionSupport` which provides additional material component collection support. |

## Privacy Override {#privacy_override}

> Supported in `ft-session-replay` version 0.1.1-alpha01 and above.

In addition to supporting global masking level configuration via `FTSessionReplayConfig`, the SDK also supports overriding these settings at the view level.

View-level privacy override:

* Supports overriding text and input masking levels as well as touch masking levels.
* Supports setting specific views to be completely hidden.

Note:

* To ensure correct recognition of override settings, they should be applied as early as possible in the view lifecycle. This prevents the Session Replay from processing the view before the application of the override settings.
* Privacy overrides affect the view and its subviews. This means that even if the override is applied to a view that may not take immediate effect (e.g., applying image overrides to text inputs), the override will still apply to all subviews.
* **Priority of privacy overrides: Subviews > Parent Views > Global Settings**

### Text and Input Overrides {#text_and_input_override}

To override text and input privacy, use `PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(View,TextAndInputPrivacy)` on the view instance and set it to one of the values in the `TextAndInputPrivacy` enumeration. If you need to remove existing override rules, simply set this property to `null`.

=== "Java"

	```java
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL);
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null)

	```

### Touch Overrides {#touch_override}

To override touch privacy, use `PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(View,TouchPrivacy)` on the view instance and set it to one of the values in the `TouchPrivacy` enumeration. If you need to remove existing override rules, simply set this property to `null`.

=== "Java"

	```java
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE);
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin 
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null)
	```

### Hidden Element Overrides {#privacy_hidden}

For sensitive elements that need to be fully hidden, use `PrivacyOverrideExtensions.setSessionReplayHidden(View,Boolean)` for setting.

When an element is marked as hidden, it will be replaced by a "Hidden" placeholder during replay, and its subviews will not be recorded.

**Note**: Marking a view as hidden will not prevent recording touch interactions on that element. To hide touch interactions, in addition to marking the element as hidden, use [Touch Overrides](#touch_override).

=== "Java"

	```java
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

=== "Kotlin"

	```kotlin 
	// Mark specified view with hidden element override
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

## Jetpack Compose Support
Currently, there is no support for Session Replay recording of Jetpack Compose related interfaces.

## Code and Configuration References
 * [Android Demo Gradle Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/build.gradle#L159)
 * [Android Demo Code Invocation](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L90)