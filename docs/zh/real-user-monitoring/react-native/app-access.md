# React Native 应用接入

---
???- quote "更新日志"

    **0.3.0**
    ```
    * 新增支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数
    * RUM resource 网络请求添加 remote ip 地址解析功能
    * 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
    * 日志添加自定义 status 方法
    * react-native 采集 action 方法修改，适配 React 17 无法从 React.createElement 拦截点击事件问题
    * 在 Debug 场景下，RUM Resource 采集过滤掉指向本地主机（localhost）的热更新连接
    * 修正 Android 底层 Double 适配问题
    ```
    [更多日志](https://github.com/GuanceCloud/datakit-react-native/blob/dev/CHANGELOG.md)
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

> Android 需要在 app/android 目录下 build.gradle 安装 ft-plugin 配合使用，详细配置请见 [Android SDK](../android/app-access.md#gradle-setting) 配置，或参考 demo


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
| syncSleepTime | number | 否 | 设置同步间歇时间。范围 [0,100]，默认不设置 |
| enableDataIntegerCompatible | boolean | 否 | 需要与 web 数据共存情况下，建议开启。此配置用于处理 web 数据类型存储兼容问题 。 |
| globalContext | object | 否 | [添加自定义标签](#user-global-context ) |

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
| enableAutoTrackUserAction | boolean | 否 | 是否自动采集 `React Native` 控件点击事件，开启后可配合  `accessibilityLabel`设置actionName |
| enableAutoTrackError | boolean | 否 | 是否自动采集 `React Native` Error |
| enableNativeUserAction | boolean | 否 | 是否进行 `Native Action` 追踪，`Button` 点击事件，纯 `React Native` 应用建议关闭，默认为 `false` |
| enableNativeUserView | boolean | 否 | 是否进行 `Native View` 自动追踪，纯 `React Native` 应用建议关闭，，默认为 `false` |
| enableNativeUserResource | boolean | 否 | 是否开始 `Native Resource`自动追踪，由于 React-Native 的网络请求在 iOS、Android 端是使用系统 API 实现的，所以开启 enableNativeUserResource 后，所有 resource 数据能够一并采集。 |
| errorMonitorType |enum ErrorMonitorType | 否 | 错误事件监控补充类型 |
| deviceMonitorType | enum DeviceMetricsMonitorType | 否 | 视图的性能监控类型                                           |
| detectFrequency | enum DetectFrequency | 否 | 视图的性能监控采样周期 |
| enableResourceHostIP | boolean | 否 | 是否采集请求目标域名地址的 IP。作用域：只影响 `enableNativeUserResource`  为 true 的默认采集。iOS：`>= iOS 13` 下支持。Android：单个 Okhttp 对相同域名存在 IP 缓存机制，相同 `OkhttpClient`，在连接服务端 IP 不发生变化的前提下，只会生成一次。 |
| globalContext | object | 否 | [添加自定义标签](#user-global-context) |

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
| globalContext | NSDictionary | 否 | [添加自定义标签](#user-global-context) |
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

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';
/**
 * view加载时长。(可选)
 * @param viewName view 名称
 * @param loadTime view 加载时长
*/
FTReactNativeRUM.onCreateView('viewName', duration);
/**
 * view 开始。
 * @param viewName 界面名称
 * @param property 事件上下文(可选)
*/
FTReactNativeRUM.startView(
  'viewName',
  { 'custom.foo': 'something' },
);
/**
 * view 结束。
 * @param property 事件上下文(可选)
 */
FTReactNativeRUM.stopView(
 { 'custom.foo': 'something' },
);
```

**如果您在 React Native 中使用 `react-native-navigation ` 、`react-navigation ` 或 `Expo Router `  导航组件，可以参考下面方式进行 `React Native View`  的自动采集**：

#### react-native-navigation

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

#### react-navigation

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

  如果没有使用 `createNativeStackNavigator();` 需要在 `NavigationContainer` 组件中添加自动采集方法，如下

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

#### Expo Router

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

### Action

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableAutoTrackUserAction` 和 `enableNativeUserAction`开启自动采集，也可通过下面方法进行手动添加。

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.startAction('actionName','actionType');
```

### Error

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableAutoTrackError`开启自动采集，也可通过下面方法进行手动添加。

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.addError("error stack","error message");
```

### Resource

在 SDK 初始化 [RUM 配置](#rum-config) 时配置 `enableNativeUserResource` 开启自动采集，也可通过下面方法进行手动添加。

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
```typescript
/**
FTReactNativeLogWrapper.logging(content: String, logStatus: FTLogStatus | String, property?: object): Promise<void>
输出日志。
@param content — 日志内容
@param logStatus — 日志状态
@param property — 日志上下文(可选)
*/
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

SDK 初始化 [Trace 配置](#trace-config) 时可以开启自动网络链路追踪，也支持用户自定义采集，自定义采集使用示例如下：

```typescript
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

```typescript
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

## 主动同步数据

当配置 `FTMobileConfig.autoSync` 为 `true` 时，无需做额外的操作，SDK 会进行自动同步。

当配置 `FTMobileConfig.autoSync` 为 `false` 时，需要主动触发数据同步方法，进行数据同步。

```typescript
FTMobileReactNative.flushSyncData();
```

## 添加自定义标签 {#user-global-context}

### 静态使用

1. 使用 `react-native-config` 配置多环境，在不同的环境中设置对应的自定义标签值。

```typescript
let rumConfig: FTRUMConfig = {
      rumAppId: rumid,
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

### 动态使用

1、通过数据持久化方式，如 `AsyncStorage` 等，在初始化 SDK 时，获取存储的自定义标签。

```typescript
 let rumConfig: FTRUMConfig = {
      rumAppId: rumid,
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

3、最后重启应用。

**注意**：

- 特殊 key : track_id (在 RUM 中配置，用于追踪功能) ；  
- 当用户通过 globalContext 添加自定义标签与 SDK 自有标签相同时，SDK 的标签会覆盖用户设置的，建议标签命名添加项目缩写的前缀，例如 `df_tag_name`。项目中使用 `key` 值可[查询源码](https://github.com/GuanceCloud/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants.java)。


## Publish Package 相关配置
### Android
* [Android R8/Prograd 配置](../android/app-access.md#r8_proguard)
* [Android 符号文件上传](../android/app-access.md#source_map)

### iOS
* [iOS 符号文件上传](../ios/app-access.md#source_map)


## 常见问题

- [iOS 相关](../ios/app-access.md#FAQ)
- [Android 相关](../android/app-access.md#FAQ)

