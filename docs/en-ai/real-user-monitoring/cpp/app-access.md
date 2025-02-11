# C++ Application Integration
---
## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [publicly accessible and has the IP geolocation database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration {#integration}

The current CPP version supports Windows and Linux platforms. Log in to the Guance console, go to the **User Access Monitoring** page, click on the top-left **[Create Application](../index.md#create)**, and start creating a new application.

![](../img/image_14.png)

## Installation {#install}
![](https://img.shields.io/badge/dynamic/json?label=github&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/cpp/version.json) ![](https://img.shields.io/badge/dynamic/json?label=cpp&color=blue&query=$.cpp_version&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=gcc&color=blue&query=$.gcc_support&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=cmake&color=blue&query=$.cmake&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-cpp](https://github.com/GuanceCloud/datakit-cpp)

**Demo Repository**: [https://github.com/GuanceCloud/datakit-cpp/ft-sdk-sample](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk-sample/ft-sdk-sample.cpp)

=== "Windows"

	```bash
	git clone https://github.com/microsoft/vcpkg
	cd vcpkg
	
	# Download custom configuration registries file
	curl -o vcpkg-configuration.json https://static.guance.com/ft-sdk-package/vcpkg_config/vcpkg-configuration.json 
	
	bootstrap-vcpkg.bat
	vcpkg install datakit-sdk-cpp:x64-windows
	vcpkg integrate install
	```

=== "Linux"

	```bash
	git clone https://github.com/microsoft/vcpkg
	
	# apt install ninja-build
	# apt install pkg-config
	
	./vcpkg/bootstrap-vcpkg.sh
	cd vcpkg
	
	# Download custom configuration registries file
	curl -o vcpkg-configuration.json https://static.guance.com/ft-sdk-package/vcpkg_config/vcpkg-configuration.json 
	
	# If it's arm64, add VCPKG_FORCE_SYSTEM_BINARIES
	# export VCPKG_FORCE_SYSTEM_BINARIES=1
	
	./vcpkg install datakit-sdk-cpp:x64-linux
	
	# In the compilation environment, reference the VCPKG_ROOT variable
	export VCPKG_ROOT=[your_vcpkg_root_dir]
	```
	
	Add CMake Configuration
	
	```
	cmake_minimum_required(VERSION 3.0)

	project(ft-sdk-reference-sample VERSION 1.0.0 LANGUAGES CXX C)
	
	add_definitions(-fPIC -g -Werror=return-type)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -O1 -ftree-vectorize -ffast-math ")
	set(CMAKE_CXX_STANDARD 17)
	
	if(DEFINED ENV{VCPKG_ROOT})
	if (EXISTS "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
	    include ("$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
	  set(VCPKG_CMAKE_SHARE "$ENV{VCPKG_ROOT}/installed/${VCPKG_TARGET_TRIPLET}/share"
	      CACHE STRING "TEST")
	endif ()
	else ()
	message(STATUS "please set the system environment variable : VCPKG_ROOT" $ENV{VCPKG_ROOT})
	endif ()
	
	# Add Guance SDK reference
	find_path(FT-SDK_INCLUDE_DIR datakit-sdk-cpp/FTSDK.h)
	find_library(FT-SDK_LIBRARY ft-sdk "${FT-SDK_INCLUDE_DIR}/../lib/")
	include_directories(${FT-SDK_INCLUDE_DIR})
	
	file(GLOB PROJECT_SOURCE "*.cpp")
	file(GLOB PROJECT_HEADER "../include/*.h" "*.h")
	
	add_executable (${PROJECT_NAME} ${PROJECT_SOURCE} ${PROJECT_HEADER})
	
	# Link SDK
	target_link_libraries(${PROJECT_NAME} PRIVATE ${FT-SDK_LIBRARY})

	```
		
## Header Reference

```cpp
#include "datakit-sdk-cpp/FTSDKFactory.h"
```	

## Initialization
```cpp
auto sdk = FTSDKFactory::get();
sdk->init();
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| FTSDKFactory::get | string | No | Specifies the configuration file, default is `ft_sdk_config.json` |

### Starting JSON Configuration
You can configure the SDK debug logs via the `json` file using `FTSDKFactory`.

```json
{    
    "general_config": {
        "enable_sdk_log": true  // Enable debug logs, default is off
    }
}
```

### Global Configuration

```cpp
FTSDKConfig gc;
gc.setServerUrl("http://10.0.0.1:9529")
    .setEnv(EnvType::PROD)
    .addGlobalContext("custom_key","custom_value")
    .setEnableFileDBCache(true);
sdk->install(gc)
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setServerUrl | string | Yes | DataKit access URL, example: http://10.0.0.1:9529, default port is 9529. **Note: The device installing the SDK must be able to access this address** |
| setEnv | enum | No | Environment configuration, default is `EnvType::PROD` |
| setAppVersion | enum | No | Automatically retrieved for Windows, needs to be set manually for Linux |
| setEnableFileDBCache | Bool | No | Whether to enable local database, default is false |
| addGlobalContext | dictionary | No | Adds global attributes to the SDK, refer to [here](#key-conflict) for rules |
| setServiceName | string | No | Affects the `service` field data in Logs and RUM, defaults to `df_rum_windows` for Windows and `df_rum_linux` for Linux |

### RUM Configuration
```cpp
FTRUMConfig rc;
rc.setRumAppId("appid_xxxx");
sdk->initRUMWithConfig(rc);
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setRumAppId | string | Yes | Corresponds to the RUM `appid`, required to enable RUM collection, see [how to get appid](#integration) |
| setSamplingRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1. Applies to all View, Action, LongTask, Error data under the same session_id |
| setExtraMonitorTypeWithError | ErrorMonitorType | No | Adds additional monitoring data to RUM crash data, e.g., `ErrorMonitorType::MEMORY` for memory usage, `ErrorMonitorType::CPU` for CPU usage, `ErrorMonitorType::ALL` for all |
| addGlobalContext | dictionary | No | Adds label data for user monitoring data source differentiation; if tracking is needed, use `track_id` as key and any value. Refer to [here](#key-conflict) for rules |

### Log Configuration
```cpp
FTLogConfig lpc;
//std::vector<LogLevel> llf;
//llf.push_back(LogLevel::ERR);
//lpc.setLogLevelFilters(llf);
lpc.setEnableCustomLog(true)
    .setEnableLinkRumData(true);
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setSamplingRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| addGlobalContext | dictionary | No | Adds label data, refer to [here](#key-conflict) for rules |
| setLogLevelFilters | array | No | Sets log level filters, default is none |
| setEnableCustomLog | bool | No | Whether to upload custom logs, default is `false` |
| setEnableLinkRUMData | bool | No | Whether to link with RUM data, default is `false` |
| setLogCacheDiscardStrategy | LogCacheDiscard | No | Default is `LogCacheDiscard::DISCARD`, options are `DISCARD` (discard appended data), `DISCARD_OLDEST` (discard oldest data) |

### Trace Configuration
```cpp
FTTraceConfig tc;
tc.setTraceType(TraceType::DDTRACE)
   .setEnableLinkRUMData(true);
```

| **Field** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| setSamplingRate | float | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default is 1 |
| setTraceType | enum | No | Default is `DDTrace`, currently supports `Zipkin`, `Jaeger`, `DDTrace`, `Skywalking` (8.0+), `TraceParent` (W3C). For OpenTelemetry integration, check supported types and agent configurations |
| setEnableLinkRUMData | bool | No | Whether to link with RUM data, default is `false` |

## RUM User Data Tracking
Currently, RUM data transmission can only be achieved through manual method calls.

### Action
#### Usage
```cpp
/**	
 * Start an action
 * 
 * @param actionName Action name
 * @param actionType Action type
 */
void startAction(std::string actionName, std::string actionType);

/**
 * End an action
 * 
 */
void stopAction();
```

#### Code Example
```cpp
sdk->startAction("just4test", "click");
```

### View
#### Usage
```cpp
/**
 * Start a view.
 * 
 * @param viewName Current page name
 */
void startView(std::string viewName);

/**
 * End a view.
 * 
 */
void stopView();
```

#### Code Example

```cpp
sdk->startView("TEST_VIEW_ONE");

sdk->stopView();
```

### Resource
#### Usage
```cpp
/**
 * Start a resource
 * 
 * @param resourceId Resource ID
 */
void startResource(std::string resourceId);

/**
 * Stop a resource
 * 
 * @param resourceId Resource ID
 */
void stopResource(std::string resourceId);

/**
 * Set network transmission content
 * 
 * @param resourceId Resource ID
 * @param params Network transmission parameters
 * @param netStatusBean Network status statistics
 */
void addResource(std::string resourceId, ResourceParams params, NetStatus netStatusBean);
```

| **Method Name** | **Meaning** | **Required** | **Description** |
| --- | --- | --- | --- |
| NetStatus.fetchStartTime | Request start time | No | |
| NetStatus.tcpTime | TCP connection time | No | |
| NetStatus.dnsTime | DNS resolution time | No | |
| NetStatus.responseTime | Response content transfer time | No | |
| NetStatus.sslTime | SSL connection time | No | |
| NetStatus.firstByteTime | Total time from DNS resolution to receiving the first packet | No | |
| NetStatus.ttfb | Time from sending request to receiving the first response packet | No | |
| NetStatus.tcpStartTime | TCP connection start time | No | |
| NetStatus.tcpEndTime | TCP connection end time | No | |
| NetStatus.dnsStartTime | DNS start time | No | |
| NetStatus.dnsEndTime | DNS end time | No | |
| NetStatus.responseStartTime | Response start time | No | |
| NetStatus.responseEndTime | Response end time | No | |
| NetStatus.sslStartTime | SSL start time | No | |
| NetStatus.sslEndTime | SSL end time | No | |
| ResourceParams.url | URL address | Yes | |
| ResourceParams.requestHeader | Request header parameters | No | |
| ResourceParams.responseHeader | Response header parameters | No | |
| ResourceParams.responseConnection | Response connection | No | |
| ResourceParams.responseContentType | Response ContentType | No | |
| ResourceParams.responseContentEncoding | Response ContentEncoding | No | |
| ResourceParams.resourceMethod | Request method | No | GET, POST, etc. |
| ResourceParams.responseBody | Response body content | No | |

#### Code Example
```cpp
RestClient::init();
RestClient::Connection* conn = new RestClient::Connection(url);

RestClient::HeaderFields headers;
headers["Accept"] = "application/json";

RestClient::Response r = conn->get("/get");

RestClient::Connection::Info info = conn->GetInfo();

params.resourceMethod = "GET";
params.requestHeader = convert(headers);
params.responseHeader = convert(r.headers);

ResourceParams params;
params.responseBody = r.body;
params.responseConnection = "Keep-Alive";
params.responseContentEncoding = "UTF-8";
params.responseContentType = r.headers["Content-Type"];
params.url = url;
params.resourceStatus = r.code;

NetStatus status;
status.dnsTime = info.lastRequest.nameLookupTime * ns_factor;
status.tcpTime = (info.lastRequest.connectTime - info.lastRequest.nameLookupTime ) * ns_factor;
status.sslTime = (info.lastRequest.appConnectTime - info.lastRequest.connectTime) * ns_factor;
status.ttfb = (info.lastRequest.startTransferTime - info.lastRequest.preTransferTime) * ns_factor;
status.responseTime = (info.lastRequest.totalTime -info.lastRequest.startTransferTime) * ns_factor;
status.firstByteTime = info.lastRequest.startTransferTime * ns_factor;
    
RestClient::disable();
```

### Error
#### Usage
```cpp
/**
 * Add error information
 * 
 * @param log Log message
 * @param message Error message
 * @param errorType Error type
 * @param state Program state
 */
void addError(std::string log, std::string message, RUMErrorType errorType, AppState state);
```

#### Code Example

```cpp
sdk->addError("test error 1", "first error", RUMErrorType::native_crash, AppState::UNKNOWN);
sdk->addError("test error 2", "second error", RUMErrorType::network_error, AppState::UNKNOWN);
```

### LongTask
#### Usage

```cpp
/**
 * Add a long-running task
 * 
 * @param log Log message
 * @param duration Duration (in nanoseconds)
 */
void addLongTask(std::string log, long duration);
```

#### Code Example

```cpp
sdk->addLongTask("test long task", 100010);
```

## Log Logging
### Usage
```cpp
/**
  * Upload user log to DataKit
  * @param content Log content
  * @param level Log level
  */
void addLog(std::string content, LogLevel level);
```

### Code Example
```cpp
sdk->addLog("this\\is a \"test\" log", LogLevel::info);
```

## Tracer Network Tracing
Tracing is implemented by generating Trace Headers and adding them to HTTP request headers.

### Usage
```cpp
/**
 * Generate trace header based on configuration
 * 
 * @param url Network address
 * @return Trace data
 */
PropagationHeader generateTraceHeader(const std::string url);
```

### Code Example
```cpp
RestClient::init();
RestClient::Connection* conn = new RestClient::Connection(url);

RestClient::HeaderFields headers;
headers["Accept"] = "application/json";

auto headerWithRes = pSDK->generateTraceHeader(resId, url);
for (auto& hd : headerWithRes)
{
    headers[hd.first] = hd.second;
}
conn->SetHeaders(headers);

RestClient::Response r = conn->get("/get");
RestClient::disable();
```

## Binding and Unbinding User Data
### Usage

```cpp 
/**
 * Bind user data
 * 
 * @param config User data
 * @return
 */
FTSDK&& bindUserData(UserData& config);
		
/**
 * Unbind user data
 *
 */
void unbindUserData();
```
### Code Example
```cpp 
// Bind user data
UserData uc;
uc.init("username", "1001", "someone@email.com");
uc.addCustomizeItem("ft_key", "ft_value");
sdk->bindUserData(uc);
    
// Unbind user data
sdk->unbindUserData();
```

## Closing the SDK
```cpp
/**
 * Close the SDK and perform cleanup operations 
 */
sdk->deinit();
```

## Common Issues {#FAQ}
### Adding Prefixes to Avoid Conflicting Fields {#key-conflict}

To avoid conflicts between custom fields and SDK data, it is recommended to prefix tag names with the **project abbreviation**, such as `df_tag_name`. For more details on key values used in the project, you can [refer to the source code](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk/FTSDKConstants.h). If global variables in the SDK conflict with RUM or Log variables, RUM or Log will override the SDK's global variables.