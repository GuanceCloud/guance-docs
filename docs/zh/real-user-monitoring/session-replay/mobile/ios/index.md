# iOS 会话重放

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-ios) 

## 前置条件
* 确保您已[设置并初始化 FTMobileSDK RUM 配置](../../../ios/app-access.md)，并开启 View 的监控采集。
* iOS Session Replay 目前为 alpha 功能，**版本支持：SDK.Version >= 1.6.0**

## 配置

根据您的包管理器将 `FTMobileSDK` 库中 `FTSessionReplay` 功能组件链接到您的项目：

| 包管理器                                                     | 安装步骤                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [CocoaPods](https://cocoapods.org/)                          | 添加 `pod 'FTMobileSDK/FTSessionReplay','latest_version'` 到您的 `Podfile`。需要指定 SDK 版本号。 |
| [Swift Package Manager](https://www.swift.org/package-manager/) | 添加  `FTSessionReplay`  为您的应用目标的依赖项。            |

## 代码调用 {#code_sample}

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



| 属性       | 类型        | 必须 | 含义                                                         |
| ---------- | ----------- | ---- | ------------------------------------------------------------ |
| sampleRate | int         | 否   | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。此采样率是 RUM 采样基础上的采样率。 |
| privacy    | FTSRPrivacy | 否   | 设置 Session Replay 中内容屏蔽的隐私级别。默认`FTSRPrivacyMask`。<br/>屏蔽处理：文本替换为 * 或 # <br>`FTSRPrivacyAllow`: 除了敏感输入控件外记录所有内容，例如密码输入<br/>`FTSRPrivacyMaskUserInput`:屏蔽输入元素。例如 `UITextField`、`UISwitch` 等<br>`FTSRPrivacyMask`：屏蔽所有内容。 |

## 代码和配置参考
 * [iOS Demo Cocoapod 配置](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/Podfile#L11)
 * [iOS Demo 代码调用](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/GuanceDemo/AppDelegate.swift#L69)