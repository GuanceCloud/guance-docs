# macOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect metrics data from various macOS applications and analyze the performance of macOS applications in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md).

## Application Integration {#macOS-integration}

Log in to the <<< custom_key.brand_name >>> console, go to the **User Analysis** page, click on **[Create Application](../index.md#create)** in the top-left corner, select **Custom**, and start creating a new application.

![](../img/image_14.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/version.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) ![](https://img.shields.io/badge/dynamic/json?label=macOS&color=brightgreen&query=$.macos_api_support&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/macos/info.json&link=https://github.com/GuanceCloud/datakit-macos) 

**Source Code**: [https://github.com/GuanceCloud/datakit-macos](https://github.com/GuanceCloud/datakit-macos)

**Demo**: [https://github.com/GuanceCloud/datakit-macos/Example](https://github.com/GuanceCloud/datakit-macos/tree/development/Example)

=== "CocoaPods"

    1. Configure the `Podfile`.
    
    ```objectivec
       target 'yourProjectName' do
    
       # Pods for your project
       pod 'FTMacOSSDK', '~>[latest_version]'
    
       end
    ```
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, then click **+** under the `Packages` tab.
    
    2. Enter `https://github.com/GuanceCloud/datakit-macos` in the search box that appears; this is the repository location.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
    `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
    `Add To Project`: Select the supported project.
    
    Click the `Add Package` button after filling in the configurations and wait for it to complete loading.
    
    4. In the pop-up window `Choose Package Products for datakit-macos`, select the Target where you want to add the SDK, and click the `Add Package` button. The SDK has now been added successfully.
    
    If your project is managed by SPM, add FTMacOSSDK as a dependency by adding `dependencies` to `Package.swift`.
    
    ```swift
      dependencies: [
        .package(url: "https://github.com/GuanceCloud/datakit-macos.git", .upToNextMajor(from: "[latest_version]"))
    ]
    ```

### Add Header Files

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

Since the `viewDidLoad` method of the first displayed view `NSViewController` and the `windowDidLoad` method of `NSWindowController` are called earlier than the `applicationDidFinishLaunching` method of AppDelegate, to avoid abnormal lifecycle collection of the first view, it is recommended to initialize the SDK in the `main.m` file.

=== "Objective-C"

    ```objectivec
    // main.m file
    #import "FTMacOSSDK.h"
    
    int main(int argc, const char * argv[]) {
        @autoreleasepool {
            // Local environment deployment, DataKit deployment
            FTSDKConfig *config = [[FTSDKConfig alloc]initWithDatakitUrl:datakitUrl];
            // Public DataWay deployment
            //FTSDKConfig *config = [[FTSDKConfig alloc📐📐📐
📐📐📐📐📐📐📐📐