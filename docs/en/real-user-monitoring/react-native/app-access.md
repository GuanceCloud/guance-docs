# React Native App Integration

---

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites are automatically configured, and you can directly integrate the app.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit is configured to be [publicly accessible on the internet and with the IP geolocation information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## App Integration

???+ warning "Note"

    The current React Native version supports only Android and iOS platforms.

1. Go to **User Analysis > Create > React Native**;
2. Input the app name;
3. Input the app ID;
4. Select the integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.  
    - Local Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#install}

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo Address**: [https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

Run the following command in the project path from the terminal:

```bash
npm install @cloudcare/react-native-mobile
```

This will add a line like this to the package.json of the package:

```json
"dependencies": {    
   "@cloudcare/react-native-mobile: [lastest_version],
   ···
}
```

**Additional Android Integration Configuration:**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and network request data, as well as Android Native related events (page transitions, click events, Native network requests, WebView data).
* Note that you need to configure the <<< custom_key.brand_name >>> Android Maven repository address simultaneously in Gradle for both Plugin and AAR. Refer to the [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle) configuration in the example.

Now in your code, you can use:

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

## SDK Initialization

### Basic Configuration {#base-setting}

```typescript
 //Local environment deployment, Datakit deployment
let config: FTMobileConfig = {
    datakitUrl: datakitUrl,
  };

 //Use public DataWay
 let config: FTMobileConfig = {
    datawayUrl: datawayUrl,
    clientToken: clientToken
  };
await FTMobileReactNative.sdkConfig(config);

```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| datakitUrl | string | Yes | Datakit access URL address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529. Note: Devices with SDK installed must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| datawayUrl | string | Yes | Dataway access URL address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528. Note: Devices with SDK installed must be able to access this address. **Note: Choose either datakit or dataway configuration** |
| clientToken | string | Yes | Authentication token, must be used together with datawayUrl |
| debug | boolean | No | Set whether to allow printing logs, default `false` |
| env | string | No | Environment configuration, default `prod`, any character, it is recommended to use single words, such as `test` etc. |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. Note: Only one of env or envType needs to be configured |
| service | string | No | Set the name of the business or service, affecting the service field data in Logs and RUM. Default: `df_rum_ios`, `df_rum_android` |
| autoSync | boolean | No | Whether to enable automatic synchronization. Default `true` |
| syncPageSize | number | No | Set the number of entries for synchronization requests. Range [5,). Note: The larger the number of entries requested, the more computational resources data synchronization will consume |
| syncSleepTime | number | No | Set the intermittent time for synchronization. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | It is recommended to enable when coexistence with web data is needed. This configuration is used to handle web data type storage compatibility issues. Versions 0.3.12 and later default to enabling |
| globalContext | object | No | Add custom tags. Refer to the rules [here](../android/app-access.md#key-conflict) |
| compressIntakeRequests | boolean | No | Set whether to compress synchronized data, default off |
| enableLimitWithDbSize | boolean | No | Enable using db to limit data size, default 100MB, unit Byte, the larger the database, the greater the disk pressure, default not enabled.<br>**Note:** After enabling, Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` will become invalid. SDK versions 0.3.10 and above support this parameter |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte, SDK versions 0.3.10 and above support this parameter |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. SDK versions 0.3.10 and above support this parameter |

### RUM Configuration {#rum-config}

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

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| androidAppId | string | Yes | app_id, applied through the User Analysis console |
| iOSAppId | string | Yes | app_id, applied through the User Analysis console |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope: All View, Action, LongTask, Error data under the same session_id |
| enableAutoTrackUserAction | boolean | No | Whether to automatically collect `React Native` component click events, enable to set actionName via `accessibilityLabel`, refer to [here](#rum-action) for more customization |
| enableAutoTrackError | boolean | No | Whether to automatically collect `React Native` Errors |
| enableNativeUserAction | boolean | No | Whether to perform `Native Action` tracing, native `Button` click events, app startup events, default is `false` |
| enableNativeUserView | boolean | No | Whether to perform `Native View` automatic tracing, pure `React Native` applications are recommended to turn this off, default is `false` |
| enableNativeUserResource | boolean | No | Whether to start `Native Resource` automatic tracing, since React-Native's network requests on iOS and Android use system APIs, enabling `enableNativeUserResource` allows all resource data to be collected. |
| errorMonitorType |enum ErrorMonitorType | No | Supplementary error event monitoring types |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | Monitoring type for view performance                                           |
| detectFrequency | enum DetectFrequency | No | Sampling period for view performance monitoring |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain name. Scope: Only affects the default collection when `enableNativeUserResource` is set to true. iOS: Supported under `>= iOS 13`. Android: Okhttp maintains an IP cache mechanism for the same domain, so only one generation occurs if the server IP does not change under the same `OkhttpClient`. |
| globalContext | object | No | Add custom tags, used to distinguish user monitoring data sources. If tracking functionality is required, the parameter `key` should be `track_id` and `value` can be any number. Refer to [here](../android/app-access.md#key-conflict) for additional notes on adding rules |
| enableTrackNativeCrash | boolean | No | Whether to collect `Native Crash` |
| enableTrackNativeAppANR | boolean | No | Whether to collect `Native ANR`                                        |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. iOS default 250ms, Android default 1000ms |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum local cache count limit for RUM entries [10_000,), default 100_000 |

### Log Configuration {#log-config}

```typescript
let logConfig: FTLogConfig = {
      enableCustomLog: true,
      enableLinkRumData: true,
    };
await FTReactNativeLog.logConfig(logConfig);
```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1.   |
| enableLinkRumData | boolean | No | Whether to link with `RUM` |
| enableCustomLog | boolean | No | Whether to enable custom logging |
| logLevelFilters | Array<FTLogStatus> | No | Log level filtering |
| globalContext | NSDictionary | No | Add custom log tags, refer to the rules [here](../android/app-access.md#key-conflict) |
| logCacheLimitCount | number | No | Maximum local cache count limit for log entries [1000,), larger logs mean higher disk caching pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the log discard rule when reaching the limit. Default `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |

### Trace Configuration {#trace-config}

```typescript
 let traceConfig: FTTractConfig = {
      enableNativeAutoTrace: true, 
    };
await FTReactNativeTrace.setConfig(traceConfig);
```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1.  |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace` |
| enableLinkRUMData | boolean | No | Whether to link with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Whether to enable native network automatic tracing iOS NSURLSession ,Android OKhttp (Since `React Native`'s network requests on iOS and Android use system APIs, enabling `enableNativeAutoTrace` allows all `React Native` data to be traced.) |

> **Note:**
>
> * Please complete the SDK initialization before registering the App in the top-level `index.js` file to ensure that the SDK is fully ready before calling any other SDK methods.
> * Perform RUM, Log, and Trace configurations after completing the basic configuration.
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

## RUM User Data Tracing

### View

When initializing the SDK [RUM Configuration](#rum-config), you can configure `enableNativeUserView` to enable automatic collection of `Native Views`, `React Native Views` since React Native provides extensive libraries to create screen navigation, manual collection is supported by default. You can use the following methods to manually start and stop views.

#### Custom View

##### Usage Method

```typescript
/**
 * View loading duration.
 * @param viewName view name
 * @param loadTime view loading duration
 * @returns a Promise.
 */
onCreateView(viewName:string,loadTime:number): Promise<void>;
/**
 * Start view.
 * @param viewName interface name
 * @param property event context (optional)
 * @returns a Promise.
 */
startView(viewName: string, property?: object): Promise<void>;
/**
 * Stop view.
 * @param property event context (optional)
 * @returns a Promise.
 */
stopView(property?:object): Promise<void>;
```

##### Usage Example

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

#### Automatic Collection of React Native Views

**If you use `react-native-navigation`, `react-navigation`, or `Expo Router` navigation components in React Native, you can refer to the following methods for automatic collection of `React Native Views`:**

##### react-native-navigation

Add the [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNativeNavigationTracking.tsx) file from the example to your project;

Call the `FTRumReactNativeNavigationTracking.startTracking()` method to start collection.

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

Add the [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNavigationTracking.tsx) file from the example to your project;

* Method One:

  If you use `createNativeStackNavigator();` to create a native navigation stack, it is recommended to add `screenListeners` to start collection, allowing page loading durations to be recorded, as shown below:

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

* Method Two:

  If `createNativeStackNavigator();` is not used, you need to add the automatic collection method inside the `NavigationContainer` component, as follows:

  **Note: This method cannot collect page loading durations**
  
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

Refer to the [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example) for specific usage examples.

##### Expo Router

If you are using [Expo Router](https://expo.github.io/router/docs/), add the following method in the app/_layout.js file for data collection.

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

    // Export all child routes in the most basic way.
    return <Slot />;
}
```

### Action {#rum-action}

When initializing the SDK [RUM Configuration](#rum-config), configure `enableAutoTrackUserAction` and `enableNativeUserAction` to enable automatic collection, or manually add through the following methods.

#### Usage Method

```typescript
/**
 * Start RUM Action. RUM binds possible Resource, Error, LongTask events triggered by this Action.
 * Avoid multiple additions within 0.1 seconds. Only one Action can be associated with the same View at the same time, 
 * while the previous Action is not ended, the new Action will be discarded. Adding Actions with `addAction` method does not affect each other.
 * @param actionName action name
 * @param actionType action type
 * @param property event context (optional)
 * @returns a Promise.
 */
startAction(actionName:string,actionType:string,property?:object): Promise<void>;
 /**
  * Add Action event. Such data cannot associate Error, Resource, LongTask data, there is no discard logic.
  * @param actionName action name
  * @param actionType action type
  * @param property event context (optional)
  * @returns a Promise.
  */
addAction(actionName:string,actionType:string,property?:object): Promise<void>;
```

#### Code Example

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.startAction('actionName','actionType',{'custom.foo': 'something'});

FTReactNativeRUM.addAction('actionName','actionType',{'custom.foo': 'something'});
```

**More Customized Collection Operations**

After enabling `enableAutoTrackUserAction`, the SDK automatically collects click operations for components with the `onPress` attribute. If you want to perform some customized actions based on automatic tracking, the SDK supports the following operations:

* Customize the `actionName` for a component's click event

  Set through the `accessibilityLabel` attribute

```typescript
  <Button title="Custom Action Name"
          accessibilityLabel="custom_action_name"
          onPress={()=>{
                console.log("btn click")
          }}
   />
```

* Do not collect click events for a certain component

  Can be set by adding the `ft-enable-track` custom parameter, setting its value to `false`

```typescript
  <Button title="Action Click" 
          ft-enable-track="false"
          onPress={()=>{
                console.log('btn click');
          }}
  />
```

* Add extra attributes to the click event of a certain component

  Can be set by adding the `ft-extra-property` custom parameter, requiring **JSON string value**

```typescript
  <Button title="Action 添加额外属性"
          ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
          onPress={()=>{
                 console.log("btn click")
          }}
  />
```

### Error

When initializing the SDK [RUM Configuration](#rum-config), configure `enableAutoTrackError` to enable automatic collection, or manually add through the following methods.

#### Usage Method

```typescript
/**
 * Exception capture and log collection.
 * @param stack stack log
 * @param message error information
 * @param property event context (optional)
 * @returns a Promise.
 */
addError(stack: string, message: string,property?:object): Promise<void>;
/**
 * Exception capture and log collection.
 * @param type error type
 * @param stack stack log
 * @param message error information
 * @param property event context (optional)
 * @returns a Promise.
 */
addErrorWithType(type:string,stack: string, message: string,property?:object): Promise<void>;
```

#### Usage Example

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.addError("error stack","error message",{'custom.foo': 'something'});

FTReactNativeRUM.addErrorWithType("custom_error", "error stack", "error message",{'custom.foo': 'something'});
```



### Resource

When initializing the SDK [RUM Configuration](#rum-config), configure `enableNativeUserResource` to enable automatic collection, or manually add through the following methods.

#### Usage Method

```typescript
/**
 * Start resource request.
 * @param key unique id
 * @param property event context (optional)
 * @returns a Promise.
 */
startResource(key: string,property?:object): Promise<void>;
/**
 * End resource request.  
 * @param key unique id
 * @param property event context (optional)
 * @returns a Promise.
 */
stopResource(key: string,property?:object): Promise<void>;
/**
 * Send resource data metrics.
 * @param key unique id
 * @param resource resource data
 * @param metrics  resource performance data
 * @returns a Promise.
 */
addResource(key:string, resource:FTRUMResource,metrics?:FTRUMResourceMetrics):Promise<void>;
```

#### Usage Example

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



## Logger Log Printing

> Currently, log content is limited to 30 KB, exceeding characters will be truncated.
### Usage Method

```typescript
/**
 * Output log.
 * @param content log content
 * @param status  log status
 * @param property log context (optional)
 */
logging(content:String,logStatus:FTLogStatus|String,property?:object): Promise<void>;
```

### Usage Example

```typescript
import { FTReactNativeLog, FTLogStatus } from '@cloudcare/react-native-mobile';
// logStatus:FTLogStatus
FTReactNativeLog.logging("info log content",FTLogStatus.info);
// logStatus:string
FTReactNativeLog.logging("info log content","info");
```

### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| FTLogStatus.info | Information |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Critical |
| FTLogStatus.ok | Recovery |

## Tracer Network Trace Tracking

When initializing the SDK [Trace Configuration](#trace-config), you can enable automatic network trace tracking, also supporting user-defined collection. The usage method and examples are as follows:

### Usage Method

```typescript
/**
 * Get trace http request header data.
 * @param url Request address
 * @returns trace added request header parameters  
 * @deprecated use getTraceHeaderFields() replace.
 */
getTraceHeader(key:String, url: String): Promise<object>;
/**
 * Get trace http request header data.
 * @param url Request address
 * @returns trace added request header parameters  
 */
getTraceHeaderFields(url: String,key?:String): Promise<object>;
```

### Usage Example

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

## User Information Binding and Unbinding

### Usage Method

```typescript
/**
 * Bind user.
 * @param userId User ID.
 * @param userName User name.
 * @param userEmail User email
 * @param extra  Additional user information
 * @returns a Promise.
 */
bindRUMUserData(userId: string,userName?:string,userEmail?:string,extra?:object): Promise<void>;
/**
 * Unbind user.
 * @returns a Promise.
 */
unbindRUMUserData(): Promise<void>;
```

### Usage Example

```typescript
import {FTMobileReactNative} from '@cloudcare/react-native-mobile';

/**
 * Bind user.
 * @param userId User ID.
 * @param userName User name.
 * @param userEmail User email
 * @param extra  Additional user information
 * @returns a Promise.
*/
FTMobileReactNative.bindRUMUserData('react-native-user','uesr_name')
/**
 * Unbind user.
 * @returns a Promise.
*/
FTMobileReactNative.unbindRUMUserData()
```

## Close SDK

Use `FTMobileReactNative` to close the SDK.

### Usage Method

```typescript
/**
 * Shut down running objects within the SDK.
 */
shutDown():Promise<void>
```

### Usage Example

```typescript
FTMobileReactNative.shutDown();
```

## Clear SDK Cache Data

Use `FTMobileReactNative` to clear uncached data that has not been uploaded.

### Usage Method

```typescript
/**
 * Clear all data that has not yet been uploaded to the server.
 */
clearAllData():Promise<void>
```

### Usage Example

```typescript
/**
 * Clear all data that has not yet been uploaded to the server.
*/
FTMobileReactNative.clearAllData();
```

## Actively Synchronize Data

When the configuration `FTMobileConfig.autoSync` is set to `true`, no additional operations are required; the SDK will automatically synchronize data.

When the configuration `FTMobileConfig.autoSync` is set to `false`, you need to actively trigger the data synchronization method to synchronize data.

### Usage Method

```typescript
/**
 * Actively synchronize data, when the configuration `FTMobileConfig.autoSync=false`, you need to actively trigger this method to synchronize data.
 * @returns a Promise.
 */
flushSyncData():Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.flushSyncData();
```

## Add Custom Tags {#user-global-context}

### Usage Method

```typescript
/**
 * Add custom global parameters. Applies to RUM, Log data.
 * @param context Custom global parameters.
 * @returns a Promise.
 */
appendGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM global parameters. Applies to RUM data.
 * @param context Custom RUM global parameters.
 * @returns a Promise.
 */
appendRUMGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM, Log global parameters. Applies to Log data.
 * @param context Custom Log global parameters.
 * @returns a Promise.
 */
appendLogGlobalContext(context:object):Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.appendGlobalContext({'global_key':'global_value'});

FTMobileReactNative.appendRUMGlobalContext({'rum_key':'rum_value'});

FTMobileReactNative.appendLogGlobalContext({'log_key':'log_value'});
```

## Symbol File Upload {#source_map}

### Automatic Packaging of Symbol Files

#### Add Automatic Symbol File Packaging Script

Script tool: [cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` is a script tool that helps configure automatic acquisition of React Native and Native sourcemaps during release builds, packaging them into zip files.

Add it locally to `package.json` development dependencies.

For example: Place `cloudcare-react-native-mobile-cli.tgz` in the React Native project directory.

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli":"file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

Execute `yarn install` after adding.

**Note: Android environment requires adding Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting), version requirement: >=1.3.4**

Add `Plugin` usage and parameter settings in the main module `app`'s `build.gradle` file.

```java
apply plugin: 'ft-plugin'
FTExt {
    //showLog = true
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    generateSourceMapOnly = true
}
```

#### Execute Configuration Commands

Run the `yarn ft-cli setup` command in the React Native project directory to automatically acquire React Native and Native sourcemaps during release builds and package them into zip files. The following logs indicate successful setup.

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

**Zip file location after release build:**

iOS: Inside the iOS folder (./ios/sourcemap.zip)

Android: RN project directory (./sourcemap.zip)

### Manual Symbol File Packaging

[React Native Zip Package Packaging Instructions](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### Upload

[File Upload and Deletion](../sourcemap/set-sourcemap.md/#upload)

## WebView Data Monitoring

To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) in the pages accessed by WebView.

## Custom Tag Usage Examples {#track}

### Compile-time Configuration Method

1. Use `react-native-config` to configure multi-environments, setting corresponding custom tag values in different environments.

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

### Runtime File Read/Write Method

1. Through persistent data methods, such as `AsyncStorage`, obtain stored custom tags when initializing the SDK.

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

2. Add or modify custom tags to the file at any point.

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('存储失败' + error);
    }else {
        console.log('存储成功');
    }
})
```

3. Restart the application to take effect.

### SDK Runtime Addition

After the SDK initialization is completed, use `FTReactNativeRUM.appendGlobalContext(globalContext)`、`FTReactNativeRUM.appendRUMGlobalContext(globalContext)`、`FTReactNativeRUM.appendLogGlobalContext(globalContext)` to dynamically add tags, which will take effect immediately. Subsequently, RUM or Log data reported will automatically include tag data. This usage method is suitable for scenarios where data is delayed, such as tag data needing network requests.

```typescript
//SDK Initialization pseudocode, obtain
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info:Info){
	let  globalContext = {"delay_key":info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Native and React Native Hybrid Development {#hybrid}

If your project is natively developed with some pages or business processes implemented using React Native, the installation and initialization configuration method of the SDK is as follows:

* Installation: [Installation](#install) remains unchanged

* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) for initialization configuration in the native project.

* React Native Configuration:

    > RN SDK 0.3.11 supports

    No initialization configuration is required on the React Native side. If you need to automatically collect `React Native Error` and `React Native Action`, proceed as follows:

    ```typescript
    import {FTRumActionTracking,FTRumErrorTracking} from '@cloudcare/react-native-mobile';
    //Enable automatic collection of react-native control clicks
    FTRumActionTracking.startTracking();
    //Enable automatic collection of react-native Errors
    FTRumErrorTracking.startTracking();
    ```

* Native Project Configuration:

    > RN SDK 0.3.11 supports

    When enabling RUM Resource automatic collection, it is necessary to filter out React Native symbolization calls and Expo log calls that occur only in the development environment. Method as follows:

    **iOS**

    === "Objective-C"

        ```objective-c
        #import <FTMobileReactNativeSDK/FTReactNativeUtils.h>
        #import <FTMobileSDK/FTMobileAgent.h>
        
        FTRumConfig *rumConfig = [[FTRumConfig alloc]initWithAppid:rumAppId];
        rumConfig.enableTraceUserResource = YES;
        #if DEBUG
          rumConfig.resourceUrlHandler = ^BOOL(NSURL * _Nonnull url) {
            return [FTReactNativeUtils filterBlackResource:url];
          };
        #endif```objective-c
        ```
    === "Swift"
  
        ```swift
        import FTMobileReactNativeSDK
        import FTMobileSDK
         
        let rumConfig = FTRumConfig(appId: rumAppId)
        rumConfig.enableTraceUserResource = true
        #if DEBUG
        rumConfig.resourceUrlHandler = { (url: URL) -> Bool in
           return FTReactNativeUtils.filterBlackResource(url)
        }
        #endif
        ```
  
    **Android**
  
    === "Java"
  
        ```java
        import com.cloudcare.ft.mobile.sdk.tracker.reactnative.utils.ReactNativeUtils;
        import com.ft.sdk.FTRUMConfig;
      
        FTRUMConfig rumConfig = new FTRUMConfig().setRumAppId(rumAppId);
        rumConfig.setEnableTraceUserResource(true);
        if (BuildConfig.DEBUG) {
            rumConfig.setResourceUrlHandler(new FTInTakeUrlHandler() {
              @Override
              public boolean isInTakeUrl(String url) {
                return ReactNativeUtils.isReactNativeDevUrl(url);
              }
            });
          }
        ```
  
    === "Kotlin"
  
        ```kotlin
        import com.cloudcare.ft.mobile.sdk.tracker.reactnative.utils.ReactNativeUtils
        import com.ft.sdk.FTRUMConfig
        
        val rumConfig = FTRUMConfig().setRumAppId(rumAppId)
            rumConfig.isEnableTraceUserResource = true
            if (BuildConfig.DEBUG) {
              rumConfig.setResourceUrlHandler { url ->
                return@setResourceUrlHandler ReactNativeUtils.isReactNativeDevUrl(url)
            }
        ```

Refer to the [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example) for specific usage examples.

## Publish Package Related Configurations
### Android
* [Android R8/Prograd Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)

## Common Issues

- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Other Related](../ios/app-access.md#FAQ)
- [Android Other Related](../android/app-access.md#FAQ)