# iOS Session Replay

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/ios/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-ios) 

## Prerequisites
* Ensure you have [configured and initialized the FTMobileSDK RUM settings](../../../ios/app-access.md) and enabled View monitoring.
* iOS Session Replay is currently an alpha feature, **version support: SDK.Version >= 1.6.0**

## Configuration

Link the `FTSessionReplay` component from the `FTMobileSDK` library to your project according to your package manager:

| Package Manager                                                     | Installation Steps                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [CocoaPods](https://cocoapods.org/)                          | Add `pod 'FTMobileSDK/FTSessionReplay','latest_version'` to your `Podfile`. You need to specify the SDK version number. |
| [Swift Package Manager](https://www.swift.org/package-manager/) | Add `FTSessionReplay` as a dependency for your app target.            |

## Code Invocation {#code_sample}

=== "Objective-C"

    ```objective-c
       FTSessionReplayConfig *srConfig = [[FTSessionReplayConfig alloc]init];
       srConfig.privacy = FTSRPrivacyAllow;
       srConfig.sampleRate = 100;
       [[FTRumSessionReplay sharedInstance] startWithSessionReplayConfig:srConfig];
    ```

=== "Swift"

    ```swift
       let srConfig = FTSessionReplayConfig.init()
       srConfig.privacy = .allow
       srConfig.sampleRate = 100
       FTRumSessionReplay.shared().start(with: srConfig)
    ```

| Property       | Type        | Required | Description                                                         |
| ---------- | ----------- | ---- | ------------------------------------------------------------ |
| sampleRate | int         | No   | Sampling rate. Range [0,100], 0 means no sampling, 100 means full sampling, default is 100. This sampling rate is based on the RUM sampling rate. |
| privacy    | FTSRPrivacy | No   | Set the privacy level for content masking in Session Replay. Default is `FTSRPrivacyMask`.<br/>Masking behavior: Text is replaced with * or # <br>`FTSRPrivacyAllow`: Records all content except sensitive input controls, such as password inputs<br/>`FTSRPrivacyMaskUserInput`: Masks input elements, such as `UITextField`, `UISwitch`, etc.<br/>`FTSRPrivacyMask`: Masks all content. |

## Code and Configuration References
 * [iOS Demo Cocoapod Configuration](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/Podfile#L11)
 * [iOS Demo Code Invocation](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/GuanceDemo/AppDelegate.swift#L69)