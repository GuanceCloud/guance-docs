# React Native Application Access
---

## Precondition

- Installing DataKit ([DataKit Installation Documentation](... /... /datakit/datakit-install.md))

## Application Access

The current version of React Native only supports Android and iOS platforms for now. Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

![](../img/image_12.png)

![](../img/image_13.png)

## Installation

**Source Code Address**：[https://github.com/DataFlux-cn/datakit-react-native](https://github.com/DataFlux-cn/datakit-react-native)

**Demo Address**：[https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

In the project path, run the command in the terminal.

```bash
npm install @cloudcare/react-native-mobile
```

This will add a line like this to the package.json of the package.

```json
"dependencies": {    
   "@cloudcare/react-native-mobile: "^0.2.4",
   ···
}
```

> Android needs to install ft-plugin in app/android directory build.gradle, please refer to [Android SDK](../android/app-access.md#gradle-setting) for detailed configuration, or refer to the demo


Now in your code, you can use.

```json
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

## SDK Initialization

###  Basic Configuration

```typescript
let config: FTMobileConfig = {
    serverUrl: Config.SERVER_URL,
    debug: true,
  };
FTMobileReactNative.sdkConfig(config)
```

| **Fields** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| datakitUrl | string | Yes | The url of the Datakit address, example: http://10.0.0.1:9529, port 9529. Datakit url address needs to be accessible by the device where the SDK is installed. |
| datawayUrl | string | Yes | The url of the Dataway address，example：http://10.0.0.1:9528，port 9528，Note: The installed SDK device must be able to access this address. Note: choose either DataKit or DataWay configuration, not both. |
| clientToken | string | Yes | Authentication token.It needs to be configured simultaneously with the datawayUrl. |
| debug         | boolean      | No           | Set whether to allow printing of logs, default `false`       |
| env | String       | No           | Request `HTTP` request header `X-Datakit-UUID` Data collection side will be configured automatically if the user does not set |
| envType       | enum EnvType | No           | Environment, default `prod`                                  |
| service | string | No          | Set the name of the business or service to which it belongs, and affect the service field data in Log and RUM. default：`df_rum_ios`、`df_rum_android` |
| globalContext | NSDictionary | No | [Add custom tags](#user-global-context ) |

### RUM Configuration

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
FTReactNativeRUM.setConfig(rumConfig);
```

| **Fields**                | **Type**         | **Required** | **Description**                                              |
| --- | --- | --- | --- |
| androidAppId | string | Yes          | appId, apply under monitoring                                |
| iOSAppId | string | Yes | appId, apply under monitoring |
| sampleRate | number | No           | Sampling rate, (values for sample rate range from >= 0, <= 1, default value is 1) |
| enableAutoTrackUserAction | boolean | No | Whether to automatically capture `React Native` control click events, with `accessibilityLabel` to set the actionName when enabled |
| enableAutoTrackError | boolean | No | Whether to automatically collect `React Native` Error |
| enableNativeUserAction | boolean | No | Whether to do `Native Action` tracking, `Button` click events, pure `React Native` applications are recommended to be turned off, default is `false` |
| enableNativeUserView | boolean | No | Whether to do `Native View` auto-tracking, recommended to be turned off for pure `React Native` applications, default is `false` |
| enableNativeUserResource | boolean | No | Whether to start `Native Resource` auto-tracking or not. Since React-Native's network requests are implemented using the system API on iOS and Android, all resource data can be collected together after enabling enableNativeUserResource. |
| errorMonitorType | enum ErrorMonitorType | No | Error Event Monitoring Supplementary Type                    |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | The performance monitoring type of the view                  |
| detectFrequency | enum DetectFrequency | No | View's Performance Monitoring Sampling Period |
| globalContext | object | No           | [Add custom tags](#user-global-context )                     |

### Log Configuration

```typescript
let logConfig: FTLogConfig = {
      enableCustomLog: true,
      enableLinkRumData: true,
    };
FTReactNativeLog.logConfig(logConfig);
```

| **Fields**        | **Type**               | **Required** | **Description**                                              |
| --- | --- | --- | --- |
| sampleRate | number | No           | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| enableLinkRumData | boolean | No           | Associated with `RUM` or not                                 |
| enableCustomLog | boolean | No           | Whether to enable custom logging                             |
| discardStrategy | enum FTLogCacheDiscard | No           | Log discard policy, default `FTLogCacheDiscard.discard`      |
| logLevelFilters | Array<FTLogStatus> | No           | Log level filtering                                          |
| globalContext | NSDictionary | No           | [Add custom tags](#user-global-context )                     |

### Trace Configuration

```typescript
 let traceConfig: FTTractConfig = {
      enableNativeAutoTrace: true, 
    };

 FTReactNativeTrace.setConfig(traceConfig);
```

| **Fields**            | **Type**       | **Required** | **Description**                                              |
| --- | --- | --- | --- |
| sampleRate | number | No | Sampling rate, the value of the sample rate ranges from >= 0, <= 1, the default value is 1 |
| traceType | enum TraceType | No | Trace type, default `TraceType.zipkin` |
| enableLinkRUMData | boolean | No | Whether to associate with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Whether to enable Native Network Network AutoTrace iOS NSURLSession ,Android OKhttp(Since the network request of `React Native` is implemented in iOS and Android using system API, so after enabling `enableNativeAutoTrace`, all `React Native` data can be traced together.) |

## RUM

The SDK provides two collection methods: **automatic collection** and **custom collection** to track four types of user data: **View**, **Action**, **Error**, **Resource**.

### Automatic Collection

When the SDK initializes [RUM Configuration](#rum-config), automatic collection of **Error**, **Resource**, **Action** ( `React Native` Controls,`Native` Controls), **View** ( `Native View`) can be enabled.

If you use the `react-native-navigation` or `react-navigation` navigation component in React Native, you can refer to the following way for automatic acquisition of `React Native View`:

* **react-native-navigation**

  Add file  [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNativeNavigationTracking.tsx)  to your project;

  Call `FTRumReactNativeNavigationTracking.startTracking()` method, start the automatic collection.

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

* **react-navigation**

  Add file  [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNavigationTracking.tsx)  to your project;

  * Method  I：

    If you are creating a native navigation stack by using the `createNativeStackNavigator();` method, it is recommended to add the 'screenListeners' method to start collecting data so that you can calculate the load time of the page as follows:

    ```typescript
    import {FTRumReactNavigationTracking} from './FTRumReactNavigationTracking';
    import { createNativeStackNavigator } from '@react-navigation/native-stack';
    const Stack = createNativeStackNavigator();
    
    <Stack.Navigator   screenListeners={FTRumReactNavigationTracking.StackListener} initialRouteName='Home'>
            <Stack.Screen name='Home' component={Home}  options={{ headerShown: false }} />
            ......
            <Stack.Screen name="Mine" component={Mine} options={{ title: 'Mine' }}/>
     </Stack.Navigator>
    ```

  * Method II：

    If the `createNativeStackNavigator();` method is not used, you need to start the automatic collection method in the `NavigationContainer` component, as follows:

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

Specific use the sample can be reference [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example). 

### Custom Collection

Use the 'FTReactNativeRUM' class to add, the relevant API is as follows.

#### View 

```typescript
FTReactNativeRUM.onCreateView("RUM",duration);

FTReactNativeRUM.startView("RUM");

FTReactNativeRUM.stopView();
```

#### Action

```typescript
FTReactNativeRUM.startAction('actionName','actionType');
```

The `actionName` can be set via `accessibilityLabel` when auto-capture is enabled.

#### Error

```typescript
FTReactNativeRUM.addError("error stack","error message");
```

#### Resource

```typescript
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

## Logging

```typescript
FTReactNativeLog.logging("info log content",FTLogStatus.info);
```

### Log Level

| Method Name | Meaning |
| --- | --- |
| FTLogStatus.info | info |
| FTLogStatus.warning | warning |
| FTLogStatus.error | error |
| FTLogStatus.critical | critical |
| FTLogStatus.ok | ok |

## Network Link Tracing

SDK 初始化 [Trace 配置](#trace-config) 时可以开启自动网络链路追踪，也支持用户自定义采集，自定义采集使用示例如下：

```typescript
  async getHttp(url:string){
    const key = Utils.getUUID();
    const traceHeader =await FTReactNativeTrace.getTraceHeader(key,url);
    
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

## User Information Binding and Unbinding

```typescript
FTMobileReactNative.bindRUMUserData('react-native-user')

FTMobileReactNative.unbindRUMUserData()
```

## Add Custom Tags {#user-global-context}

### Static Use

1. Use `react-native-config` to configure multiple environments and set the corresponding custom tag values in the different environments.

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

  
   FTReactNativeRUM.setConfig(rumConfig); 
});
```

### Dynamic Use

1. Get the stored custom tags when initializing the SDK through data persistence methods such as `AsyncStorage`.

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
 AsyncStorage.getItem("track_id",(error,result)=>{
        if (result === null){
          console.log('fail' + error);
        }else {
          console.log('success' + result);
          if( result != undefined){
            rumConfig.globalContext = {"track_id":result};
          }    
        }
        FTReactNativeRUM.setConfig(rumConfig); 
      })
```

2. Add or change custom tags anywhere to the file.

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('storage fail' + error);
    }else {
        console.log('storage success');
    }
})
```

3. Finally restart the application.

> Note:
> 
> 1. special key : track_id (configured in RUM, used for tracking function) 
> 1. When the user adds a custom tag through globalContext with the same tag as the SDK's own, the SDK's tag will override the user's settings, it is recommended that the tag name add the prefix of the project abbreviation, for example `df_tag_name`. Project use `key` value can be [query source code](https://github.com/DataFlux-cn/datakit-android/blob/dev/ft-sdk/src/main/java/com/ft/sdk/garble/utils/Constants. java).

## Frequently Asked Questions

- [iOS Related](. /ios/app-access.md#FAQ)
- [Android Related](../android/app-access.md#FAQ)
