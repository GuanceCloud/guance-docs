# C++ 应用接入
---
## 前置条件

- 安装 DataKit（[DataKit 安装文档](../../datakit/datakit-install.md)）

## 应用接入 {#integration}
当前 CPP 版本暂时支持 Windows 和 Linux 平台。登录观测云控制台，进入「用户访问监测」页面，点击左上角「新建应用」，即可开始创建一个新的应用。

1.输入「应用名称」、「应用ID」，选择 「自定义」 应用类型

- 应用名称：用于识别当前用户访问监测的应用名称。
- 应用 ID ：应用在当前工作空间的唯一标识，对应字段：app_id 。该字段仅支持英文、数字、下划线输入，最多 48 个字符。

![](../img/image_14.png)

## 安装 {#install}
![](https://img.shields.io/badge/dynamic/json?label=github&color=orange&query=$.version&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/version.json) ![](https://img.shields.io/badge/dynamic/json?label=cpp&color=blue&query=$.cpp_version&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=gcc&color=blue&query=$.gcc_support&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=cmake&color=blue&query=$.cmake&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json)


**源码地址**：[https://github.com/GuanceCloud/datakit-cpp](https://github.com/GuanceCloud/datakit-cpp)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-cpp/ft-sdk-sample](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk-sample/ft-sdk-sample.cpp)

=== "Windows"
	
	* vcpkg 安装
	
	```bash
	git clone https://github.com/microsoft/vcpkg
	cd vcpkg
	bootstrap-vcpkg.bat
	vcpkg install spdlog:x64-windows
	vcpkg install nlohmann-json:x64-windows
	vcpkg install restclient-cpp:x64-windows
	vcpkg install stduuid[gsl-span]:x64-windows
	vcpkg install sqlitecpp:x64-windows
	vcpkg install gtest:x64-windows
	vcpkg integrate install
	```
	
	* Visual Studio 选择`ft-sdk`项目进行生成，先生成 **动态库**，再生成 **静态库**（直接生成静态库会因为动态库确实报错），生成后检查 `datakit_sdk_redist`
	* 打包输出目录
	
	```
	├─<root dir>
	│	├─datakit_sdk_redist // 生成目录
	│	├─src
	│	├─ ...
	``` 

	* 拷贝或解压`datakit_sdk_redist`到本地安装目录。目录结构如下：

	```
	├─datakit_sdk_redist
	│  ├─include
	│  │      datakit_exports.h
	│  │      Datakit_UUID.h
	│  │      FTSDK.h
	│  │      FTSDKConfig.h
	│  │      FTSDKDataContracts.h
	│  │      FTSDKFactory.h
	│  │
	│  └─lib
	│      └─win64
	│              fmt.dll
	│              ft-sdkd.dll          //动态库
	│              ft-sdkd.lib
	│              ft-sdkd_static.lib	  // 静态库
	│              libcurl.dll
	│              sqlite3.dll
	│              zlib1.dll
	
	```
	
	* 打开引用项目的工程属性，添加头文件路径。（以下的 datakit_sdk_redist 目录需替换成本地实际安装路径）
	![](../img/rum_cpp_1.png)
	
	* 添加库文件路径
	![](../img/rum_cpp_2.png)
	
	* 添加库文件引用
	![](../img/rum_cpp_3.png)
	
	* 设置c++标准
	![](../img/rum_cpp_4.png)
	
	* 设置动态库自动拷贝
	![](../img/rum_cpp_5.png)

=== "Linux"
	
	* vcpkg 安装
	
	```bash
	git clone https://github.com/microsoft/vcpkg
	
	#apt install ninja-build
	#apt install pkg-config
	
	./vcpkg/bootstrap-vcpkg.sh
	cd vcpkg
	# 如果是 arm 64 需要添加 VCPKG_FORCE_SYSTEM_BINARIES
	#export VCPKG_FORCE_SYSTEM_BINARIES=1
	./vcpkg install spdlog
	./vcpkg install nlohmann-json
	./vcpkg install restclient-cpp
	./vcpkg install stduuid[gsl-span]
	./vcpkg install sqlitecpp
	./vcpkg install gtest
	export VCPKG_ROOT= [ your_vcpkg_dir ]
	
	```
	
	* 创建生成目录：mkdir build;cd build
	* 生成 Makefile：cmake ..
	* 编译打包：make install
	* 打包输出目录
	
	```
	├─<root dir>
	│	├─datakit_sdk_redist // 生成目录
	│	├─src
	│	├─ ...
	``` 
	
	* 拷贝或解压`datakit_sdk_redist`到本地目录，目录结构如下：
	
	```
	./datakit_sdk_redist/
	├── include
	│   ├── datakit_exports.h
	│   ├── Datakit_UUID.h
	│   ├── FTSDKConfig.h
	│   ├── FTSDKDataContracts.h
	│   ├── FTSDKFactory.h
	│   └── FTSDK.h
	├── install.sh
	└── lib
	    └── x86_64
	        ├── libft-sdk.a
	      	     └── libft-sdk.so
	```
	
	* sudo chmod 777 datakit_sdk_redist/install.sh
	* cd datakit_sdk_redist
	* ./install.sh

## 初始化
```cpp
auto sdk = FTSDKFactory::get("ft_sdk_config.json");
sdk->init();

FTSDKConfig gc;
gc.setServerUrl("http://10.0.0.1:9529")
    .setEnv(EnvType::PROD)
    .addGlobalContext("custom_key","custom_value")
    .setEnableFileDBCache(true);
sdk->install(gc)

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setServerUrl | string | 是 | datakit 安装地址 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529。注意：安装 SDK 设备需能访问这地址 |
| setEnv | enum | 否 | 环境，默认`EnvType::PROD` |
| setAppVersion | enum | 否 | windows 会默认获取，linux 系统需要自行赋值 |
| setEnableFileDBCache | Bool | 否 | 是否开启本地数据库，默认为 false|
| addGlobalContext | dictionary | 否 | 添加 SDK 全局属性，添加规则请查阅[此处](#key-conflict)|
| setServiceName|设置服务名|否|影响 Log 和 RUM 中 service 字段数据， 默认为 windows 为`df_rum_windows`，linux 为 `df_rum_linux` |

### RUM 配置
```cpp
FTRUMConfig rc;
rc.setRumAppId("appid_xxxx");
sdk->initRUMWithConfig(rc);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setRumAppId | string | 是 | 对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#integration) |
| setSamplingRate | float | 否 | 采集率的值范围为>= 0、<= 1，默认值为 1 |
| addGlobalContext | dictionary | 否 | 添加标签数据，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值。添加规则请查阅 [此处](#key-conflict) |

### Log 配置
```cpp
FTLogConfig lpc;
//std::vector<LogLevel> llf;
//llf.push_back(LogLevel::ERR);
lpc.setLogLevelFilters(llf);
lpc.setEnableCustomLog(true)
    .setEnableLinkRumData(true);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setSamplingRate | float | 否 | 采集率的值范围为>= 0、<= 1，默认值为 1 |
| addGlobalContext | dictionary | 否 | 添加标签数据，添加规则请查阅 [此处](#key-conflict)  |
| setLogLevelFilters | array | 否 | 设置等级日志过滤，默认不设置 |
| setEnableCustomLog | bool | 否 | 是否上传自定义日志 ，默认为 false |

### Trace 配置
```cpp
FTTraceConfig tc;
tc.setTraceType(TraceType::DDTRACE)
   .setEnableLinkRUMData(true);
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setSamplingRate | float | 否 | 采集率的值范围为>= 0、<= 1，默认值为 1 |
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
```

### Resource
#### 使用方法
```cpp
/**
 * 设置网络传输内容
 * 
 * @param resourceId		资源 Id
 * @param params			网络传输参数
 * @param netStatusBean		网络状态统计
 */
void addResource(std::string resourceId, ResourceParams params, NetStatus netStatusBean);
	
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