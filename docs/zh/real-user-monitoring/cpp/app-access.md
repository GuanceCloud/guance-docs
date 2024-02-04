# C++ 应用接入
---
## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入 {#integration}

当前 CPP 版本暂时支持 Windows 和 Linux 平台。登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。


![](../img/image_14.png)

## 安装 {#install}
![](https://img.shields.io/badge/dynamic/json?label=github&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/cpp/version.json) ![](https://img.shields.io/badge/dynamic/json?label=cpp&color=blue&query=$.cpp_version&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=gcc&color=blue&query=$.gcc_support&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=cmake&color=blue&query=$.cmake&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/cpp/info.json)


**源码地址**：[https://github.com/GuanceCloud/datakit-cpp](https://github.com/GuanceCloud/datakit-cpp)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-cpp/ft-sdk-sample](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk-sample/ft-sdk-sample.cpp)


=== "Windows"
	
	```bash
	
	git clone https://github.com/microsoft/vcpkg
	cd vcpkg
	
	#下载自定义配置 registries 文件
	curl -o vcpkg-configuration.json https://static.guance.com/ft-sdk-package/vcpkg_config/vcpkg-configuration.json 
	
	bootstrap-vcpkg.bat
	vcpkg install datakit-sdk-cpp:x64-windows
	vcpkg integrate install
	```

=== "Linux"
	
	```bash
	
	git clone https://github.com/microsoft/vcpkg
	
	#apt install ninja-build
	#apt install pkg-config
	
	./vcpkg/bootstrap-vcpkg.sh
	cd vcpkg
	
	#下载自定义配置 registries 文件
	curl -o vcpkg-configuration.json https://static.guance.com/ft-sdk-package/vcpkg_config/vcpkg-configuration.json 
	
	# 如果是 arm 64 需要添加 VCPKG_FORCE_SYSTEM_BINARIES
	#export VCPKG_FORCE_SYSTEM_BINARIES=1
	
	./vcpkg install datakit-sdk-cpp:x64-linux
	
	# 在编译环境中，引用 VCPKG_ROOT 变量
	export VCPKG_ROOT= [ your_vcpkg_root_dir ]
	
	```
	
	添加 CMake 配置
	
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
	
	#添加观测云 SDK 引用
	find_path(FT-SDK_INCLUDE_DIR datakit-sdk-cpp/FTSDK.h)
	find_library(FT-SDK_LIBRARY ft-sdk "${FT-SDK_INCLUDE_DIR}/../lib/")
	include_directories(${FT-SDK_INCLUDE_DIR})
	
	file(GLOB PROJECT_SOURCE "*.cpp")
	file(GLOB PROJECT_HEADER "../include/*.h" "*.h")
	
	add_executable (${PROJECT_NAME} ${PROJECT_SOURCE} ${PROJECT_HEADER})
	
	#链接 SDK
	target_link_libraries(${PROJECT_NAME} PRIVATE ${FT-SDK_LIBRARY})

	```
		
## 引用头

```cpp
#include "datakit-sdk-cpp/FTSDKFactory.h"
```	

## 初始化
```cpp
auto sdk = FTSDKFactory::get();
sdk->init();
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| FTSDKFactory::get | string | 否 | 指定配置文件，默认为 `ft_sdk_config.json`| 

### 启动 json 文件配置
可以通过 `FTSDKFactory` 配置 `json` 文件启动 SDK 调试日志

```json
{    
    "general_config": {
        "enable_sdk_log": true  // 开启 debug 日志，默认关闭
    }
}
```

### 全局配置

```cpp
FTSDKConfig gc;
gc.setServerUrl("http://10.0.0.1:9529")
    .setEnv(EnvType::PROD)
    .addGlobalContext("custom_key","custom_value")
    .setEnableFileDBCache(true);
sdk->install(gc)

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setServerUrl | string | 是 | datakit 访问 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529。注意：安装 SDK 设备需能访问这地址 |
| setEnv | enum | 否 | 环境配置，默认`EnvType::PROD` |
| setAppVersion | enum | 否 | windows 会默认获取，linux 系统需要自行赋值 |
| setEnableFileDBCache | Bool | 否 | 是否开启本地数据库，默认为 false|
| addGlobalContext | dictionary | 否 | 添加 SDK 全局属性，添加规则请查阅[此处](#key-conflict)|
| setServiceName| string |否|影响 Log 和 RUM 中 service 字段数据， 默认为 windows 为`df_rum_windows`，linux 为 `df_rum_linux` |

### RUM 配置
```cpp
FTRUMConfig rc;
rc.setRumAppId("appid_xxxx");
sdk->initRUMWithConfig(rc);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setRumAppId | string | 是 | 对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#integration) |
| setSamplingRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据 |
| setExtraMonitorTypeWithError | ErrorMonitorType | 否 |添加附加监控数据到 `Rum` 崩溃数据中，`ErrorMonitorType::MEMORY` 为内存用量，`ErrorMonitorType::CPU` 为 CPU 占有率，`ErrorMonitorType::ALL` 为全部 |
| addGlobalContext | dictionary | 否 | 添加标签数据，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值。添加规则请查阅 [此处](#key-conflict) |

### Log 配置
```cpp
FTLogConfig lpc;
//std::vector<LogLevel> llf;
//llf.push_back(LogLevel::ERR);
//lpc.setLogLevelFilters(llf);
lpc.setEnableCustomLog(true)
    .setEnableLinkRumData(true);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setSamplingRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。 |
| addGlobalContext | dictionary | 否 | 添加标签数据，添加规则请查阅 [此处](#key-conflict)  |
| setLogLevelFilters | array | 否 | 设置等级日志过滤，默认不设置 |
| setEnableCustomLog | bool | 否 | 是否上传自定义日志 ，默认为 `false` |
| setEnableLinkRUMData | bool | 否 | 是否与 RUM 数据关联，默认为 `false` |
| setLogCacheDiscardStrategy | LogCacheDiscard | 否 | 默认为 `LogCacheDiscard::DISCARD`，`DISCARD` 为丢弃追加数据，`DISCARD_OLDEST` 丢弃老数据  |

### Trace 配置
```cpp
FTTraceConfig tc;
tc.setTraceType(TraceType::DDTRACE)
   .setEnableLinkRUMData(true);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setSamplingRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。|
| setTraceType | enum | 否 | 默认为 `DDTrace`，目前支持 `Zipkin` , `Jaeger`, `DDTrace`，`Skywalking` (8.0+)，`TraceParent` (W3C)，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置  |
| setEnableLinkRUMData | bool | 否 | 是否与 RUM 数据关联，默认为 `false` |

## RUM 用户数据追踪
目前只能通过手动方法调用来实现 RUM 数据传输

### Action
#### 使用方法
```cpp
/**	
 * action 开始
 * 
 * @param actionName action 名称
 * @param actionType action 类型
 */
void startAction(std::string actionName, std::string actionType);


/**
 * action结束
 * 
 */
void stopAction();
		
```

#### 代码示例
```cpp
sdk->startAction("just4test", "click");
```

### View
#### 使用方法
```cpp
/**
 * view 开始.
 * 
 * @param viewName 当前页面名称
 */
void startView(std::string viewName);

/**
 * view 结束.
 * 
 */
void stopView();
```

#### 代码示例

```cpp
sdk->startView("TEST_VIEW_ONE");

sdk->stopView();
```

### Resource
#### 使用方法
```cpp
	
/**
 * resource 起始
 * 
 * @param resourceId		资源 Id
 */
void startResource(std::string resourceId);
	
/**
 * resource 终止
 * 
 * @param resourceId 资源 Id
 */
void stopResource(std::string resourceId);


/**
 * 设置网络传输内容
 * 
 * @param resourceId		资源 Id
 * @param params			网络传输参数
 * @param netStatusBean		网络状态统计
 */
void addResource(std::string resourceId, ResourceParams params, NetStatus netStatusBean);

```

| **方法名** | **含义** | **必须** | **说明** |
| --- | --- | --- | --- |
| NetStatus.fetchStartTime | 请求开始时间 | 否 | |
| NetStatus.tcpTime | tcp 连接耗时 | 否 |  |
| NetStatus.dnsTime | dns 解析时间 | 否 |  |
| NetStatus.responseTime | 响应内容传输耗时 | 否 |  |
| NetStatus.sslTime | ssl 链接耗时| 否 |  |
| NetStatus.firstByteTime | ssl dns 解析到接收到第一个数据包的总时| 否 |  |
| NetStatus.ttfb | 请求响应时间，开始发送请求到接收到响应首包的时长| 否 |  |
| NetStatus.tcpStartTime | tcp 连接时间 | 否 |  |
| NetStatus.tcpEndTime | tcp 结束时间 | 否 |  |
| NetStatus.dnsStartTime | dns 开始时间 | 否 |  |
| NetStatus.dnsEndTime | dns 结束时间 | 否 |  |
| NetStatus.responseStartTime | 响应开始时间 | 否 |  |
| NetStatus.responseEndTime | 响应结束时间 | 否 |  |
| NetStatus.sslStartTime | ssl 开始时间 | 否 |  |
| NetStatus.sslEndTime | ssl 结束时间 | 否 |  |
| ResourceParams.url | url 地址 | 是 |  |
| ResourceParams.requestHeader | 请求头参数 | 否 |  |
| ResourceParams.responseHeader | 响应头参数 | 否 |  |
| ResourceParams.responseConnection | 响应  connection | 否 |  |
| ResourceParams.responseContentType | 响应  ContentType | 否 |  |
| ResourceParams.responseContentEncoding | 响应  ContentEncoding | 否 |  |
| ResourceParams.resourceMethod | 请求方法 | 否 |  GET,POST 等 |
| ResourceParams.responseBody | 返回 body 内容 | 否 |  |

#### 代码示例
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
#### 使用方法
```cpp
/**
 * 添加错误信息
 * 
 * @param log		日志
 * @param message	消息
 * @param errorType	错误类型
 * @param state		程序运行状态
 */
void addError(std::string log, std::string message, RUMErrorType errorType, AppState state);
```

#### 代码示例

```cpp
sdk->addError("test error 1", "first error", RUMErrorType::native_crash, AppState::UNKNOWN);
sdk->addError("test error 2", "second error", RUMErrorType::network_error, AppState::UNKNOWN);
```

### LongTask
#### 使用方法

```cpp
/**
 * 添加长耗时任务
 * 
 * @param log		日志
 * @param duration	持续时间(ns)
 */
void addLongTask(std::string log, long duration);
```

#### 代码示例

```cpp
sdk->addLongTask("test long task", 100010);
```

## Log 日志打印
### 使用方法
```cpp
/**
  * 上传用户日志到datakit
  * @param content	日志内容
  * @param level		日志级别
  */
void addLog(std::string content, LogLevel level);
```

### 代码示例
```cpp
sdk->addLog("this\\is a \"test\" log", LogLevel::info);
```

## Tracer 网络链路追踪
链路通过生成 Trace Header，然后通过将 Header 添加到 http 请求头上来实现链路功能

### 使用方法
```cpp
/**
 * 按配置生成trace header
 * 
 * @param url	网络地址
 * @return		trace数据
 */
PropagationHeader generateTraceHeader(const std::string url);
```

### 代码示例
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

## 用户信息绑定与解绑
### 使用方法

```cpp 
/**
 * 绑定用户数据
 * 
 * @param config	用户数据
 * @return
 */
FTSDK&& bindUserData(UserData& config);
		
/**
 * 解绑用户数据
 *
 */
void unbindUserData();

```
### 代码示例
```cpp 
//绑定用户数据
UserData uc;
uc.init("username", "1001", "someone@email.com");
uc.addCustomizeItem("ft_key", "ft_value");
sdk->bindUserData(uc);
    
//解绑用户数据
sdk->unbindUserData();
```

## 关闭 SDK
```cpp
/**
 * 关闭SDK，执行相关资源清理操作 
 */
sdk->deinit();

```


## 常见问题 {#FAQ}
### 添加局变量避免冲突字段 {#key-conflict}

为了避免自定义字段与 SDK 数据冲突，建议标签命名添加 **项目缩写** 的前缀，例如 `df_tag_name`，项目中使用 `key` 值可[查询源码](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk/FTSDKConstants.h)。SDK 全局变量中出现与 RUM、Log 相同变量时，RUM、Log 会覆盖 SDK 中的全局变量。
