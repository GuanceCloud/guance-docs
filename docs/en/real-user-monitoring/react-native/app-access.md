# React Native Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites have been automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [accessible via the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

**Note**: The current React Native version supports only Android and iOS platforms.

1. Enter the application name;
2. Enter the application ID;
3. Choose the integration method.

![](../img/image_13.png)

## Installation {#install}

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo Repository**: [https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

In the project directory, run the following command in the terminal:

```bash
npm install @cloudcare/react-native-mobile
```

This will add the following line to your `package.json`:

```json
"dependencies": {    
   "@cloudcare/react-native-mobile": "[lastest_version]",
   ···
}
```

**Additional Configuration for Android:**

* Configure the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect app startup events, network request data, and Android Native-related events (page transitions, click events, native network requests, WebView data).
* Note that you need to configure the <<< custom_key.brand_name >>> Android Maven repository address in Gradle as well. Both the Plugin and AAR are required. Refer to the configuration details in the [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle) of the example.

Now you can use the following in your code:

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
// Local environment deployment, Datakit deployment
let config: FTMobileConfig = {
    datakitUrl: datakitUrl,
  };

// Use public DataWay
let config: FTMobileConfig = {
    datawayUrl: datawayUrl,
    clientToken: clientToken
  };
await FTMobileReactNative.sdkConfig(config);
```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| datakitUrl | string | Yes | Datakit access URL, e.g., [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529. **Note:** Only one of datakit or dataway configurations should be used. |
| datawayUrl | string | Yes | Dataway access URL, e.g., [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528. **Note:** Only one of datakit or dataway configurations should be used. |
| clientToken | string | Yes | Authentication token, must be used with datawayUrl |
| debug | boolean | No | Enable log printing, default `false` |
| env | string | No | Environment configuration, default `prod`, any single word, e.g., `test` |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. Note: Only one of env or envType needs to be configured |
| service | string | No | Set the name of the associated business or service, affecting the `service` field in Log and RUM data. Default: `df_rum_ios`, `df_rum_android` |
| autoSync | boolean | No | Enable automatic synchronization, default `true` |
| syncPageSize | number | No | Set the number of entries per sync request. Larger numbers mean more computational resources are used for data synchronization |
| syncSleepTime | number | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Enable if web data compatibility is needed. This setting handles web data type storage issues. Enabled by default after version 0.3.12 |
| globalContext | object | No | Add custom tags. Refer to [here](../android/app-access.md#key-conflict) for rules |
| compressIntakeRequests | boolean | No | Compress sync data |
| enableLimitWithDbSize | boolean | No | Limit data size using db, default 100MB. Larger databases increase disk pressure. Disabled by default.<br>**Note:** Enabling this makes `logCacheLimitCount` and `rumCacheLimitCount` ineffective. Supported in SDK versions 0.3.10 and above |
| dbCacheLimit | number | No | DB cache limit size. Range [30MB,), default 100MB, unit byte. Supported in SDK versions 0.3.10 and above |
| dbDiscardStrategy | string | No | Set the data discard rule in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported in SDK versions 0.3.10 and above |

### RUM Configuration {#rum-config}

```typescript
let rumConfig: FTRUMConfig = {
    androidAppId: Config.ANDROID_APP_ID,
    iOSAppId: Config.IOS_APP_ID,
    enableAutoTrackUserAction: true,
    enableAutoTrackError: true,
    enableNativeUserAction: true,
    enableNativeUserView: false,
    enableNativeUserResource: true,
    errorMonitorType: ErrorMonitorType.all,
    deviceMonitorType: DeviceMetricsMonitorType.all,
    detectFrequency: DetectFrequency.rare
  };

await FTReactNativeRUM.setConfig(rumConfig);
```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| androidAppId | string | Yes | App ID, obtained from the application access monitoring console |
| iOSAppId | string | Yes | App ID, obtained from the application access monitoring console |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| enableAutoTrackUserAction | boolean | No | Automatically track `React Native` component click events. After enabling, you can set `actionName` using `accessibilityLabel`. Refer to [here](#rum-action) for more customization |
| enableAutoTrackError | boolean | No | Automatically track `React Native` Errors |
| enableNativeUserAction | boolean | No | Track `Native Action`, such as button clicks and app startup events, default `false` |
| enableNativeUserView | boolean | No | Automatically track `Native View`. Suggest disabling for pure `React Native` apps, default `false` |
| enableNativeUserResource | boolean | No | Automatically track `Native Resource`. Since React-Native's network requests on iOS and Android use system APIs, enabling this allows all resource data to be collected. |
| errorMonitorType | enum ErrorMonitorType | No | Additional error event monitoring type |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | View performance monitoring type |
| detectFrequency | enum DetectFrequency | No | View performance monitoring sampling period |
| enableResourceHostIP | boolean | No | Collect the IP address of the requested domain. Affects only `enableNativeUserResource` when set to true. Supported on iOS >= iOS 13. On Android, Okhttp caches IP addresses for the same domain, so it generates only once if the server IP does not change under the same `OkhttpClient`. |
| globalContext | object | No | Add custom tags for user monitoring data sources. If using tracking features, set `key` to `track_id` and `value` to any value. Refer to [here](../android/app-access.md#key-conflict) for rules |
| enableTrackNativeCrash | boolean | No | Collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. Default 250ms on iOS, 1000ms on Android |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum local cached RUM entry count [10_000,), default 100_000 |

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
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1 |
| enableLinkRumData | boolean | No | Link with `RUM` |
| enableCustomLog | boolean | No | Enable custom logs |
| logLevelFilters | Array<FTLogStatus> | No | Log level filters |
| globalContext | NSDictionary | No | Add custom log tags. Refer to [here](../android/app-access.md#key-conflict) for rules |
| logCacheLimitCount | number | No | Maximum local cached log entry count [1000,), larger logs increase disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the discard rule for logs when the limit is reached. Default `FTLogCacheDiscard.discard`, `discard` discards new data, `discardOldest` discards old data |

### Trace Configuration {#trace-config}

```typescript
 let traceConfig: FTTractConfig = {
      enableNativeAutoTrace: true, 
    };
await FTReactNativeTrace.setConfig(traceConfig);
```

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1 |
| traceType | enum TraceType | No | Trace type, default `TraceType.ddTrace` |
| enableLinkRUMData | boolean | No | Link with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Enable automatic tracing of native network requests (iOS NSURLSession, Android OKhttp). Since `React Native`'s network requests on iOS and Android use system APIs, enabling this will also trace all `React Native` data |

> **Note:**
>
> * Ensure SDK initialization is completed before registering your App in the top-level `index.js` file to ensure the SDK is fully ready before calling any other SDK methods.
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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection of `Native View` by configuring `enableNativeUserView`. For `React Native View`, since React Native provides extensive libraries for screen navigation, manual collection is supported by default. You can manually start and stop views using the following methods.

#### Custom View

##### Usage Methods

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
 * @param viewName view name
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

#### Automatic Collection of React Native View

**If you are using `react-native-navigation`, `react-navigation`, or `Expo Router` navigation components in React Native, you can refer to the following methods for automatic collection of `React Native View`:**

##### react-native-navigation

Add the [FTRumReactNavigationTracking.tsx](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/src/FTRumReactNativeNavigationTracking.tsx) file from the example to your project;

Call the `FTRumReactNativeNavigationTracking.startTracking()` method to start collection.

```typescript
import { FTRumReactNativeNavigationTracking } from './FTRumReactNativeNavigationTracking';

function startReactNativeNavigation() {
  FTRumReactNativeNavigationTracking.startTracking();
  registerScreens(); // Navigation registerComponent
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

  If you use `createNativeStackNavigator();` to create a native navigation stack, it is recommended to add `screenListeners` to start collection. This way, page loading durations can be tracked. Specific usage is as follows:

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

  If not using `createNativeStackNavigator();`, you need to add the automatic collection method in the `NavigationContainer` component as follows:

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

If you are using [Expo Router](https://expo.github.io/router/docs/), add the following method in the `app/_layout.js` file to collect data.

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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableAutoTrackUserAction` and `enableNativeUserAction`. You can also manually add actions using the following methods.

#### Usage Methods

```typescript
/**
 * Start RUM Action. RUM binds this Action to possible triggered Resource, Error, LongTask events.
 * Avoid adding multiple times within 0.1 seconds. Only one Action can be associated with a View at the same time, and new Actions will be discarded if the previous Action has not ended. Adding Actions using `addAction` does not affect this behavior.
 * @param actionName action name
 * @param actionType action type
 * @param property event context (optional)
 * @returns a Promise.
 */
startAction(actionName:string,actionType:string,property?:object): Promise<void>;
 /**
  * Add Action event. This data cannot be associated with Error, Resource, LongTask data, and there is no discard logic.
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

**More Custom Collection Operations**

After enabling `enableAutoTrackUserAction`, the SDK will automatically collect click operations of components with an `onPress` attribute. If you want to perform some custom operations based on automatic tracking, the SDK supports the following operations:

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

* Do not collect a component's click event

  Set the custom parameter `ft-enable-track` to `false`

```typescript
  <Button title="Action Click" 
          ft-enable-track="false"
          onPress={()=>{
                console.log('btn click');
          }}
  />
```

* Add extra attributes to a component's click event

  Set the custom parameter `ft-extra-property` to a JSON string

```typescript
  <Button title="Action Add Extra Property"
          ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
          onPress={()=>{
                 console.log("btn click")
          }}
  />
```

### Error

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableAutoTrackError`. You can also manually add errors using the following methods.

#### Usage Methods

```typescript
/**
 * Capture exceptions and log them.
 * @param stack stack trace
 * @param message error message
 * @param property event context (optional)
 * @returns a Promise.
 */
addError(stack: string, message: string,property?:object): Promise<void>;
/**
 * Capture exceptions and log them.
 * @param type error type
 * @param stack stack trace
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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableNativeUserResource`. You can also manually add resource data using the following methods.

#### Usage Methods

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
 * @param metrics resource performance data
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

## Logger Logging

> Currently, log content is limited to 30 KB, and any excess characters will be truncated.
### Usage Methods

```typescript
/**
 * Output log.
 * @param content log content
 * @param status log status
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
| FTLogStatus.info | Info |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Critical |
| FTLogStatus.ok | Recovered |

## Tracer Network Tracing

When initializing the SDK [Trace Configuration](#trace-config), you can enable automatic network tracing. It also supports user-defined collection. The usage methods and examples are as follows:

### Usage Methods

```typescript
/**
 * Get trace HTTP request header data.
 * @param url Request URL
 * @returns Trace-added request headers
 * @deprecated Use getTraceHeaderFields() instead.
 */
getTraceHeader(key:String, url: String): Promise<object>;
/**
 * Get trace HTTP request header data.
 * @param url Request URL
 * @returns Trace-added request headers
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

### Usage Methods

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
FTMobileReactNative.bindRUMUserData('react-native-user','user_name')
/**
 * Unbind user.
 * @returns a Promise.
*/
FTMobileReactNative.unbindRUMUserData()
```

## Closing the SDK

Use `FTMobileReactNative` to close the SDK.

### Usage Methods

```typescript
/**
 * Close running objects within the SDK
 */
shutDown():Promise<void>
```

### Usage Example

```typescript
FTMobileReactNative.shutDown();
```

## Clearing SDK Cache Data

Use `FTMobileReactNative` to clear unreported cache data.

### Usage Methods

```typescript
/**
 * Clear all unsent data.
 */
clearAllData():Promise<void>
```

### Usage Example

```typescript
/**
 * Clear all unsent data.
*/
FTMobileReactNative.clearAllData();
```

## Active Data Sync

When `FTMobileConfig.autoSync` is set to `true`, no additional operations are needed; the SDK will automatically synchronize data.

When `FTMobileConfig.autoSync` is set to `false`, you need to actively trigger the data sync method to synchronize data.

### Usage Methods

```typescript
/**
 * Actively sync data. When `FTMobileConfig.autoSync=false`, this method needs to be triggered manually to sync data.
 * @returns a Promise.
 */
flushSyncData():Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.flushSyncData();
```

## Adding Custom Tags {#user-global-context}

### Usage Methods

```typescript
/**
 * Add custom global parameters. Applied to RUM and Log data.
 * @param context Custom global parameters.
 * @returns a Promise.
 */
appendGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM global parameters. Applied to RUM data.
 * @param context Custom RUM global parameters.
 * @returns a Promise.
 */
appendRUMGlobalContext(context:object):Promise<void>;
/**
 * Add custom Log global parameters. Applied to Log data.
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

#### Add Script for Automatic Symbol File Packaging

Script Tool: [cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` is a script tool that helps automatically obtain React Native and Native sourcemaps during release builds and packages them into zip files.

Add it to the `package.json` development dependencies using a local file method.

For example, place `cloudcare-react-native-mobile-cli.tgz` in the React Native project directory:

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli":"file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

Run `yarn install` after adding.

**Note: For Android environments, add the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) with version requirement >=1.3.4**

Add the `Plugin` and its settings in the main module `app`'s `build.gradle` file.

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

Run the `yarn ft-cli setup` command in the terminal under the React Native project directory to automatically obtain React Native and Native sourcemaps during release builds and package them into zip files. Success is indicated by the following logs.

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

**After a release build, the packaged zip file locations are:**

iOS: Under the iOS folder (./ios/sourcemap.zip)

Android: In the RN project directory (./sourcemap.zip)

### Manual Packaging of Symbol Files

[React Native Zip Package Instructions](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### Upload

[File Upload and Deletion](../sourcemap/set-sourcemap.md/#upload)

## WebView Data Monitoring

To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) on the pages accessed by WebView.

## Custom Tag Usage Examples {#track}

### Build Configuration Method

1. Use `react-native-config` to configure multi-environments and set corresponding custom tag values in different environments.

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

1. Use data persistence methods like `AsyncStorage` to store custom tags and retrieve them during SDK initialization.

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

2. Add or modify custom tags to the file at any point.

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('Failed to store' + error);
    }else {
        console.log('Stored successfully');
    }
})
```

3. Restart the application for changes to take effect.

### SDK Runtime Addition

After the SDK is initialized, use `FTReactNativeRUM.appendGlobalContext(globalContext)`, `FTReactNativeRUM.appendRUMGlobalContext(globalContext)`, and `FTReactNativeRUM.appendLogGlobalContext(globalContext)` to dynamically add tags. These changes will take immediate effect, and subsequent RUM or Log reports will automatically include the tag data. This method is suitable for scenarios where tag data is obtained via network requests.

```typescript
//SDK initialization pseudo-code, retrieve info
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info:Info){
	let  globalContext = {"delay_key":info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Hybrid Development with Native and React Native {#hybrid}

If your project is natively developed but includes some pages or workflows using React Native, follow these steps for SDK installation and initialization:

* Installation: Follow the [installation](#install) method unchanged.

* Initialization: Refer to [iOS SDK Initialization](../ios/app-access.md#init) and [Android SDK Initialization](../android/app-access.md#init) to initialize within the native project.

* React Native Configuration:

    > Supported in RN SDK 0.3.11

    No need to reinitialize in React Native. To automatically collect `React Native Error` and `React Native Action`, use the following methods:

    ```typescript
    import {FTRumActionTracking,FTRumErrorTracking} from '@cloudcare/react-native-mobile';
    //Enable automatic collection of react-native control clicks
    FTRumActionTracking.startTracking();
    //Enable automatic collection of react-native Errors
    FTRumErrorTracking.startTracking();
    ```

* Native Project Configuration:

    > Supported in RN SDK 0.3.11

    When enabling automatic RUM Resource collection, filter out React Native symbolization calls and Expo log calls that occur only in the development environment. Methods are as follows:

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
```java
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

## Publish Package Configuration

### Android

* [Android R8/Proguard Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS

* [iOS Symbol File Upload](../ios/app-access.md#source_map)

## FAQs

- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Other Related](../ios/app-access.md#FAQ)
- [Android Other Related](../android/app-access.md#FAQ)

---

This concludes the translation of the provided document. If you have any further sections or documents that need translation, feel free to provide them, and I will continue translating as needed.