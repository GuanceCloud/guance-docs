# React Native Application Integration

---

## Prerequisites

???+ warning "Note"

    If the [RUM Headless](../../dataflux-func/headless.md) service has been enabled, the prerequisites have been automatically configured, and you can directly integrate the application.

- Install [DataKit](../../datakit/datakit-install.md);  
- Configure [RUM Collector](../../integrations/rum.md);
- DataKit should be configured as [publicly accessible on the internet and with the IP geolocation information database installed](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

???+ warning "Note"

    The current React Native version only supports Android and iOS platforms temporarily.

1. Go to **User Analysis > Create > React Native**;
2. Enter the application name;
3. Input the application ID;
4. Select the application integration method:

    - Public DataWay: Directly receives RUM data without installing the DataKit collector.
    - Local Environment Deployment: Receives RUM data after meeting the prerequisites.


## Installation {#install}

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo Address**: [https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

In the project path, run the command in the terminal:

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

**Additional Configuration for Android Integration:**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect App startup events and network request data, as well as Android Native related events (page transitions, click events, Native network requests, WebView data).
* Note that it is necessary to configure <<< custom_key.brand_name >>> Android Maven repository address simultaneously in Gradle, both Plugin and AAR are required. For configuration details, see the example [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle) configuration.

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
| datakitUrl | string | Yes | Datakit access URL address, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529, note: the device where SDK is installed must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| datawayUrl | string | Yes | Dataway access URL address, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528, note: the device where SDK is installed must be able to access this address. **Note: Choose one between datakit and dataway configurations** |
| clientToken | string | Yes | Authentication token, needs to be used together with datawayUrl |
| debug | boolean | No | Set whether to allow printing logs, default `false` |
| env | string | No | Environment configuration, default `prod`, any character, suggest using a single word, e.g., `test` etc. |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. Note: Only one of env and envType needs to be configured |
| service | string | No | Set the name of the associated business or service, affects the service field data in Logs and RUM. Default: `df_rum_ios`, `df_rum_android` |
| autoSync | boolean | No | Whether to enable automatic synchronization. Default `true` |
| syncPageSize | number | No | Set the number of entries per synchronization request. Range [5,]. Note: The larger the number of request entries, the more computing resources will be used for data synchronization |
| syncSleepTime | number | No | Set the intermittent time for synchronization. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | It is recommended to enable when coexisting with web data. This configuration is used to handle web data type storage compatibility issues. Default enabled in versions 0.3.12 and above |
| globalContext | object | No | Add custom labels. Refer to [here](../android/app-access.md#key-conflict) for adding rules |
| compressIntakeRequests | boolean | No | Set whether to compress synchronized data, default disabled |
| enableLimitWithDbSize | boolean | No | Enable using db size limit, default 100MB, unit Byte, the larger the database, the greater the disk pressure, default not enabled.<br>**Note:** After enabling, the Log configuration `logCacheLimitCount` and RUM configuration `rumCacheLimitCount` will be invalid. Supported by SDK versions 0.3.10 and above |
| dbCacheLimit | number | No | DB cache limit size. Range [30MB,), default 100MB, unit byte, supported by SDK versions 0.3.10 and above |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported by SDK versions 0.3.10 and above |

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
| androidAppId | string | Yes | app_id, applied for in the user analysis monitoring console |
| iOSAppId | string | Yes | app_id, applied for in the user analysis monitoring console |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default value is 1. Scope: all View, Action, LongTask, Error data under the same session_id |
| enableAutoTrackUserAction | boolean | No | Whether to automatically collect `React Native` component click events, after enabling, you can set actionName via `accessibilityLabel`, refer to [here](#rum-action) for more customization options |
| enableAutoTrackError | boolean | No | Whether to automatically collect `React Native` Errors, default `false` |
| enableNativeUserAction | boolean | No | Whether to track `Native Action`, such as native `Button` click events and app startup events, default `false` |
| enableNativeUserView | boolean | No | Whether to perform `Native View` automatic tracking, it is recommended to turn off for pure `React Native` applications, default `false` |
| enableNativeUserResource | boolean | No | Whether to start `Native Resource` automatic tracking, since React-Native network requests on iOS and Android ends use system APIs, after enabling `enableNativeUserResource`, all resource data can be collected together. Default `false` |
| errorMonitorType |enum ErrorMonitorType | No | Set auxiliary monitoring information, add additional monitoring data to `RUM` Error data, `ErrorMonitorType.battery` for battery level, `ErrorMonitorType.memory` for memory usage, `ErrorMonitorType.cpu` for CPU usage, default not enabled |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | In the View lifecycle, add monitoring data, `DeviceMetricsMonitorType.battery` (only Android) monitors the highest output current situation on the current page, `DeviceMetricsMonitorType.memory` monitors the current application's memory usage, `DeviceMetricsMonitorType.cpu` monitors CPU jitter times, `DeviceMetricsMonitorType.fps` monitors screen frame rate, default not enabled                                           |
| detectFrequency | enum DetectFrequency | No | Sampling frequency for view performance monitoring, default `DetectFrequency.normal` |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain name of the request. Scope: only affects the default collection when `enableNativeUserResource` is `true`. iOS: Supported under `>= iOS 13`. Android: Okhttp has an IP caching mechanism for the same domain, for the same `OkhttpClient`, it generates only once if the server IP does not change. |
| globalContext | object | No | Add custom tags, used to distinguish user monitoring data sources, if tracking function is needed, then parameter `key` is `track_id`, `value` is any number, refer to [here](../android/app-access.md#key-conflict) for notes on adding rules |
| enableTrackNativeCrash | boolean | No | Whether to enable monitoring of `Android Java Crash` and `OC/C/C++` crashes, default `false` |
| enableTrackNativeAppANR | boolean | No | Whether to enable `Native ANR` monitoring, default `false` |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze`, default `false` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` stalls, range [100,), unit milliseconds. iOS default 250ms, Android default 1000ms |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum number of local cached RUM entries [10_000,), default 100_000 |

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
| enableLinkRumData | boolean | No | Whether to associate with `RUM` |
| enableCustomLog | boolean | No | Whether to enable custom logs |
| logLevelFilters | Array<FTLogStatus> | No | Log level filtering |
| globalContext | NSDictionary | No | Add custom log tags, refer to [here](../android/app-access.md#key-conflict) for adding rules |
| logCacheLimitCount | number | No | Maximum number of locally cached log entries [1000,), the larger the log, the greater the disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the log discard rule when the log reaches the limit. Default `FTLogCacheDiscard.discard`, `discard` discards appended data, `discardOldest` discards old data |

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
| enableLinkRUMData | boolean | No | Whether to associate with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Whether to enable automatic tracing of native network requests for iOS NSURLSession and Android OKhttp (since `React Native` network requests on iOS and Android ends use system APIs, after enabling `enableNativeAutoTrace`, all `React Native` data can be traced together.) |

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

## RUM User Data Tracking

### View

When initializing the SDK [RUM Configuration](#rum-config), you can enable `enableNativeUserView` to automatically collect `Native Views`. Since `React Native Views` provide extensive libraries to create screen navigation, manual collection is supported by default. You can use the following methods to manually start and stop views.

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

  If you use `createNativeStackNavigator();` to create a native navigation stack, it is recommended to add `screenListeners` to start collection, which allows you to track page loading durations, as follows:

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

  If you do not use `createNativeStackNavigator();`, you need to add the automatic collection method in the `NavigationContainer` component, as follows:

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

For specific usage examples, refer to [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example).

##### Expo Router

If you use [Expo Router](https://expo.github.io/router/docs/), add the following method in the app/_layout.js file to collect data.

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

    // Export all the child routes in the most basic way.
    return <Slot />;
}
```

### Action {#rum-action}

When initializing the SDK [RUM Configuration](#rum-config), configure `enableAutoTrackUserAction` and `enableNativeUserAction` to enable automatic collection, or use the following methods for manual addition.

#### Usage Method

```typescript
/**
 * Start RUM Action. RUM binds the possible Resource, Error, LongTask events triggered by this Action.
 * Avoid multiple additions within 0.1 seconds. Only one Action can be associated with the same View at a time,
 * and the new Action will be discarded if the previous Action has not ended. Adding Actions with `addAction` method does not affect each other.
 * @param actionName action name
 * @param actionType action type
 * @param property event context (optional)
 * @returns a Promise.
 */
startAction(actionName:string,actionType:string,property?:object): Promise<void>;
 /**
  * Add Action event. Such data cannot be associated with Error, Resource, LongTask data, and there is no discard logic.
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

After enabling `enableAutoTrackUserAction`, the SDK will automatically collect click operations of components with the `onPress` attribute. If you want to perform some customized operations on top of automatic tracking, the SDK supports the following:

* Customize the `actionName` of a certain component's click event

  Set through the `accessibilityLabel` attribute

```typescript
  <Button title="Custom Action Name"
          accessibilityLabel="custom_action_name"
          onPress={()=>{
                console.log("btn click")
          }}
   />
```

* Do not collect the click event of a certain component

  Can be set by adding the `ft-enable-track` custom parameter, set value to `false`

```typescript
  <Button title="Action Click" 
          ft-enable-track="false"
          onPress={()=>{
                console.log('btn click');
          }}
  />
```

* Add extra attributes to the click event of a certain component

  Can be set by adding the `ft-extra-property` custom parameter, requiring **the value to be a JSON string**

```typescript
  <Button title="Action 添加额外属性"
          ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
          onPress={()=>{
                 console.log("btn click")
          }}
  />
```

### Error

When initializing the SDK [RUM Configuration](#rum-config), configure `enableAutoTrackError` to enable automatic collection, or use the following methods for manual addition.

#### Usage Method

```typescript
/**
 * Exception capture and log collection.
 * @param stack stack log
 * @param message error message
 * @param property event context (optional)
 * @returns a Promise.
 */
addError(stack: string, message: string,property?:object): Promise<void>;
/**
 * Exception capture and log collection.
 * @param type error type
 * @param stack stack log
 * @param message error message
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

When initializing the SDK [RUM Configuration](#rum-config), configure `enableNativeUserResource` to enable automatic collection, or use the following methods for manual addition.

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

> Currently, log content is limited to 30 KB, and characters exceeding this limit will be truncated.
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

## Tracer Network Link Tracing

When initializing the SDK [Trace Configuration](#trace-config), automatic network link tracing can be enabled, and user-defined collection is also supported. The usage method and example are as follows:

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

## Binding and Unbinding User Information

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

## Closing the SDK

Use `FTMobileReactNative` to close the SDK.

### Usage Method

```typescript
/**
 * Close running objects inside the SDK
 */
shutDown():Promise<void>
```

### Usage Example

```typescript
FTMobileReactNative.shutDown();
```

## Clearing Cached Data in the SDK

Use `FTMobileReactNative` to clear uncached data that has not been reported.

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

## Active Data Synchronization

When `FTMobileConfig.autoSync` is configured as `true`, no additional actions are required; the SDK will synchronize data automatically.

When `FTMobileConfig.autoSync` is configured as `false`, you need to actively trigger the data synchronization method for data synchronization.

### Usage Method

```typescript
/**
 * Actively synchronize data. When `FTMobileConfig.autoSync=false`, this method needs to be triggered actively for data synchronization.
 * @returns a Promise.
 */
flushSyncData():Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.flushSyncData();
```

## Adding Custom Tags {#user-global-context}

### Usage Method

```typescript
/**
 * Add custom global parameters. Applied to RUM, Log data
 * @param context Custom global parameters.
 * @returns a Promise.
 */
appendGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM global parameters. Applied to RUM data
 * @param context Custom RUM global parameters.
 * @returns a Promise.
 */
appendRUMGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM, Log global parameters. Applied to Log data
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

## Uploading Symbol Files {#source_map}

### Automatic Packaging of Symbol Files

#### Adding Automatic Symbol File Packaging Script

Script Tool: [cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` is a script tool that helps configure automatic acquisition of React Native and Native sourcemaps during release builds and packages them into zip files.

Use the local file method to add it to the `package.json` development dependencies 

For example: Place `cloudcare-react-native-mobile-cli.tgz` in the React Native project directory

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli":"file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

Execute `yarn install` after adding

**Note: Android environment requires adding Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting), version requirement: >=1.3.4**

Add the `Plugin` usage and parameter settings in the `build.gradle` file of the main module `app` of the project

```java
apply plugin: 'ft-plugin'
FTExt {
    //showLog = true
    autoUploadMap = true
    autoUploadNativeDebugSymbol = true
    generateSourceMapOnly = true
}
```

#### Execute Configuration Command

In the React Native project directory, execute the terminal command `yarn ft-cli setup` to automatically acquire React Native and Native sourcemaps during release builds and package them as zip files. The following logs indicate successful settings.

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

**After performing the release build, the zip file packaging address:**

iOS: Inside the iOS folder (./ios/sourcemap.zip)

Android: RN project directory (./sourcemap.zip) 

### Manual Packaging of Symbol Files

[React Native Zip Package Packaging Instructions](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### Upload

[File Upload and Deletion](../sourcemap/set-sourcemap.md/#upload)

## WebView Data Monitoring

To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) on the pages accessed by WebView.

## Custom Tag Usage Examples {#track}

### Compilation Configuration Method

1. Use `react-native-config` to configure multiple environments, setting corresponding custom tag values in different environments.

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

### Runtime Read/Write File Method

1. Through data persistence methods, such as `AsyncStorage`, obtain stored custom tags when initializing the SDK.

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
          console.log('Failed to retrieve' + error);
        }else {
          console.log('Retrieved successfully' + result);
          if( result != undefined){
            rumConfig.globalContext = {"track_id":result};
          }
        }
        resolve(FTReactNativeRUM.setConfig(rumConfig));
      })
     });
```

2. Add or change custom tags to the file at any point.

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('Failed to store' + error);
    }else {
        console.log('Stored successfully');
    }
})
```

3. Finally, restart the application to take effect.

### SDK Runtime Addition

After the SDK initialization is completed, use `FTReactNativeRUM.appendGlobalContext(globalContext)`、`FTReactNativeRUM.appendRUMGlobalContext(globalContext)`、`FTReactNativeRUM.appendLogGlobalContext(globalContext)` to dynamically add tags. After setting, it will take effect immediately. Subsequently, the data reported by RUM or Log will automatically add tag data. This usage method is suitable for scenarios where data needs to be obtained with delay, such as when tag data needs to be obtained via network requests.

```typescript
//SDK initialization pseudocode, retrieve
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info:Info){
	let  globalContext = {"delay_key":info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Native and React Native Hybrid Development {#hybrid}

If your project is natively developed and some pages or business processes are implemented using React Native, follow these steps for SDK installation and initialization configuration:

* Installation: [Installation](#install) method remains unchanged

* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) to initialize in the native project

* React Native Configuration:

    > RN SDK 0.3.11 support

    There is no need for initialization configuration on the React Native side. If you need to automatically collect `React Native Error` and `React Native Action`, follow the methods below:

    ```typescript
    import {FTRumActionTracking,FTRumErrorTracking} from '@cloudcare/react-native-mobile';
    // Enable automatic collection of react-native component clicks
    FTRumActionTracking.startTracking();
    // Enable automatic collection of react-native Errors
    FTRumErrorTracking.startTracking();
    ```

* Native Project Configuration:

    > RN SDK 0.3.11 support

    When enabling RUM Resource automatic collection, you need to filter out React Native symbolization calls and Expo log calls that only occur in the development environment. The method is as follows:

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
        #endif
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

For specific usage examples, refer to [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example).

## Publish Package Related Configurations
### Android
* [Android R8/Proguard Configurations](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)

## Common Issues

- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Other Related](../ios/app-access.md#FAQ)
- [Android Other Related](../android/app-access.md#FAQ)