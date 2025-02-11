# macOS Application Integration

---

Guance application monitoring can collect metrics data from various macOS applications and analyze the performance of macOS applications in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md).

## Application Integration {#macOS-integration}

Log in to the Guance console, go to the **User Access Monitoring** page, click the **[Create New Application](../index.md#create)** in the top-left corner, choose **Custom**, and start creating a new application.

![](../img/image_14.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.guance.com/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**Source Code Location**: [https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**: [https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1. Configure the `Podfile` file.
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, then click **+** under the `Packages` tab.
    
    2. Enter `https://github.com/GuanceCloud/datakit-macos` in the search box that appears; this is the repository location for the code.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
    `Dependency Rule`: It is recommended to select `Up to Next Major Version`.
    
    `Add To Project`: Choose the supported project.
    
    Click the `Add Package` button after configuring. Wait for the loading to complete.
    
    4. In the pop-up `Choose Package Products for datakit-macos`, select the Target where you need to add the SDK, then click the `Add Package` button. The SDK is now added successfully.
    
    If your project is managed by SPM, add FTMacOSSDK as a dependency by adding `dependencies` to `Package.swift`.
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### Adding Header Files

=== "Objective-C"

    ```
    #import "FTMacOSSDK.h"
    ```

=== "Swift"

    ```swift
    import FTMacOSSDK
    ```

## SDK Initialization

### Basic Configuration {#base-setting}

Since the `viewDidLoad` method of the first displayed view `NSViewController` and the `windowDidLoad` method of `NSWindowController` are called earlier than the `applicationDidFinishLaunching` method of AppDelegate, to avoid lifecycle collection anomalies of the first view, it is recommended to initialize the SDK in the `main.m` file.

=== "Objective-C"

    ```objectivec
    // main.m file
    #import "FTMacOSSDK.h"
    
    int main(int argc, const char * argv[]) {
        @autoreleasepool {
            // Local environment deployment, Datakit deployment
            FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatakitUrl:datakitUrl];
            // Public DataWay deployment
            //FTSDKConfig *config = [[FTSDKConfig alloc📐📐
📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐📐