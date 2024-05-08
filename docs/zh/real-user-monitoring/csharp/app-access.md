# C# 应用接入
---
## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入 {#integration}
当前 C# 版本暂时支持 Windows 和 Linux 平台。登录观测云控制台，进入「用户访问监测」页面，点击左上角「新建应用」，即可开始创建一个新的应用。

1.输入「应用名称」、「应用ID」，选择 「自定义」 应用类型

- 应用名称：用于识别当前用户访问监测的应用名称。
- 应用 ID ：应用在当前工作空间的唯一标识，对应字段：app_id 。该字段仅支持英文、数字、下划线输入，最多 48 个字符。

![](../img/image_14.png)

## 安装 {#install}

- 安装 [C++ SDK](../cpp/app-access.md#install)
- 使用 C# [FTWrapper.cs](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk-wrapper-sample/FTWrapper.cs) 
-  调整 dll FTWrapper.cs 路径	

```csharp
//class FTWrapper.cs

const string dllName = "C:\\{vcpkg_root}\\vcpkg\\installed\\{platform}\\bin\\ft-sdk.dll";

[DllImport(dllName)]
public static extern void Install(string jsonConfig);
...

```

`vcpkg_root`为 `vcpkg` 安装目录，`platform` 为 CPU 架构与操作系统，例如：`x64-windows`

## 初始化
```csharp
FTWrapper.Install(@"
{
    ""serverUrl"": ""http://10.0.0.1:9529"",
    ""envType"": ""prod"",
    ""serviceName"": ""Your Services"",
    ""globalContext"": {
        ""custom_key"": ""custom value""
    }
}");

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| serverUrl | string | 是 | datakit 安装地址 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529。**注意：安装 SDK 设备需能访问这地址** |
| envType | enum | 否 | 环境配置，默认`prod` |
| appVersion | enum | 否 | windows 会默认获取，linux 系统需要自行赋值 |
| enableFileDBCache | bool | 否 | 是否开启本地数据库，默认为 false|
| globalContext | dictionary | 否 | 添加 SDK 全局属性，添加规则请查阅[此处](#key-conflict)|
| serviceName| string |否|影响 Log 和 RUM 中 service 字段数据， 默认为 windows 为`df_rum_windows`，linux 为 `df_rum_linux` |

### 启动 json 文件配置
配置 `json` 文件启动 SDK 调试日志，应用执行同一级目录

```json
{    
    "general_config": {
        "enable_sdk_log": true  // 开启 debug 日志，默认关闭
    }
}
```

### RUM 配置
```csharp
FTWrapper.InitRUMConfig(@"
{
    ""appId"": ""appid_win_xxxxxx"",
    ""sampleRate"": 0.8,
    ""globalContext"": {
        ""rum_custom"": ""rum custom value""
    }
}");
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| appId | string | 是 | 对应设置 RUM `appid`，才会开启`RUM`的采集功能，[获取 appid 方法](#integration) |
| sampleRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据|
| extraMonitorTypeWithError | string | 否 | 添加附加监控数据到 `Rum` 崩溃数据中，`memory` 为内存用量，`cpu` 为 CPU 占有率，`all` 为全部 |
| globalContext | dictionary | 否 | 添加标签数据，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值。添加规则请查阅 [此处](#key-conflict) |

### Log 配置
```csharp
FTWrapper.InitLogConfig(@"
{
    ""sampleRate"": 0.9,
    ""enableCustomLog"": true,
    ""enableLinkRumData"": true,
    ""globalContext"": {
        ""log_custom"": ""log custom value""
    }
}");
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。|
| globalContext | dictionary | 否 | 添加标签数据，添加规则请查阅 [此处](#key-conflict)  |
| logLevelFilters | array | 否 | 设置等级日志过滤，`ok`，`info`，`warning`，`error`，`critical`，默认不设置 |
| enableCustomLog | bool | 否 | 是否上传自定义日志 ，默认为 `false` |
| logCacheDiscardStrategy | string | 否 | `discard`为丢弃追加数据，`discard_oldest` 丢弃老数据，默认为 `discard` |

### Trace 配置
```csharp
FTWrapper.InitTraceConfig(@"
{
    ""sampleRate"": 0.9,
    ""traceType"": ""ddtrace"",
    ""enableLinkRumData"": true
}");
```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| sampleRate | float | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。 |
| traceType | enum | 否 | 默认为 `ddtrace`，目前支持 `zipkin` , `jaeger`, `ddtrace`，`skywalking` (8.0+)，`traceParent` (W3C)，如果接入 OpenTelemetry 选择对应链路类型时，请注意查阅支持类型及 agent 相关配置  |
| enableLinkRUMData | bool | 否 | 是否与 RUM 数据关联，默认为 `false` |

## RUM 用户数据追踪
目前只能通过手动方法调用来实现 RUM 数据传输

### Action
#### 使用方法
```csharp
/**	
 * action 开始
 * 
 * @param actionName action 名称
 * @param actionType action 类型
 */
void StartAction(string actionName,string actionType);
		
```

#### 代码示例
```csharp
 FTWrapper.StartAction("click", "test");
```

### View
#### 使用方法
```csharp
/**
 * view 开始.
 * 
 * @param viewName 当前页面名称
 */
void StartView(string viewName);

/**
 * view 结束.
 * 
 */
void StopView();
```

#### 代码示例

```csharp
FTWrapper.StartView("TEST_VIEW_ONE");

FTWrapper.StopView();
```

### Resource
#### 使用方法
```csharp
/**
 * resource 起始
 * 
 * @param resourceId		资源 Id
 */
void StartResource(string resourceId)
	
/**
 * resource 终止
 * 
 * @param resourceId 资源 Id
 */
void StopResource(string resourceId)


/**
 * 设置网络传输内容
 * 
 * @param resourceId		资源 Id
 * @param params			网络传输参数
 * @param netStatusBean		网络状态统计
 */
void addResource((string resourceId,string resourceParams,string netStauts);

```
##### netStauts

| **方法名** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| fetchStartTime | long| 否 | 请求开始时间，ns|
| tcpTime | long | 否 | tcp 连接耗时，ns |
| dnsTime | long | 否 | dns 解析时间，ns |
| responseTime | long | 否 |  响应内容传输耗时，ns|
| sslTime |long | 否 | ssl 链接耗时，ns |
| firstByteTime |long | 否 | ssl dns 解析到接收到第一个数据包的总时，ns |
| ttfb | long | 否 | 请求响应时间，开始发送请求到接收到响应首包的时长，ns|
| tcpStartTime | long  | 否 | tcp 连接时间，ns |
| tcpEndTime | long | 否 | tcp 结束时间 ，ns|
| dnsStartTime | long | 否 | dns 开始时间 ，ns|
| dnsEndTime | long | 否 | dns 结束时间，ns |
| responseStartTime | long | 否 |响应开始时间 ，ns |
| responseEndTime | long | 否 | 响应结束时间，ns |
| sslStartTime | long | 否 | ssl 开始时间，ns |
| sslEndTime | long | 否 |ssl 结束时间，ns |

##### resourceParams
| **方法名** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| url | string| 是 | url 地址  |
| requestHeader | string | 否 | 请求头参数，没有格式限制 |
| responseHeader | string | 否 | 响应头参数，没有格式限制 |
| responseConnection | string | 否 | 响应  connection |
| responseContentType | string | 否 | 响应  ContentType |
| responseContentEncoding | string | 否 | 响应  ContentEncoding |
| resourceMethod | string | 否 | 请求方法 GET,POST 等 |
| responseBody | string | 否 | 返回 body 内容 |

#### 代码示例
```csharp
FTWrapper.StartResource(resourceId);

FTWrapper.StopResource(resourceId);

FTWrapper.AddResource(resourceId, @"
            {
                ""url"": ""https://api.fxbsports.com/commune"",
                ""requestHeader"": ""key1=value1,key2=value2"",
                ""responseHeader"": ""key1=value1,key2=value2"",
                ""resourceStatus"": 200
            }",
            @"{
                ""dnsTime"": 0,
                ""tcpTime"": 0,
                ""sslTime"": 0,
                ""ttfb"": 0
            }");

```

### Error
#### 使用方法
```csharp
/**
 * 添加错误信息
 * 
 * @param log		日志
 * @param message	消息
 * @param errorType	错误类型
 * @param state		程序运行状态
 */
void AddError(string log,string message,string errorType,string state);
```

##### errorType

| **方法名**  | **说明** |
| --- | --- |
| native_crash | 应用错误|
| network_error | 网络错误|

##### state

| **方法名** | **说明** |
| --- |  --- |
| unknown | 未知|
| startup | 启动时|
| run | 运行中|

#### 代码示例
```csharp
FTWrapper.AddError("error", "error msg", "native_crash", "run");
```

### LongTask
#### 使用方法
```csharp
/**
 * 添加长耗时任务
 * 
 * @param log		日志
 * @param duration	持续时间(ns)
 */
void AddLongTask(string log,long duration)
```

#### 代码示例
```csharp
FTWrapper.AddLongTask("long task test", 100002);
```

## Log 日志打印
### 使用方法
```csharp
/**
  * 上传用户日志到datakit
  * @param content	日志内容
  * @param level		日志级别
  */
void AddLog(string log, string level);
```
### level

| **方法名** | **含义** |
| --- | --- |
| info | 提示 |
| warning | 警告 |
| error | 错误 |
|critical | 严重 |
| ok | 恢复 |

### 代码示例
```csharp
FTWrapper.AddLog("test log", "info");
```

## Tracer 网络链路追踪
链路通过生成 Trace Header，然后通过将 Header 添加到 http 请求头上来实现链路功能

### 使用方法
```csharp
/**
 * 按配置生成 trace header
 * 
 * @param url	网络地址
 * @return trace 链路使用头数据
 */
 IntPtr GetTraceHeaderWithUrl(string url);
 
 
 /**
 * 按配置生成 trace header
 * 
 * @param url	网络地址
 * @param resourceId  
 * @return trace 链路使用头数据
 */
 IntPtr GetTraceHeader(string resourceId, string url);
```

### 代码示例
```csharp
IntPtr headData = FTWrapper.GetTraceHeader(resourceId, FAKE_URL);
string headString = Marshal.PtrToStringAnsi(headData);

IntPtr headData = FTWrapper.GetTraceHeader(FAKE_URL);
string headString = Marshal.PtrToStringAnsi(headData);

```

## 用户信息绑定与解绑
### 使用方法

```csharp 
/**
 * 绑定用户数据
 * 
 * @param config	用户数据
 * @return
 */
void BindUserData(string jsonConfig);
		
/**
 * 解绑用户数据
 *
 */
void UnbindUserdata();

```

| **方法名** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| userId | string| 是 | 用户 id |
| userName | string | 否 | 用户名 |
| userEmail | string | 否 | 用户邮箱 |
| extra | dictionary | 否 | KV 方式赋值，添加规则请查阅 [此处](#key-conflict) |


### 代码示例
```csharp 
FTWrapper.BindUserData(@"
{
    ""userId"": ""userid"",
    ""userName"": ""someone"",
    ""userEmail"": ""someone@email.com"",
    ""extra"": {
        ""custom_data"": ""custom data""
    }
}");

```

## 关闭 SDK
```csharp
/**
 * 关闭SDK，执行相关资源清理操作 
 */
FTWrapper.DeInit();

```


## 常见问题 {#FAQ}
### 添加局变量避免冲突字段 {#key-conflict}

为了避免自定义字段与 SDK 数据冲突，建议标签命名添加 **项目缩写** 的前缀，例如 `df_tag_name`，项目中使用 `key` 值可[查询源码](https://github.com/GuanceCloud/datakit-cpp/blob/develop/src/datakit-sdk-cpp/ft-sdk/FTSDKConstants.h)。SDK 全局变量中出现与 RUM、Log 相同变量时，RUM、Log 会覆盖 SDK 中的全局变量。
