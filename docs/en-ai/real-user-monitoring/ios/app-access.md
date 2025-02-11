# iOS/tvOS Application Integration

---

Guance's application monitoring can collect metrics data from various iOS applications and analyze the performance of iOS applications in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#iOS-integration}

Log in to the Guance console, go to the **User Analysis** page, click on the top-left **[Create New Application](../index.md#create)**, and start creating a new application.

![](../img/6.rum_ios.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img.shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://static.guance.com/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1. Configure the `Podfile` file.
    
    * Using Dynamic Library
    
      ```
      platform :ios, '10.0' 
      use_frameworks!
      def shared_pods
      pod 'FTMobileSDK', '[latest_version]'
      # If you need to collect widget Extension data
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
    
      // Main project
      target 'yourProjectName' do
      shared_pods
      end
    
      // Widget Extension
      target 'yourWidgetExtensionName' do
      shared_pods
      end
      ```
    
    * Using Static Library
    
      ```
      use_modular_headers!
      // Main project
      target 'yourProjectName' do
      pod 'FTMobileSDK', '[latest_version]'
      end
      // Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', '[latest_version]'
      end
      ```
    
    * [Download the repository locally for use](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
      
      **`Podfile` File**
      ```
      use_modular_headers!
      // Main project
      target 'yourProjectName' do
      pod 'FTMobileSDK', :path => '[folder_path]' 
      end
      // Widget Extension
      target 'yourWidgetExtensionName' do
      pod 'FTMobileSDK/Extension', :path => '[folder_path]'
      end
      ```
      `folder_path`: The path to the folder containing the `FTMobileSDK.podspec` file.
      **`FTMobileSDK.podspec` File**
      Modify `s.version` and `s.source` in the `FTMobileSDK.podspec` file.
      `s.version` ：Modify to the specified version, it is recommended to be consistent with `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
      `s.source`: tag => s.version
      ```
      Pod::Spec.new do |s|
      s.name         = "FTMobileSDK"
      s.version      = "[latest_version]"  
      s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
      ```
    
    2. Execute `pod install` in the `Podfile` directory to install the SDK.


=== "Carthage" 

    1. Configure the `Cartfile` file.
    
    ```
    github "GuanceCloud/datakit-ios" == [latest_version]
    ```
    
    2. Execute in the `Cartfile` directory
    
    ```bash
    carthage update --platform iOS
    ```
    
    If an error occurs "Building universal frameworks with common architectures is not possible. The device and simulator slices for "FTMobileAgent.framework" both build for: arm64" 
    
    Add the `--use-xcframeworks` parameter according to the prompt
    
    ```bash
    carthage update --platform iOS --use-xcframeworks
    ```
    
    The generated xcframework is used in the same way as ordinary Frameworks. Add the compiled library to your project.
    
    `FTMobileAgent`: Add to the main project Target
    
    `FTMobileExtension`: Add to the Widget Extension Target
    
    3. In `TARGETS` -> `Build Setting` -> `Other Linker Flags`, add `-ObjC`.
    
    4. Carthage integration supports SDK versions:
      `FTMobileAgent`: >=1.3.4-beta.2 
      `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, click the **+** under the `Packages` tab.
    
    2. Enter `https://github.com/GuanceCloud/datakit-ios.git` in the search box of the pop-up page.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
    `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
    `Add To Project`: Select the supported project.
    
    Click the `Add Package` button after filling out the configuration, wait for the loading to complete.
    
    `FTMobileSDK`: Add to the main project Target
    
    `FTMobileExtension`: Add to the Widget Extension Target
    
    If your project is managed by SPM, add the SDK as a dependency and add `dependencies` to `Package.swift`.
    
    ```plaintext
    // Main project
    dependencies: [
    .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",.upToNextMajor(from: "[latest_version]"))
    ]
    ```
    
    5. Support Swift Package Manager from 1.4.0-beta.1 and above.

### Adding Header Files

=== "Objective-C"

    ```
    // CocoaPods, SPM 
    #import "FTMobileSDK.h"
    // Carthage 
    #import <FTMobileSDK/FTMobileSDK.h>
    ```

=== "Swift"

    ```
    import FTMobileSDK
    ```

## SDK Initialization {#init}

### Basic Configuration {#base-setting}

=== "Objective-C"

    ```objective-c
    -(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
        // SDK FTMobileConfig settings
         // Local environment deployment, Datakit deployment
         //FTMobileConfig *config = [[FTMobileConfig alloc]initWithDatakitUrl:datakitUrl];
         // Use public DataWay deployment
        FTMobileConfig *config = [[FTMobileConfig alloc📐📐