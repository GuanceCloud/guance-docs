# React Native 应用接入

---

## 前置条件

**注意**：若您开通了 [RUM Headless](../../dataflux-func/headless.md) 服务，前置条件已自动帮您配置完成，直接接入应用即可。

- 安装 [DataKit](../../datakit/datakit-install.md)；  
- 配置 [RUM 采集器](../../integrations/rum.md)；
- DataKit 配置为[公网可访问，并且安装 IP 地理信息库](../../datakit/datakit-tools-how-to.md#install-ipdb)。

## 应用接入

当前 React Native 版本暂只支持 Android 和 iOS 平台。登录观测云控制台，进入**用户访问监测**页面，点击左上角 **[新建应用](../index.md#create)**，即可开始创建一个新的应用。

1.输入「应用名称」、「应用ID」，选择平台对应「应用类型」

- 应用名称：用于识别当前用户访问监测的应用名称。
- 应用 ID ：应用在当前工作空间的唯一标识，对应字段：app_id 。该字段仅支持英文、数字、下划线输入，最多 48 个字符。

![](../img/image_13.png)

## 安装

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.guance.com/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**源码地址**：[https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

在项目路径下，终端运行命令：

```bash
npm install @cloudcare/react-native-mobile
```

这将在包的 package.json 中添加这样的一行：

```json
"dependencies": {    
   "@cloudcare/react-native-mobile: [lastest_version],
   ···
}
```

**Android 集成额外配置:**

* 配置 Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) ，采集 App 启动事件和网络请求数据，以及 Android Native 原生相关事件（页面跳转、点击事件、Native 网络请求、WebView 数据）。
* 注意需要同时在 Gradle 中配置观测云 Android Maven 仓库地址，Plugin 和 AAR 都需要，配置配置细节 example 中 [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle) 的配置


现在在您的代码中，您可以使用：

```typescript
import {
  FTMobileReactNative,
  FTReactNativeLog,
  FTReactNativeTrace,
  FTReactNativeRUM,
  FTMobileConfig,
  FTLogConfig,
  FTTraceConfig,
  FTRUMConfig,
  ErrorMonitorType,
  DeviceMetricsMonitorType,
  DetectFrequency,
  TraceType,
  FTLogStatus,
  EnvType,
} from '@cloudcare/react-native-mobile';
```

## SDK 初始化

###  基础配置 {#base-setting}

```typescript
 //本地环境部署、Datakit 部署
let config: FTMobileConfig = {
    datakitUrl: datakitUrl,
  };

 //使用公网 DataWay
 let config: FTMobileConfig = {
    datawayUrl: datawayUrl,
    clientToken: clientToken
  };
await FTMobileReactNative.sdkConfig(config);

```

| 字段 | 类型 | 必须 | 说明 |
| --- | --- | --- | --- |
| datakitUrl | string | 是 | datakit 访问 URL 地址，例子：[http://10.0.0.1:9529](http://10.0.0.1:9529/)，端口默认 9529，注意：安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| datawayUrl | string | 是 | dataway 访问 URL 地址，例子：[http://10.0.0.1:9528](http://10.0.0.1:9528/)，端口默认 9528，注意：安装 SDK 设备需能访问这地址.**注意：datakit 和 dataway 配置两者二选一** |
| clientToken | string | 是 | 认证 token，需要与 datawayUrl 同时使用 |
| debug | boolean | 否 | 设置是否允许打印日志，默认`false` |
| env | string | 否 | 环境配置，默认`prod`，任意字符，建议使用单个单词，例如 `test` 等 |
| envType | enum EnvType | 否 | 环境配置，默认`EnvType.prod`。注：env 与 envType 只需配置一个|
| service | string | 否 | 设置所属业务或服务的名称，影响 Log 和 RUM 中 service 字段数据。默认：`df_rum_ios`、`df_rum_android` |
| autoSync | boolean | 否 | 是否开启自动同步。默认 `true` |
| syncPageSize | number | 否 | 设置同步请求条目数。范围 [5,）注意：请求条目数越大，代表数据同步占用更大的计算资源 |
| syncSleepTime | number | 否 | 设置同步间歇时间。范围 [0,5000]，默认不设置 |
| enableDataIntegerCompatible | boolean | 否 | 需要与 web 数据共存情况下，建议开启。此配置用于处理 web 数据类型存储兼容问题 。 |
| globalContext | object | 否 | 添加自定义标签。添加规则请查阅[此处](../android/app-access.md#key-conflict) |
| compressIntakeRequests | boolean | 否 | 设置是否对同步数据进行压缩 |

### RUM 配置 {#rum-config}

```typescript
let rumConfig: FTRUMConfig = {
    androidAppId: Config.ANDROID_APP_ID,
    iOSAppId:Config.IOS_APP_ID,
    enableAutoTrackUserAction: true,
    enableAutoTrackError: true,
    enableNativeUserAction: true,
    enableNativeUserView: false,
    enableNativeUserResource: true,
    errorMonitorType:ErrorMonitorType.all,
    deviceMonitorType:DeviceMetricsMonitorType.all,
    detectFrequency:DetectFrequency.rare
  };

await FTReactNativeRUM.setConfig(rumConfig);
```

| 字段 | 类型 | 必须 | 说明 |
| --- | --- | --- | --- |
| androidAppId | string | 是 | app_id，应用访问监测控制台申请 |
| iOSAppId | string | 是 | app_id，应用访问监测控制台申请 |
| sampleRate | number | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。作用域为同一 session_id 下所有 View，Action，LongTask，Error 数据|
| enableAutoTrackUserAction | boolean | 否 | 是否自动采集 `React Native` 组件点击事件，开启后可配合  `accessibilityLabel`设置actionName，更多自定义操作请参考[此处](#rum-action) |
| enableAutoTrackError | boolean | 否 | 是否自动采集 `React Native` Error |
| enableNativeUserAction | boolean | 否 | 是否进行 `Native Action` 追踪，原生 `Button` 点击事件，应用启动事件，默认为 `false` |
| enableNativeUserView | boolean | 否 | 是否进行 `Native View` 自动追踪，纯 `React Native` 应用建议关闭，，默认为 `false` |
| enableNativeUserResource | boolean | 否 | 是否开始 `Native Resource`自动追踪，由于 React-Native 的网络请求在 iOS、Android 端是使用系统 API 实现的，所以开启 enableNativeUserResource 后，所有 resource 数据能够一并采集。 |
| errorMonitorType |enum ErrorMonitorType | 否 | 错误事件监控补充类型 |
| deviceMonitorType | enum DeviceMetricsMonitorType | 否 | 视图的性能监控类型                                           |
| detectFrequency | enum DetectFrequency | 否 | 视图的性能监控采样周期 |
| enableResourceHostIP | boolean | 否 | 是否采集请求目标域名地址的 IP。作用域：只影响 `enableNativeUserResource`  为 true 的默认采集。iOS：`>= iOS 13` 下支持。Android：单个 Okhttp 对相同域名存在 IP 缓存机制，相同 `OkhttpClient`，在连接服务端 IP 不发生变化的前提下，只会生成一次。 |
| globalContext | object | 否 | 添加自定义标签，用于用户监测数据源区分，如果需要使用追踪功能，则参数 `key` 为 `track_id` ,`value` 为任意数值，添加规则注意事项请查阅[此处](../android/app-access.md#key-conflict) |
| enableTrackNativeCrash | boolean | 否 | 是否采集 `Native Error` |
| enableTrackNativeAppANR | boolean | 否 | 是否采集 `Native ANR`                                        |
| enableTrackNativeFreeze | boolean | 否 | 是否采集 `Native Freeze` |
| nativeFreezeDurationMs | number | 否 | 设置采集 `Native Freeze`卡顿的阈值，取值范围 [100,)，单位毫秒。iOS 默认 250ms，Android 默认 1000ms |

### Log 配置 {#log-config}

```typescript
let logConfig: FTLogConfig = {
      enableCustomLog: true,
      enableLinkRumData: true,
    };
await FTReactNativeLog.logConfig(logConfig);
```

| 字段 | 类型 | 必须 | 说明 |
| --- | --- | --- | --- |
| sampleRate | number | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。   |
| enableLinkRumData | boolean | 否 | 是否与 `RUM` 关联 |
| enableCustomLog | boolean | 否 | 是否开启自定义日志 |
| discardStrategy | enum FTLogCacheDiscard | 否 | 日志丢弃策略，默认`FTLogCacheDiscard.discard` |
| logLevelFilters | Array<FTLogStatus> | 否 | 日志等级过滤 |
| globalContext | NSDictionary | 否 | 添加 log 自定义标签，添加规则请查阅[此处](../android/app-access.md#key-conflict) |
| logCacheLimitCount | number | 否 | 获取最大日志条目数量限制 [1000,)，日志越大，代表磁盘缓存压力越大，默认 5000 |

### Trace 配置 {#trace-config}

```typescript
 let traceConfig: FTTractConfig = {
      enableNativeAutoTrace: true, 
    };
await FTReactNativeTrace.setConfig(traceConfig);
```

| 字段 | 类型 | 必须 | 说明 |
| --- | --- | --- | --- |
| sampleRate | number | 否 | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。  |
| traceType | enum TraceType | 否 | 链路类型，默认`TraceType.ddTrace` |
| enableLinkRUMData | boolean | 否 | 是否与 `RUM` 数据关联，默认`false` |
| enableNativeAutoTrace | boolean | 否 | 是否开启原生网络网络自动追踪 iOS NSURLSession ,Android OKhttp(由于 `React Native`的网络请求在 iOS、Android 端是使用系统 API 实现的，所以开启 `enableNativeAutoTrace` 后，所有 `React Native` 数据能够一并追踪。） |

> **注意：**
>
> * 请在您的顶层 `index.js` 文件中注册 App 之前完成 SDK 的初始化，以确保在调用 SDK 的其他任何方法之前，SDK 已经完全准备就绪。
> * 在完成基础配置之后再进行 RUM 、Log 、Trace 配置。
>
> ```javascript
> import App from './App';
> 
> async function sdkInit() {
>   await FTMobileReactNative.sdkConfig(config);
>   await FTReactNativeRUM.setConfig(rumConfig);
>   ....
> }
> initSDK();
> AppRegistry.registerComponent('main', () => App);
> ```

## RUM 用户数据追踪

### View

在 SDK 初始化 [RUM 配置](#rum-config) 时可配置 `enableNativeUserView` 开启自动采集 `Native View`，`React Native View` 由于 React Native 提供了广泛的库来创建屏幕导航，所以默认情况下只支持手动采集 ，您可以使用下面方法手动启动和停止视图。

#### 自定义 View

##### 使用方法

```typescript
/**
 * view加载时长。
 * @param viewName view 名称
 * @param loadTime view 加载时长
 * @returns a Promise.
 */
onCreateView(viewName:string,loadTime:number): Promise<void>;
/**
 * view 开始。
 * @param viewName 界面名称
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
startView(viewName: string, property?: object): Promise<void>;
/**
 * view 结束。
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
stopView(property?:object): Promise<void>;
```

##### 使用示例

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.onCreateView('viewName', duration);

FTReactNativeRUM.startView(
  'viewName',
  { 'custom.foo': 'something' },
);

FTReactNativeRUM.stopView(
 { 'custom.foo': 'something' },
);
```

#### 自动采集 React Native View

**如果您在 React Native 中使用 `react-native-navigation ` 、`react-navigation ` 或 `Expo Router `  导航组件，可以参考下面方式进行 `React Native View`  的自动采集**：

##### react-native-navigation

将 example 中 [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNativeNavigationTracking.tsx) 文件添加到您的工程；

调用 `FTRumReactNativeNavigationTracking.startTracking()` 方法，开启采集。

```typescript
import { FTRumReactNativeNavigationTracking } from './FTRumReactNativeNavigationTracking';

function startReactNativeNavigation() {
  FTRumReactNativeNavigationTracking.startTracking();
  registerScreens();//Navigation registerComponent
  Navigation.events().registerAppLaunchedListener( async () => {
    await Navigation.setRoot({
      root: {
        stack: {
          children: [
            { component: { name: 'Home' } },
          ],
        },
      },
    });
  });
}
```

##### react-navigation

将 example 中 [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNavigationTracking.tsx) 文件添加到您的工程；

* 方法一：

  如果您使用 `createNativeStackNavigator();` 创建原生导航堆栈，建议采用添加 `screenListeners` 方式开启采集， 这样可以统计到页面的加载时长，具体使用如下：

```typescript
  import {FTRumReactNavigationTracking} from './FTRumReactNavigationTracking';
  import { createNativeStackNavigator } from '@react-navigation/native-stack';
  const Stack = createNativeStackNavigator();
  
  <Stack.Navigator  screenListeners={FTRumReactNavigationTracking.StackListener} initialRouteName='Home'>
          <Stack.Screen name='Home' component={Home}  options={{ headerShown: false }} />
          ......
          <Stack.Screen name="Mine" component={Mine} options={{ title: 'Mine' }}/>
  </Stack.Navigator>
```

* 方法二：

  如果没有使用 `createNativeStackNavigator();` 需要在 `NavigationContainer` 组件中添加自动采集方法，如下：

  **注意：此方法无法采集页面加载时长**
  
```typescript
  import {FTRumReactNavigationTracking} from './FTRumReactNavigationTracking';
  import type { NavigationContainerRef } from '@react-navigation/native';
  
  const navigationRef: React.RefObject<NavigationContainerRef<ReactNavigation.RootParamList>> = React.createRef();
  <NavigationContainer ref={navigationRef} onReady={() => {
        FTRumReactNavigationTracking.startTrackingViews(navigationRef.current);
      }}>
        <Stack.Navigator initialRouteName='Home'>
          <Stack.Screen name='Home' component={Home}  options={{ headerShown: false }} />
          .....
          <Stack.Screen name="Mine" component={Mine} options={{ title: 'Mine' }}/>
        </Stack.Navigator>
   </NavigationContainer>
```

具体使用示例可以参考 [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)。

##### Expo Router

如果您使用的是 [Expo Router](https://expo.github.io/router/docs/)，在 app/_layout.js 文件中添加如下方法进行数据采集。

```js
import { useEffect } from 'react';
import { useSegments, Slot } from 'expo-router';
import {
  FTReactNativeRUM,
} from '@cloudcare/react-native-mobile';

export default function Layout() {
    const segments = useSegments();
    const viewKey = segments.join('/');

    useEffect(() => {
       FTReactNativeRUM.startView(viewKey);
    }, [viewKey, pathname]);

    // Export all the children routes in the most basic way.
    return <Slot />;
}
```

### Action {#rum-action}

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableAutoTrackUserAction` 和 `enableNativeUserAction`开启自动采集，也可通过下面方法进行手动添加。

#### 使用方法

```typescript
/**
 * 执行 action 。
 * @param actionName action 名称
 * @param actionType action 类型
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
startAction(actionName:string,actionType:string,property?:object): Promise<void>;
```

####  代码示例

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.startAction('actionName','actionType',{'custom.foo': 'something'});
```

**更多自定义采集操作**

开启 `enableAutoTrackUserAction` 后，SDK 会自动采集拥有 `onPress` 属性的组件的点击操作。若您希望在自动追踪的基础上执行一些自定义操作，SDK 支持如下操作：

* 自定义某一组件点击事件的 `actionName`

  通过 `accessibilityLabel` 属性进行设置

```typescript
  <Button title="Custom Action Name"
          accessibilityLabel="custom_action_name"
          onPress={()=>{
                console.log("btn click")
          }}
   />
```

* 不采集某一组件的点击事件

  可以通过添加 `ft-enable-track` 自定义参数进行设置，设置值为 `false ` 

```typescript
  <Button title="Action Click" 
          ft-enable-track="false"
          onPress={()=>{
                console.log('btn click');
          }}
  />
```

* 对某一组件的点击事件添加额外属性

  可以通过添加 `ft-extra-property` 自定义参数进行设置，要求**值为 Json 字符串**

```typescript
  <Button title="Action 添加额外属性"
          ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
          onPress={()=>{
                 console.log("btn click")
          }}
  />
```

### Error

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableAutoTrackError`开启自动采集，也可通过下面方法进行手动添加。

#### 使用方法

```typescript
/**
 * 异常捕获与日志收集。
 * @param stack 堆栈日志
 * @param message 错误信息
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
addError(stack: string, message: string,property?:object): Promise<void>;
/**
 * 异常捕获与日志收集。
 * @param type 错误类型
 * @param stack 堆栈日志
 * @param message 错误信息
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
addErrorWithType(type:string,stack: string, message: string,property?:object): Promise<void>;
```

#### 使用示例

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.addError("error stack","error message",{'custom.foo': 'something'});

FTReactNativeRUM.addErrorWithType("custom_error", "error stack", "error message",{'custom.foo': 'something'});
```



### Resource

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableNativeUserResource` 开启自动采集，也可通过下面方法进行手动添加。

#### 使用方法

```typescript
/**
 * 开始资源请求。
 * @param key 唯一 id
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
startResource(key: string,property?:object): Promise<void>;
/**
 * 结束资源请求。  
 * @param key 唯一 id
 * @param property 事件上下文(可选)
 * @returns a Promise.
 */
stopResource(key: string,property?:object): Promise<void>;
/**
 * 发送资源数据指标。
 * @param key 唯一 id
 * @param resource 资源数据
 * @param metrics  资源性能数据
 * @returns a Promise.
 */
addResource(key:string, resource:FTRUMResource,metrics?:FTRUMResourceMetrics):Promise<void>;
```

#### 使用示例

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

async getHttp(url:string){
            const key = Utils.getUUID();
            FTReactNativeRUM.startResource(key);
            const fetchOptions = {
                  method: 'GET',
                  headers:{
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                  } ,
            };
            var res : Response;
            try{
                  res = await fetch(url, fetchOptions);
            }finally{
                  var resource:FTRUMResource = {
                        url:url,
                        httpMethod:fetchOptions.method,
                        requestHeader:fetchOptions.headers,
                  };
                  if (res) {
                        resource.responseHeader = res.headers;
                        resource.resourceStatus = res.status;
                        resource.responseBody = await res.text();
                  }
                  FTReactNativeRUM.stopResource(key);
                  FTReactNativeRUM.addResource(key,resource);
            }
      }
```



##  Logger 日志打印

> 目前日志内容限制为 30 KB，字符超出部分会进行截断处理
### 使用方法

```typescript
/**
 * 输出日志。
 * @param content 日志内容
 * @param status  日志状态
 * @param property 日志上下文(可选)
 */
logging(content:String,logStatus:FTLogStatus|String,property?:object): Promise<void>;
```

### 使用示例

```typescript
import { FTReactNativeLog, FTLogStatus } from '@cloudcare/react-native-mobile';
// logStatus:FTLogStatus
FTReactNativeLog.logging("info log content",FTLogStatus.info);
// logStatus:string
FTReactNativeLog.logging("info log content","info");
```

### 日志等级

| **方法名** | **含义** |
| --- | --- |
| FTLogStatus.info | 提示 |
| FTLogStatus.warning | 警告 |
| FTLogStatus.error | 错误 |
| FTLogStatus.critical | 严重 |
| FTLogStatus.ok | 恢复 |

## Tracer 网络链路追踪

SDK 初始化 [Trace 配置](#trace-config) 时可以开启自动网络链路追踪，也支持用户自定义采集，自定义采集使用方法及示例如下：

### 使用方法

```typescript
/**
 * 获取 trace http 请求头数据。
 * @param url 请求地址
 * @returns trace 添加的请求头参数  
 * @deprecated use getTraceHeaderFields() replace.
 */
getTraceHeader(key:String, url: String): Promise<object>;
/**
 * 获取 trace http 请求头数据。
 * @param url 请求地址
 * @returns trace 添加的请求头参数  
 */
getTraceHeaderFields(url: String,key?:String): Promise<object>;
```

### 使用示例

```typescript
import {FTReactNativeTrace} from '@cloudcare/react-native-mobile';
 
async getHttp(url:string){
    const key = Utils.getUUID();
    var traceHeader = await FTReactNativeTrace.getTraceHeaderFields(url);
    const fetchOptions = {
      method: 'GET',
      headers:Object.assign({
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },traceHeader) ,
    };
    try{
      fetch(url, fetchOptions);
    }
  }
```

## 用户信息绑定与解绑

### 使用方法

```typescript
/**
 * 绑定用户。
 * @param userId 用户ID。
 * @param userName 用户姓名。
 * @param userEmail 用户邮箱
 * @param extra  用户的额外信息
 * @returns a Promise.
 */
bindRUMUserData(userId: string,userName?:string,userEmail?:string,extra?:object): Promise<void>;
/**
 * 解绑用户。
 * @returns a Promise.
 */
unbindRUMUserData(): Promise<void>;
```

### 使用示例

```typescript
import {FTMobileReactNative} from '@cloudcare/react-native-mobile';

/**
 * 绑定用户。
 * @param userId 用户ID。
 * @param userName 用户姓名。
 * @param userEmail 用户邮箱
 * @param extra  用户的额外信息
 * @returns a Promise.
*/
FTMobileReactNative.bindRUMUserData('react-native-user','uesr_name')
/**
 * 解绑用户。
 * @returns a Promise.
*/
FTMobileReactNative.unbindRUMUserData()
```

## 关闭 SDK

使用 `FTMobileReactNative` 关闭 SDK。

### 使用方法

```typescript
/**
 * 关闭 SDK 内正在运行对象
 */
shutDown():Promise<void>
```

### 使用示例

```typescript
FTMobileReactNative.shutDown();
```

## 清理 SDK 缓存数据

使用  `FTMobileReactNative` 清理未上报的缓存数据 

### 使用方法

```typescript
/**
 * 清除所有尚未上传至服务器的数据。
 */
clearAllData():Promise<void>
```

### 使用示例

```typescript
/**
 * 清除所有尚未上传至服务器的数据。
*/
FTMobileReactNative.clearAllData();
```

## 主动同步数据

当配置 `FTMobileConfig.autoSync` 为 `true` 时，无需做额外的操作，SDK 会进行自动同步。

当配置 `FTMobileConfig.autoSync` 为 `false` 时，需要主动触发数据同步方法，进行数据同步。

### 使用方法

```typescript
/**
 * 主动同步数据，当配置 `FTMobileConfig.autoSync=false` 时,需要主动触发本方法，进行数据同步。
 * @returns a Promise.
 */
flushSyncData():Promise<void>;
```

### 使用示例

```typescript
FTMobileReactNative.flushSyncData();
```

## 添加自定义标签 {#user-global-context}

### 使用方法

```typescript
/**
 * 添加自定义全局参数。作用于 RUM、Log 数据
 * @param context 自定义全局参数。
 * @returns a Promise.
 */
appendGlobalContext(context:object):Promise<void>;
/**
 * 添加自定义 RUM 全局参数。作用于 RUM 数据
 * @param context 自定义 RUM 全局参数。
 * @returns a Promise.
 */
appendRUMGlobalContext(context:object):Promise<void>;
/**
 * 添加自定义 RUM、Log 全局参数。作用于 Log 数据
 * @param context 自定义 Log 全局参数。
 * @returns a Promise.
 */
appendLogGlobalContext(context:object):Promise<void>;
```

### 使用示例

```typescript
FTMobileReactNative.appendGlobalContext({'global_key':'global_value'});

FTMobileReactNative.appendRUMGlobalContext({'rum_key':'rum_value'});

FTMobileReactNative.appendLogGlobalContext({'log_key':'log_value'});
```

## 符号文件上传 {#source_map}

### 自动打包符号文件

#### 添加符号文件自动打包脚本

脚本工具：[cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` 是帮助配置发布构建时自动获取 React Native 和 Native sourcemaps，并将它们打包为 zip 文件的脚本工具。

使用本地文件方式添加添加到 `package.json` 开发依赖中 

例如：将 `cloudcare-react-native-mobile-cli.tgz` 放在React Native工程目录时

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli":"file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

添加后执行 `yarn install` 

**注意：安卓环境需要添加配置 Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting)，版本要求： >=1.3.4**

在项目主模块 `app` 的 `build.gradle` 文件中添加 `Plugin` 的使用与参数设置

```java
apply plugin: 'ft-plugin'
FTExt {
    //showLog = true
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    generateSourceMapOnly = true
}
```

#### 执行配置命令

在 React Native 项目目录下执行终端执行 `yarn ft-cli setup`  命令，使其能够在发布构建时自动获取 React Native 和 Native sourcemaps，并将它们打包为 zip 文件。出现如下日志即表示设置成功。

```sh
➜  example git:(test-cli) ✗ yarn ft-cli setup
yarn run v1.22.22
$ /Users/xxx/example/node_modules/.bin/ft-cli setup
Starting command: Setup to automatically get react-native and native sourcemap in release build and package them as zip files.
Running task: Add a Gradle Script to automatically zip js sourcemap and Android symbols
Running task: Enable react-native sourcemap generation on iOS
Running task: Setup a new build phase in XCode to automatically zip dSYMs files and js sourcemap


Finished running command Setup to automatically get react-native and native sourcemap in release build and package them as zip files.

✅ Successfully executed: Add a Gradle Script to automatically zip js sourcemap and Android symbols.
✅ Successfully executed: Enable react-native sourcemap generation on iOS.
✅ Successfully executed: Setup a new build phase in XCode to automatically zip dSYMs files and js sourcemap.
✨  Done in 1.00s.
```

**进行 release build 后打包的 zip 文件地址：**

iOS：iOS 文件夹下（./ios/sourcemap.zip）

Android : RN 项目目录下 (./sourcemap.zip) 

### 手动打包符号文件

[React Native Zip 包打包说明](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### 上传

[文件上传和删除](../sourcemap/set-sourcemap.md/#upload)

## WebView 数据监测

WebView 数据监测，需要在 WebView 访问页面集成[Web 监测 SDK](../web/app-access.md)

## 自定义标签使用示例 {#track}

### 编译配置方式

1. 使用 `react-native-config` 配置多环境，在不同的环境中设置对应的自定义标签值。

```typescript
let rumConfig: FTRUMConfig = {
      iOSAppId: iOSAppId,
      androidAppId: androidAppId,
      monitorType: MonitorType.all,
      enableTrackUserAction:true,
      enableTrackUserResource:true,
      enableTrackError:true,
      enableNativeUserAction: false,
      enableNativeUserResource: false,
      enableNativeUserView: false,
      globalContext:{"track_id":Config.TRACK_ID}, //.env.dubug、.env.release 等配置的环境文件中设置
    };

 await FTReactNativeRUM.setConfig(rumConfig); 
```

### 运行时读写文件方式

1、通过数据持久化方式，如 `AsyncStorage` 等，在初始化 SDK 时，获取存储的自定义标签。

```typescript
 let rumConfig: FTRUMConfig = {
      iOSAppId: iOSAppId,
      androidAppId: androidAppId,
      monitorType: MonitorType.all,
      enableTrackUserAction:true,
      enableTrackUserResource:true,
      enableTrackError:true,
      enableNativeUserAction: false,
      enableNativeUserResource: false,
      enableNativeUserView: false,
    };
 await new Promise(function(resolve) {
       AsyncStorage.getItem("track_id",(error,result)=>{
        if (result === null){
          console.log('获取失败' + error);
        }else {
          console.log('获取成功' + result);
          if( result != undefined){
            rumConfig.globalContext = {"track_id":result};
          }
        }
        resolve(FTReactNativeRUM.setConfig(rumConfig));
      })
     });
```

2、在任意处添加或改变自定义标签到文件。

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('存储失败' + error);
    }else {
        console.log('存储成功');
    }
})
```

3、最后重启应用后生效。

### SDK 运行时添加

在 SDK 初始化完毕之后，使用`FTReactNativeRUM.appendGlobalContext(globalContext)`、`FTReactNativeRUM.appendRUMGlobalContext(globalContext)`、`FTReactNativeRUM.appendLogGlobalContext(globalContext)`，可以动态添加标签，设置完毕，会立即生效。随后，RUM 或 Log 后续上报的数据会自动添加标签数据。这种使用方式适合延迟获取数据的场景，例如标签数据需要网络请求获取。

```typescript
//SDK 初始化伪代码，获取
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info:Info){
	let  globalContext = {"delay_key":info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Publish Package 相关配置
### Android
* [Android R8/Prograd 配置](../android/app-access.md#r8_proguard)
* [Android 符号文件上传](../android/app-access.md#source_map)

### iOS
* [iOS 符号文件上传](../ios/app-access.md#source_map)

## 常见问题

- [Android 隐私审核](../android/app-access.md#third-party)
- [iOS 其他相关](../ios/app-access.md#FAQ)
- [Android 其他相关](../android/app-access.md#FAQ)

