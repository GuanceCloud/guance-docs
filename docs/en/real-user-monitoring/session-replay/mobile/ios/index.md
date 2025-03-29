# iOS SESSION REPLAY

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-ios) 

## Prerequisites
* Ensure you have [set up and initialized the FTMobileSDK RUM configuration](../../../ios/app-access.md), and enabled View monitoring collection.
* iOS Session Replay is currently an alpha feature, **Version support: SDK.Version >= 1.6.0**

## Configuration

Link the `FTSessionReplay` component from the `FTMobileSDK` library to your project according to your package manager:

| Package Manager                                                     | Installation Steps                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [CocoaPods](https://cocoapods.org/)                          | Add `pod 'FTMobileSDK/FTSessionReplay','latest_version'` to your `Podfile`. You need to specify the SDK version number. |
| [Swift Package Manager](https://www.swift.org/package-manager/) | Add `FTSessionReplay` as a dependency for your app target.            |

## Code Invocation {#code_sample}

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/FTRumSessionReplay.h>
    
       FTSessionReplayConfig *srConfig = [[FTSessionReplayConfig alloc]init];
       srConfig.touchPrivacy = FTTouchPrivacyLevelShow;
       srConfig.textAndInputPrivacy = FTTextAndInputPrivacyLevelMaskSensitiveInputs;
       srConfig.sampleRate = 100;
       [[FTRumSessionReplay sharedInstance] startWithSessionReplayConfig:srConfig];
    ```

=== "Swift"

    ```swift
       let srConfig = FTSessionReplayConfig.init()
       srConfig.touchPrivacy = .show
       srConfig.textAndInputPrivacy = .maskSensitiveInputs
       srConfig.sampleRate = 100
       FTRumSessionReplay.shared().start(with: srConfig)
    ```



| Property                | Type                       | Required | Meaning                                                         |
| ------------------- | -------------------------- | ---- | ------------------------------------------------------------ |
| sampleRate          | int                        | No   | Sampling rate. Value range [0,100], 0 means no sampling, 100 means full sampling, default value is 100. This sampling rate is based on the RUM sampling rate. |
| privacy             | FTSRPrivacy                | No   | Set the privacy level for content masking in Session Replay. Default `FTSRPrivacyMask`.<br/> Masking process: Text replaced with * or # <br>`FTSRPrivacyAllow`: Records all content except sensitive input controls, such as password inputs<br/>`FTSRPrivacyMaskUserInput`: Masks input elements. For example `UITextField`, `UISwitch` etc<br/>`FTSRPrivacyMask`: Masks all content.<br>**Deprecated soon, use `touchPrivacy` and `textAndInputPrivacy` for fine-grained privacy settings** |
| touchPrivacy        | FTTouchPrivacyLevel        | No   | Available privacy levels for touch masking in session replay. Default `FTTouchPrivacyLevelHide`.<br>`FTTouchPrivacyLevelShow`: Shows all user touches<br>`FTTouchPrivacyLevelHide`: Masks all user touches<br>**Overrides `privacy` configuration after setting**<br> Supported in SDK 1.6.1 and above versions |
| textAndInputPrivacy | FTTextAndInputPrivacyLevel | No   | Available privacy levels for text and input masking in session replay. Default `FTTextAndInputPrivacyLevelMaskAll`<br>`FTTextAndInputPrivacyLevelMaskSensitiveInputs`: Shows all text except sensitive inputs, such as password inputs<br>`FTTextAndInputPrivacyLevelMaskAllInputs`: Masks all input fields, such as `UITextField`, `UISwitch`, `UISlider` etc<br>`FTTextAndInputPrivacyLevelMaskAll`: Masks all text and input<br>**Overrides `privacy` configuration after setting**<br> Supported in SDK 1.6.1 and above versions |

## Privacy Overrides

> Supported in SDK 1.6.1 and above versions

In addition to supporting global masking level configurations via `FTSessionReplayConfig`, the SDK also supports overriding these settings at the view level.

View-level privacy overrides:

* Supports overriding text and input masking levels and touch masking levels
* Supports setting specific views to be fully hidden

Note:

* To ensure proper recognition of overrides, they should be applied early in the view lifecycle. This prevents the session replay from processing views before the application’s overrides are set.
* Privacy overrides affect the view and its subviews. This means that even if the override is applied to a view that may not take immediate effect (e.g., applying image overrides to text input), the override will still apply to all subviews.
* **Privacy override priority: Subviews > Parent Views > Global Settings**

### Text and Input Overrides

To override text and input privacy, use `sessionReplayOverrides.textAndInputPrivacy` on the view instance and set it to one of the values in the `FTTextAndInputPrivacyLevelOverride` enumeration. If you need to remove existing override rules, simply set this property to `FTTextAndInputPrivacyLevelOverrideNone`.

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // Override text and input for a specific view
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = FTTextAndInputPrivacyLevelOverrideMaskAll;
       // Remove text and input override settings for the view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTextAndInputPrivacyLevelOverrideNone;
    ```

=== "Swift"

    ```swift 
       // Override text and input for a specific view
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = .maskAll
       // Remove text and input override settings for the view
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = .none
    ```

### Touch Overrides {#touch_override}

To override touch privacy, use `sessionReplayOverrides.touchPrivacy` on the view instance and set it to one of the values in the `FTTouchPrivacyLevelOverride` enumeration. If you need to remove existing override rules, simply set this property to `FTTouchPrivacyLevelOverrideNone`.

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // Set touch override for a specific view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTouchPrivacyLevelOverrideShow;
       // Remove a touch override from your view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTouchPrivacyLevelOverrideNone;
    
    ```

=== "Swift"

    ```swift 
       // Set touch override for a specific view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = .show;
       // Remove touch override settings for the view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = .none;
    ```

### Element Hiding Overrides

For sensitive elements that need to be completely hidden, use `sessionReplayPrivacyOverrides.hide`.

When an element is set to hidden, it will be replaced with a "Hidden" placeholder during playback, and its subviews will not be recorded.

**Note**: Marking a view as hidden does not prevent touch interactions from being recorded on that element. To hide touch interactions, use [touch overrides](#touch_override) in addition to marking the element as hidden.

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // Mark a specific view for hidden element override
       myView.sessionReplayPrivacyOverrides.hide = YES;
       // Remove hidden element override settings for the view
       myView.sessionReplayPrivacyOverrides.hide = NO;
    ```

=== "Swift"

    ```swift 
       // Mark a specific view for hidden element override
       myView.sessionReplayPrivacyOverrides.touchPrivacy = true;
       // Remove hidden element override settings for the view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = false;
    ```

## Code and Configuration References

 * [iOS Demo Cocoapod Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/Podfile#L11)
 * [iOS Demo Code Invocation](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/GuanceDemo/AppDelegate.swift#L69)