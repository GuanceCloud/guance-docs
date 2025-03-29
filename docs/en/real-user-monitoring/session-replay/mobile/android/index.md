# Android SESSION REPLAY

![](https://img.shields.io/badge/dynamic/json?label=ft-sdk&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/agent/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-android) ![](https://img.shields.io/badge/dynamic/json?label=ft-session-replay-material&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/android/session_replay_material/version.json&link=https://github.com/GuanceCloud/datakit-android)

## Prerequisites
* Ensure you have [set up and initialized the FTSdk RUM configuration](../../../android/app-access.md), and enabled View monitoring.
* Android Session Replay is currently in alpha, requiring the use of `ft-sdk:1.7.0` or higher versions.

## Configuration

```gradle
// Add SDK dependencies
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-sdk:[latest_version]
// Enable session replay functionality
implementation 'com.cloudcare.ft.mobile.sdk.tracker.agent:ft-session-replay:[latest_version]'
// To support session replay, material components must be supported
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
| setSampleRate | Float | No | Set the sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. |
| setPrivacy | SessionReplayPrivacy | No |`SessionReplayPrivacy.ALLOW` does not mask privacy data, `SessionReplayPrivacy.MASK` masks all data, including text, CheckBox, RadioButton, Switch; `SessionReplayPrivacy.USER_INPUT` (recommended) masks some user input data, including text in input fields, CheckBox, RadioButton, Switch, default is `SessionReplayPrivacy.MASK`. **Deprecated soon, compatible for use, recommended to prioritize using `setTouchPrivacy`, `setTextAndInputPrivacy` for masking settings**|
| setTextAndInputPrivacy | TextAndInputPrivacy | No |`TextAndInputPrivacy.MASK_SENSITIVE_INPUTS` only masks password information, `TextAndInputPrivacy.MASK_ALL_INPUTS` masks some user input data, including text in input fields, CheckBox, RadioButton, Switch, `TextAndInputPrivacy.MASK_ALL`, masks all data, including text, CheckBox, RadioButton, Switch. Default `TextAndInputPrivacy.MASK_ALL`, **after setting overrides the `setPrivacy` configuration**, supported by `ft-session-replay` version 0.1.1-alpha01 and above, |
| setTouchPrivacy | TouchPrivacy | No |`TouchPrivacy.SHOW` does not mask touch data, `TouchPrivacy.HIDE` masks touch data. **After setting overrides the `setPrivacy` configuration** supported by `ft-session-replay` version 0.1.1-alpha01 and above|
| addExtensionSupport | ExtensionSupport | No | Adds additional custom support. Using `ft-session-replay-material` can provide extra Material component collection support through `MaterialExtensionSupport` |

## Privacy Overrides

> Supported by `ft-session-replay` version 0.1.1-alpha01 and above

In addition to supporting global masking level configurations via `FTSessionReplayConfig`, the SDK also supports overriding these settings at the view level.

View-level privacy override:

* Supports overriding text and input masking levels and touch masking levels.
* Supports setting to completely hide specific views.

Note:

* To ensure correct recognition of override settings, they should be applied as early as possible within the view lifecycle. This prevents Session Replay from processing the view before the override settings are applied.
* Privacy overrides affect the view and its subviews. This means that even if an override is applied to a view that may not take immediate effect (e.g., applying image overrides to text inputs), the override will still apply to all subviews.
* **Priority of privacy overrides: Subview > Parent View > Global Settings**

### Text and Input Override

To override text and input privacy, use `PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(View,TextAndInputPrivacy)` on the view instance and set it to one of the values in the `TextAndInputPrivacy` enumeration. If you need to remove existing override rules, simply set this property to `null`.

=== "Java"

	```java
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL);
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, TextAndInputPrivacy.MASK_ALL)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTextAndInputPrivacy(view, null)

	```

### Touch Override {#touch_override}

To override touch privacy, use `PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(View,TouchPrivacy)` on the view instance and set it to one of the values in the `TouchPrivacy` enumeration. If you need to remove existing override rules, simply set this property to `null`.

=== "Java"

	```java
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE);
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null);

	```

=== "Kotlin"

	```kotlin 
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, TouchPrivacy.HIDE)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayTouchPrivacy(view, null)
	```

### Hidden Element Override

For sensitive elements that need to be fully hidden, use `PrivacyOverrideExtensions.setSessionReplayHidden(View,Boolean)` for setting.

When an element is marked as hidden, it will be replaced with a "Hidden" placeholder in the replay, and its subviews will not be recorded.

**Note**: Marking a view as hidden will not prevent touch interactions from being recorded on that element. To hide touch interactions, in addition to marking the element as hidden, use [Touch Override](#touch_override).

=== "Java"

	```java
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

=== "Kotlin"

	```kotlin 
	// Mark specified view to hide element override
	PrivacyOverrideExtensions.setSessionReplayHidden(view, true)
	// Remove hidden element override settings for the view
	PrivacyOverrideExtensions.setSessionReplayHidden(view, false)
	```

## Code and Configuration References
 * [Android Demo Gradle Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/build.gradle#L159)
 * [Android Demo Code Invocation](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/android/demo/app/src/main/java/com/cloudcare/ft/mobile/sdk/demo/DemoApplication.kt#L90)