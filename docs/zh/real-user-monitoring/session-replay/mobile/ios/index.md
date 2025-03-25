# iOS 会话重放

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/ios/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-ios) 

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



| 属性                | 类型                       | 必须 | 含义                                                         |
| ------------------- | -------------------------- | ---- | ------------------------------------------------------------ |
| sampleRate          | int                        | 否   | 采样率。取值范围 [0,100]，0 表示不采集，100 表示全采集，默认值为 100。此采样率是 RUM 采样基础上的采样率。 |
| privacy             | FTSRPrivacy                | 否   | 设置 Session Replay 中内容屏蔽的隐私级别。默认`FTSRPrivacyMask`。<br/>屏蔽处理：文本替换为 * 或 # <br>`FTSRPrivacyAllow`: 除了敏感输入控件外记录所有内容，例如密码输入<br/>`FTSRPrivacyMaskUserInput`:屏蔽输入元素。例如 `UITextField`、`UISwitch` 等<br>`FTSRPrivacyMask`：屏蔽所有内容。<br>**已废弃，仅作为历史兼容保留，强烈建议您优先使用 `touchPrivacy` 、`textAndInputPrivacy` 进行细粒度的屏蔽隐私级别设置 ** |
| touchPrivacy        | FTTouchPrivacyLevel        | 否   | 会话重放中触控屏蔽的可用隐私级别。默认`FTTouchPrivacyLevelHide`。<br>`FTTouchPrivacyLevelShow`: 显示所有用户触控<br>`FTTouchPrivacyLevelHide`:屏蔽所有用户触控<br>**设置后将覆盖 `privacy` 的配置  **<br> SDK 1.6.1 以上版本支持这个参数 |
| textAndInputPrivacy | FTTextAndInputPrivacyLevel | 否   | 会话重放中文本和输入屏蔽的可用隐私级别。默认 `FTTextAndInputPrivacyLevelMaskAll`<br>`FTTextAndInputPrivacyLevelMaskSensitiveInputs`:显示除敏感输入外的所有文本，例如密码输入<br>`FTTextAndInputPrivacyLevelMaskAllInputs`:屏蔽所有输入字段，例如 `UITextField`、`UISwitch`、`UISlider` 等<br>`FTTextAndInputPrivacyLevelMaskAll`:屏蔽所有文本和输入<br>**设置后将覆盖 `privacy` 的配置 **<br/>SDK 1.6.1 以上版本支持这个参数 |
## 隐私覆盖

> SDK 1.6.1 以上版本支持

SDK 除了支持通过 `FTSessionReplayConfig` 配置全局屏蔽级别，还支持在视图级覆盖这些设置。

视图级隐私覆盖：

* 支持覆盖文本和输入屏蔽级别与触控屏蔽级别
* 支持设置完全隐藏特定视图

注意：

* 为了确保正确识别覆盖，应在视图生命周期中尽早应用它们。这可以防止会话重放在应用设置的覆盖之前处理视图的情况。
* 隐私覆盖会影响视图及其子视图。这意味着，即使覆盖应用于可能不会立即生效的视图（例如，将图片覆盖应用于文本输入），覆盖仍会应用于所有子视图。
* **隐私覆盖优先级：子视图 > 父视图  > 全局设置**

### 文本和输入覆盖

要覆盖文本和输入隐私，请在视图实例上使用 `sessionReplayOverrides.textAndInputPrivacy` 将其设为 `FTTextAndInputPrivacyLevelOverride` 枚举中的某个值。若需移除现有覆盖规则，直接将该属性设为 `FTTextAndInputPrivacyLevelOverrideNone` 即可。

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // 对指定视图设置文本和输入覆盖
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = FTTextAndInputPrivacyLevelOverrideMaskAll;
       // 移除视图的文本和输入覆盖设置
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTextAndInputPrivacyLevelOverrideNone;
    ```

=== "Swift"

    ```swift 
       // 对指定视图设置文本和输入覆盖
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = .maskAll
       // 移除视图的文本和输入覆盖设置
       myView.sessionReplayPrivacyOverrides.textAndInputPrivacy = .none
    ```

### 触控覆盖 {#touch_override}

要覆盖触控隐私，请在视图实例上使用 `sessionReplayOverrides.touchPrivacy` 将其设为 `FTTouchPrivacyLevelOverride` 枚举中的某个值。若需移除现有覆盖规则，直接将该属性设为 `FTTouchPrivacyLevelOverrideNone` 即可。

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // 对指定视图设置触控覆盖
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTouchPrivacyLevelOverrideShow;
       // Remove a touch override from your view
       myView.sessionReplayPrivacyOverrides.touchPrivacy = FTTouchPrivacyLevelOverrideNone;
    
    ```

=== "Swift"

    ```swift 
       // 对指定视图设置触控覆盖
       myView.sessionReplayPrivacyOverrides.touchPrivacy = .show;
       // 移除视图的触控覆盖设置
       myView.sessionReplayPrivacyOverrides.touchPrivacy = .none;
    ```

### 隐藏元素覆盖

对于需要完全隐藏的敏感元素，请使用 `sessionReplayPrivacyOverrides.hide` 进行设置。

当设置某个元素为隐藏时 ，它将在重放中被标记为 "Hidden" 的占位符替换，并且不会记录其子视图。

**注意**：将视图标记为隐藏不会阻止在该元素上记录触控交互。要隐藏触控交互，除了将元素标记为隐藏外，还要使用[触控覆盖](#touch_override)。

=== "Objective-C"

    ```objective-c
    #import <FTMobileSDK/UIView+FTSRPrivacy.h>
       // 对指定视图标记隐藏元素覆盖
       myView.sessionReplayPrivacyOverrides.hide = YES;
       // 移除视图的隐藏元素覆盖设置
       myView.sessionReplayPrivacyOverrides.hide = NO;
    ```

=== "Swift"

    ```swift 
       // 对指定视图标记隐藏元素覆盖
       myView.sessionReplayPrivacyOverrides.touchPrivacy = true;
       // 移除视图的隐藏元素覆盖设置
       myView.sessionReplayPrivacyOverrides.touchPrivacy = false;
    ```

## 代码和配置参考

 * [iOS Demo Cocoapod 配置](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/Podfile#L11)
 * [iOS Demo 代码调用](https://github.com/GuanceDemo/guance-app-demo/blob/session_replay/src/ios/demo/GuanceDemo/AppDelegate.swift#L69)