# iOS/tvOS Application Integration

---

<<< custom_key.brand_name >>> application monitoring can collect metrics data from various iOS applications and analyze the performance of each iOS application in a visualized manner.

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [accessible on the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#iOS-integration}

Log in to the <<< custom_key.brand_name >>> console, go to the **User Analysis** page, click the **[Create](../index.md#create)** button in the top-left corner to start creating a new application.

![](../img/6.rum_ios.png)

## Installation

![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=pod&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/version.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=license&color=lightgrey&query=$.license&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![](https://img.shields.io/badge/dynamic/json?label=iOS&color=brightgreen&query=$.ios_api_support&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios) ![tvOS](https://img.shields.io/badge/dynamic/json?label=tvOS&color=brightgreen&query=$.tvos_api_support&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/ios/info.json&link=https://github.com/GuanceCloud/datakit-ios)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-ios](https://github.com/GuanceCloud/datakit-ios)

**Demo**: [https://github.com/GuanceDemo/guance-app-demo](https://github.com/GuanceDemo/guance-app-demo/tree/master/src/ios/demo)

=== "CocoaPods"

    1. Configure the `Podfile`.
    
        * Using Dynamic Library
          ```
          use_frameworks!
          def shared_pods
            pod 'FTMobileSDK', '[latest_version]'
            # If widget Extension data collection is needed
            pod 'FTMobileSDK', :subspecs => ['Extension'] 
          end
    
          # Main project
          target 'yourProjectName' do
            shared_pods
          end
    
          # Widget Extension
          target 'yourWidgetExtensionName' do
            shared_pods
          end
          ```
    
        * Using Static Library
          ```
          use_modular_headers!
          # Main project
          target 'yourProjectName' do
            pod 'FTMobileSDK', '[latest_version]'
          end
          # Widget Extension
          target 'yourWidgetExtensionName' do
            pod 'FTMobileSDK', :subspecs => ['Extension'] 
          end
          ```
    
        * [Download the repository locally for use](https://guides.cocoapods.org/using/the-podfile.html#using-the-files-from-a-folder-local-to-the-machine)
          
          **`Podfile`:**
          ```
          use_modular_headers!
          # Main project
          target 'yourProjectName' do
            pod 'FTMobileSDK', :path => '[folder_path]' 
          end
          # Widget Extension
          target 'yourWidgetExtensionName' do
            pod 'FTMobileSDK', :subspecs => ['Extension'] , :path => '[folder_path]'
          end
          ```
          `folder_path`: The path to the folder containing the `FTMobileSDK.podspec` file.
    
          **`FTMobileSDK.podspec` File:**
          
          Modify `s.version` and `s.source` in the `FTMobileSDK.podspec` file.
          ```
          Pod::Spec.new do |s|
            s.name         = "FTMobileSDK"
            s.version      = "[latest_version]"  
            s.source       = { :git => "https://github.com/GuanceCloud/datakit-ios.git", :tag => s.version }
          end
          ```
          
          `s.version`: Set to the specified version, it is recommended to match the `SDK_VERSION` in `FTMobileSDK/FTMobileAgent/Core/FTMobileAgentVersion.h`.
          
          `s.source`: `tag => s.version`
    
    2. Run `pod install` in the `Podfile` directory to install the SDK.

=== "Carthage" 

    1. Configure the `Cartfile`.
        ```
        github "GuanceCloud/datakit-ios" == [latest_version]
        ```
    
    2. Update dependencies.
    
        Depending on your target platform (iOS or tvOS), execute the corresponding `carthage update` command with the `--use-xcframeworks` parameter to generate XCFrameworks:
       
        * For iOS platform:
          ```
          carthage update --platform iOS --use-xcframeworks
          ```
        
        * For tvOS platform:
          ```
          carthage update --platform tvOS --use-xcframeworks
          ```
       
        Generated xcframeworks are used similarly to ordinary frameworks. Add the compiled libraries to the project.
        
        `FTMobileAgent`: Add to the main project Target, supports iOS and tvOS platforms.
        
        `FTMobileExtension`: Add to the Widget Extension Target.
    
    3. In `TARGETS` -> `Build Setting` -> `Other Linker Flags`, add `-ObjC`.
    
    4. When using Carthage integration, the supported SDK versions are:
       
        `FTMobileAgent`: >=1.3.4-beta.2 
    
        `FTMobileExtension`: >=1.4.0-beta.1

=== "Swift Package Manager"

    1. Select `PROJECT` -> `Package Dependency`, click the **+** button under the `Packages` tab.
    
    2. Enter `https://github.com/GuanceCloud/datakit-ios.git` in the search box of the pop-up page.
    
    3. After Xcode successfully retrieves the package, it will display the SDK configuration page.
    
        `Dependency Rule`: It is recommended to choose `Up to Next Major Version`.
    
        `Add To Project`: Select the supported project.
        
        Complete the configuration and click the `Add Package` button, waiting for the loading to complete.
    
    4. In the pop-up `Choose Package Products for datakit-ios`, select the Targets that need to add the SDK, then click the `Add Package` button. At this point, the SDK has been added successfully.
    
        `FTMobileSDK`: Add to the main project Target
    
        `FTMobileExtension`: Add to the Widget Extension Target
    
        If your project is managed by SPM, add the SDK as a dependency and add `dependencies` to `Package.swift`.
    
        ```plaintext
        // Main project
        dependencies: [
            .package(name: "FTMobileSDK", url: "https://github.com/GuanceCloud/datakit-ios.git",
            .upToNextMajor(from: "[latest_version]"))]
        ```
    
    5. Support Swift Package Manager since 1.4.0-beta.1.

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
        FTMobileConfig *config = [[FTMobileConfig alloc📐📐📐
📐📐📐
📐📐📐
📐📐📐
📐📐📐
⚗