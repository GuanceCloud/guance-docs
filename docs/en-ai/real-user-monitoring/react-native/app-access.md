# React Native Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Ensure DataKit is [accessible from the public network and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

**Note**: The current React Native version supports only Android and iOS platforms.

1. Enter the application name;
2. Enter the application ID;
3. Choose the integration method.

![](../img/image_13.png)

## Installation {#install}

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**Source Code Address**: [https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo Address**: [https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

In the project directory, run the following command in the terminal:

```bash
npm install @cloudcare/react-native-mobile
```

This will add the following line to the `package.json` file:

```json
"dependencies": {    
   "@cloudcare/react-native-mobile": "[lastest_version]",
   ···
}
```

**Additional Android Integration Configuration:**

* Configure the Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect app launch events, network request data, and Android Native events (page transitions, click events, native network requests, WebView data).
* Note that you also need to configure the <<< custom_key.brand_name >>> Android Maven repository address in Gradle for both the Plugin and AAR. Refer to the configuration details in the example [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle).

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
// Local environment deployment or Datakit deployment
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
| datakitUrl | string | Yes | Datakit access URL, e.g., [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529. **Note:** Only one of `datakitUrl` or `datawayUrl` should be configured. |
| datawayUrl | string | Yes | Dataway access URL, e.g., [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528. **Note:** Only one of `datakitUrl` or `datawayUrl` should be configured. |
| clientToken | string | Yes | Authentication token, must be used with `datawayUrl` |
| debug | boolean | No | Enable log printing, default `false` |
| env | string | No | Environment configuration, default `prod`, any single word, e.g., `test` |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. Note: Only one of `env` or `envType` needs to be configured |
| service | string | No | Set the business or service name affecting the `service` field in Logs and RUM data. Default: `df_rum_ios`, `df_rum_android` |
| autoSync | boolean | No | Enable automatic synchronization, default `true` |
| syncPageSize | number | No | Set the number of entries per sync request. Larger values increase resource usage. Range [5,) |
| syncSleepTime | number | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Enable this if coexistence with web data is required. This setting handles web data type storage compatibility issues. |
| globalContext | object | No | Add custom tags. Refer to [here](../android/app-access.md#key-conflict) for rules |
| compressIntakeRequests | boolean | No | Compress sync data |
| enableLimitWithDbSize | boolean | No | Limit data size using db, default 100MB. Larger databases increase disk pressure. Default disabled.<br>**Note:** Enabling this makes `logCacheLimitCount` and `rumCacheLimitCount` ineffective in SDK versions 0.3.10 and above |
| dbCacheLimit | number | No | DB cache limit size. Range [30MB,), default 100MB, unit byte, supported in SDK versions 0.3.10 and above |
| dbDiscardStrategy | string | No | Set data discard rules in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported in SDK versions 0.3.10 and above |

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
| androidAppId | string | Yes | App ID obtained from the User Access Monitoring console |
| iOSAppId | string | Yes | App ID obtained from the User Access Monitoring console |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| enableAutoTrackUserAction | boolean | No | Automatically collect `React Native` component click events. After enabling, you can set `actionName` using `accessibilityLabel`. Refer to [here](#rum-action) for more customization |
| enableAutoTrackError | boolean | No | Automatically collect `React Native` Errors |
| enableNativeUserAction | boolean | No | Track `Native Action`, such as native `Button` click events and app launch events, default `false` |
| enableNativeUserView | boolean | No | Automatically track `Native View`. Suggest disabling for pure `React Native` apps, default `false` |
| enableNativeUserResource | boolean | No | Automatically track `Native Resource`. Since React-Native's network requests on iOS and Android use system APIs, enabling this allows all resource data to be collected |
| errorMonitorType | enum ErrorMonitorType | No | Additional error event monitoring types |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | View performance monitoring type |
| detectFrequency | enum DetectFrequency | No | View performance monitoring sampling frequency |
| enableResourceHostIP | boolean | No | Collect the IP address of the requested domain. Affects only the default collection when `enableNativeUserResource` is true. Supported on iOS >= iOS 13. On Android, Okhttp caches IP addresses for the same domain, generating only once if the IP does not change |
| globalContext | object | No | Add custom tags to distinguish user monitoring data sources. If using tracking functionality, set `key` to `track_id` and `value` to any value. Refer to [here](../android/app-access.md#key-conflict) for rules |
| enableTrackNativeCrash | boolean | No | Collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. Default 250ms on iOS, 1000ms on Android |
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
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1 |
| enableLinkRumData | boolean | No | Link with `RUM` |
| enableCustomLog | boolean | No | Enable custom logs |
| logLevelFilters | Array<FTLogStatus> | No | Log level filtering |
| globalContext | NSDictionary | No | Add custom log tags, refer to [here](../android/app-access.md#key-conflict) for rules |
| logCacheLimitCount | number | No | Maximum number of locally cached log entries [1000,), larger logs increase disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set the discard rule when logs reach the limit. Default `FTLogCacheDiscard.discard`, `discard` discards new data, `discardOldest` discards old data |

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
| enableNativeAutoTrace | boolean | No | Enable automatic tracing of native network requests on iOS NSURLSession and Android OKhttp (since `React Native`'s network requests on iOS and Android use system APIs, enabling this allows all `React Native` data to be traced) |

> **Note:**
>
> * Complete SDK initialization before registering your App in the top-level `index.js` file to ensure the SDK is fully ready before calling any other SDK methods.
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

When initializing the SDK with [RUM Configuration](#rum-config), you can enable automatic collection of `Native View` by configuring `enableNativeUserView`. For `React Native View`, since React Native provides extensive libraries for creating screen navigation, manual collection is supported by default. You can manually start and stop views using the following methods.

#### Custom View

##### Usage Method

```typescript
/**
 * View load duration.
 * @param viewName View name
 * @param loadTime View load duration
 * @returns a Promise.
 */
onCreateView(viewName:string, loadTime:number): Promise<void>;
/**
 * Start view.
 * @param viewName Page name
 * @param property Event context (optional)
 * @returns a Promise.
 */
startView(viewName: string, property?: object): Promise<void>;
/**
 * Stop view.
 * @param property Event context (optional)
 * @returns a Promise.
 */
stopView(property?: object): Promise<void>;
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

**If you are using `react-native-navigation`, `react-navigation`, or `Expo Router` navigation components in React Native, you can refer to the following methods for automatic collection of `React Native Views`:**

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

  If you use `createNativeStackNavigator();` to create a native navigation stack, it is recommended to add `screenListeners` to enable collection, which can track page load durations. Specific usage is as follows:

```typescript
import { FTRumReactNavigationTracking } from './FTRumReactNavigationTracking';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
const Stack = createNativeStackNavigator();

<Stack.Navigator  screenListeners={FTRumReactNavigationTracking.StackListener} initialRouteName='Home'>
      <Stack.Screen name='Home' component={Home}  options={{ headerShown: false }} />
      ......
      <Stack.Screen name="Mine" component={Mine} options={{ title: 'Mine' }}/>
</Stack.Navigator>
```

* Method Two:

  If you are not using `createNativeStackNavigator();`, you need to add the automatic collection method in the `NavigationContainer` component as follows:

  **Note: This method cannot collect page load durations**

```typescript
import { FTRumReactNavigationTracking } from './FTRumReactNavigationTracking';
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

In the SDK initialization [RUM Configuration](#rum-config), configure `enableAutoTrackUserAction` and `enableNativeUserAction` to enable automatic collection, or use the following methods for manual addition.

#### Usage Method

```typescript
/**
 * Start an RUM Action. RUM binds this Action to possible Resource, Error, LongTask events.
 * Avoid adding multiple times within 0.1 seconds. Only one Action can be associated with the same View at a time. 
 * New Actions will be discarded if the previous Action has not ended. Adding Actions via `addAction` does not affect each other.
 * @param actionName Action name
 * @param actionType Action type
 * @param property Event context (optional)
 * @returns a Promise.
 */
startAction(actionName:string, actionType:string, property?: object): Promise<void>;
 /**
  * Add an Action event. This data cannot associate with Error, Resource, LongTask data and has no discard logic.
  * @param actionName Action name
  * @param actionType Action type
  * @param property Event context (optional)
  * @returns a Promise.
  */
addAction(actionName:string, actionType:string, property?: object): Promise<void>;
```

#### Code Example

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.startAction('actionName', 'actionType', {'custom.foo': 'something'});

FTReactNativeRUM.addAction('actionName', 'actionType', {'custom.foo': 'something'});
```

**More Custom Collection Operations**

After enabling `enableAutoTrackUserAction`, the SDK will automatically collect click operations of components with the `onPress` attribute. If you want to perform some custom operations on top of automatic tracking, the SDK supports the following:

* Customize the `actionName` for a component's click event

  Set via the `accessibilityLabel` attribute

```typescript
<Button title="Custom Action Name"
        accessibilityLabel="custom_action_name"
        onPress={()=>{
              console.log("btn click")
        }}
 />
```

* Do not collect a component's click event

  Add the `ft-enable-track` custom parameter and set it to `false`

```typescript
<Button title="Action Click" 
        ft-enable-track="false"
        onPress={()=>{
              console.log('btn click');
        }}
/>
```

* Add extra properties to a component's click event

  Add the `ft-extra-property` custom parameter, requiring **JSON string value**

```typescript
<Button title="Action 添加额外属性"
        ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
        onPress={()=>{
             console.log("btn click")
        }}
/>
```

### Error

In the SDK initialization [RUM Configuration](#rum-config), configure `enableAutoTrackError` to enable automatic collection, or use the following methods for manual addition.

#### Usage Method

```typescript
/**
 * Capture exceptions and log them.
 * @param stack Stack trace
 * @param message Error message
 * @param property Event context (optional)
 * @returns a Promise.
 */
addError(stack: string, message: string, property?: object): Promise<void>;
/**
 * Capture exceptions and log them.
 * @param type Error type
 * @param stack Stack trace
 * @param message Error message
 * @param property Event context (optional)
 * @returns a Promise.
 */
addErrorWithType(type: string, stack: string, message: string, property?: object): Promise<void>;
```

#### Usage Example

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

FTReactNativeRUM.addError("error stack", "error message", {'custom.foo': 'something'});

FTReactNativeRUM.addErrorWithType("custom_error", "error stack", "error message", {'custom.foo': 'something'});
```

### Resource

In the SDK initialization [RUM Configuration](#rum-config), configure `enableNativeUserResource` to enable automatic collection, or use the following methods for manual addition.

#### Usage Method

```typescript
/**
 * Start a resource request.
 * @param key Unique id
 * @param property Event context (optional)
 * @returns a Promise.
 */
startResource(key: string, property?: object): Promise<void>;
/**
 * End a resource request.
 * @param key Unique id
 * @param property Event context (optional)
 * @returns a Promise.
 */
stopResource(key: string, property?: object): Promise<void>;
/**
 * Send resource data metrics.
 * @param key Unique id
 * @param resource Resource data
 * @param metrics Resource performance data
 * @returns a Promise.
 */
addResource(key: string, resource: FTRUMResource, metrics?: FTRUMResourceMetrics): Promise<void>;
```

#### Usage Example

```typescript
import {FTReactNativeRUM} from '@cloudcare/react-native-mobile';

async getHttp(url: string){
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
                  var resource: FTRUMResource = {
                        url: url,
                        httpMethod: fetchOptions.method,
                        requestHeader: fetchOptions.headers,
                  };
                  if (res) {
                        resource.responseHeader = res.headers;
                        resource.resourceStatus = res.status;
                        resource.responseBody = await res.text();
                  }
                  FTReactNativeRUM.stopResource(key);
                  FTReactNativeRUM.addResource(key, resource);
            }
      }
```

## Logger Logging

> Currently, log content is limited to 30 KB, exceeding characters will be truncated.
### Usage Method

```typescript
/**
 * Output log.
 * @param content Log content
 * @param status Log status
 * @param property Log context (optional)
 */
logging(content: String, logStatus: FTLogStatus | String, property?: object): Promise<void>;
```

### Usage Example

```typescript
import { FTReactNativeLog, FTLogStatus } from '@cloudcare/react-native-mobile';
// logStatus:FTLogStatus
FTReactNativeLog.logging("info log content", FTLogStatus.info);
// logStatus:string
FTReactNativeLog.logging("info log content", "info");
```

### Log Levels

| **Method Name** | **Meaning** |
| --- | --- |
| FTLogStatus.info | Info |
| FTLogStatus.warning | Warning |
| FTLogStatus.error | Error |
| FTLogStatus.critical | Critical |
| FTLogStatus.ok | Recovered |

## Tracer Network Trace

During SDK initialization with [Trace Configuration](#trace-config), you can enable automatic network trace collection. It also supports custom collection, with usage methods and examples as follows:

### Usage Method

```typescript
/**
 * Get trace HTTP request header data.
 * @param url Request URL
 * @returns Trace added request header parameters  
 * @deprecated Use getTraceHeaderFields() instead.
 */
getTraceHeader(key: String, url: String): Promise<object>;
/**
 * Get trace HTTP request header data.
 * @param url Request URL
 * @returns Trace added request header parameters  
 */
getTraceHeaderFields(url: String, key?: String): Promise<object>;
```

### Usage Example

```typescript
import {FTReactNativeTrace} from '@cloudcare/react-native-mobile';
 
async getHttp(url: string){
    const key = Utils.getUUID();
    var traceHeader = await FTReactNativeTrace.getTraceHeaderFields(url);
    const fetchOptions = {
      method: 'GET',
      headers: Object.assign({
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }, traceHeader),
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
 * @param extra User additional information
 * @returns a Promise.
 */
bindRUMUserData(userId: string, userName?: string, userEmail?: string, extra?: object): Promise<void>;
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
 * @param extra User additional information
 * @returns a Promise.
*/
FTMobileReactNative.bindRUMUserData('react-native-user', 'user_name')
/**
 * Unbind user.
 * @returns a Promise.
*/
FTMobileReactNative.unbindRUMUserData()
```

## Shutdown SDK

Use `FTMobileReactNative` to shut down the SDK.

### Usage Method

```typescript
/**
 * Shutdown running objects within the SDK
 */
shutDown(): Promise<void>
```

### Usage Example

```typescript
FTMobileReactNative.shutDown();
```

## Clear SDK Cache Data

Use `FTMobileReactNative` to clear unsent cached data.

### Usage Method

```typescript
/**
 * Clear all data that has not been uploaded to the server.
 */
clearAllData(): Promise<void>
```

### Usage Example

```typescript
/**
 * Clear all data that has not been uploaded to the server.
*/
FTMobileReactNative.clearAllData();
```

## Active Data Sync

When `FTMobileConfig.autoSync` is set to `true`, no additional actions are required; the SDK will sync data automatically.

When `FTMobileConfig.autoSync` is set to `false`, you need to trigger the data sync method actively.

### Usage Method

```typescript
/**
 * Actively synchronize data. When `FTMobileConfig.autoSync=false`, you need to call this method to synchronize data.
 * @returns a Promise.
 */
flushSyncData(): Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.flushSyncData();
```

## Add Custom Tags {#user-global-context}

### Usage Method

```typescript
/**
 * Add custom global parameters. Applies to RUM and Log data.
 * @param context Custom global parameters.
 * @returns a Promise.
 */
appendGlobalContext(context: object): Promise<void>;
/**
 * Add custom RUM global parameters. Applies to RUM data.
 * @param context Custom RUM global parameters.
 * @returns a Promise.
 */
appendRUMGlobalContext(context: object): Promise<void>;
/**
 * Add custom RUM and Log global parameters. Applies to Log data.
 * @param context Custom Log global parameters.
 * @returns a Promise.
 */
appendLogGlobalContext(context: object): Promise<void>;
```

### Usage Example

```typescript
FTMobileReactNative.appendGlobalContext({'global_key': 'global_value'});

FTMobileReactNative.appendRUMGlobalContext({'rum_key': 'rum_value'});

FTMobileReactNative.appendLogGlobalContext({'log_key': 'log_value'});
```

## Symbol File Upload {#source_map}

### Automatic Packing of Symbol Files

#### Add Script for Automatic Symbol File Packing

Script tool: [cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` is a script tool to help configure automatic acquisition of React Native and Native sourcemaps during release builds and package them into zip files.

Add it to `package.json` development dependencies using a local file method.

For example, place `cloudcare-react-native-mobile-cli.tgz` in the React Native project directory:

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli": "file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

Run `yarn install` after adding.

**Note: Android environments require adding Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) with version >=1.3.4**

Add the `Plugin` usage and parameter settings in the main module `app`'s `build.gradle` file.

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

Run the `yarn ft-cli setup` command in the terminal under the React Native project directory to automatically acquire React Native and Native sourcemaps during release builds and package them into zip files. The following log indicates successful setup.

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

**Release build packed zip file location:**

iOS: In the iOS folder (./ios/sourcemap.zip)

Android: In the RN project directory (./sourcemap.zip)

### Manual Packing of Symbol Files

[React Native Zip Package Instructions](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### Upload

[File Upload and Deletion](../sourcemap/set-sourcemap.md/#upload)

## WebView Data Monitoring

To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) in the pages accessed by WebView.

## Custom Tag Usage Examples {#track}

### Build Configuration Method

1. Use `react-native-config` to configure multiple environments and set corresponding custom tag values in different environments.

```typescript
let rumConfig: FTRUMConfig = {
      iOSAppId: iOSAppId,
      androidAppId: androidAppId,
      monitorType: MonitorType.all,
      enableTrackUserAction: true,
      enableTrackUserResource: true,
      enableTrackError: true,
      enableNativeUserAction: false,
      enableNativeUserResource: false,
      enableNativeUserView: false,
      globalContext: {"track_id": Config.TRACK_ID}, // Set in .env.debug, .env.release, etc.
    };

 await FTReactNativeRUM.setConfig(rumConfig); 
```

### Runtime Read/Write File Method

1. Use data persistence methods like `AsyncStorage` to retrieve stored custom tags when initializing the SDK.

```typescript
 let rumConfig: FTRUMConfig = {
      iOSAppId: iOSAppId,
      androidAppId: androidAppId,
      monitorType: MonitorType.all,
      enableTrackUserAction: true,
      enableTrackUserResource: true,
      enableTrackError: true,
      enableNativeUserAction: false,
      enableNativeUserResource: false,
      enableNativeUserView: false,
    };
 await new Promise(function(resolve) {
       AsyncStorage.getItem("track_id", (error, result) => {
        if (result === null){
          console.log('Get failed' + error);
        }else {
          console.log('Get succeeded' + result);
          if(result != undefined){
            rumConfig.globalContext = {"track_id": result};
          }
        }
        resolve(FTReactNativeRUM.setConfig(rumConfig));
      })
     });
```

2. Add or change custom tags to the file at any point.

```typescript
AsyncStorage.setItem("track_id", valueString, (error) => {
    if (error){
        console.log('Save failed' + error);
    }else {
        console.log('Save succeeded');
    }
})
```

3. Restart the application for changes to take effect.

### SDK Runtime Addition

After the SDK is initialized, you can dynamically add tags using `FTReactNativeRUM.appendGlobalContext(globalContext)`, `FTReactNativeRUM.appendRUMGlobalContext(globalContext)`, and `FTReactNativeRUM.appendLogGlobalContext(globalContext)`. These changes will take effect immediately. Subsequent RUM or Log reports will automatically include the tag data. This method is suitable for scenarios where tag data needs to be fetched later, such as when tag data requires a network request.

```typescript
// Pseudo-code for SDK initialization, fetching
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info: Info){
	let globalContext = {"delay_key": info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Hybrid Development with Native and React Native {#hybrid}

If your project is natively developed with some pages or business processes implemented using React Native, follow these steps for SDK installation and initialization:

* Installation: Follow the [installation](#install) instructions unchanged.

* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) to initialize in the native project.

* React Native Configuration:

    > RN SDK 0.3.11 support

    No additional initialization is required on the React Native side. To automatically collect `React Native Error` and `React Native Action`, use the following methods:

    ```typescript
    import {FTRumActionTracking, FTRumErrorTracking} from '@cloudcare/react-native-mobile';
    // Enable automatic collection of React Native component clicks
    FTRumActionTracking.startTracking();
    // Enable automatic collection of React Native Errors
    FTRumErrorTracking.startTracking();
    ```

* Native Project Configuration:

    > RN SDK 0.3.11 support

    When enabling automatic collection of RUM Resources, filter out React Native symbolization calls and Expo log calls that occur only in the development environment. Methods are as follows:

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
  
        ``````kotlin
        import com.cloudcare.ft.mobile.sdk.tracker.reactnative.utils.ReactNativeUtils
        import com.ft.sdk.FTRUMConfig
        
        val rumConfig = FTRUMConfig().setRumAppId(rumAppId)
        rumConfig.isEnableTraceUserResource = true
        if (BuildConfig.DEBUG) {
            rumConfig.setResourceUrlHandler { url ->
                return@setResourceUrlHandler ReactNativeUtils.isReactNativeDevUrl(url)
            }
        }
```

Specific usage examples can be found in the [example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example).

## Publish Package Configuration

### Android
* [Android R8/Proguard Configuration](../android/app-access.md#r8_proguard)
* [Android Symbol File Upload](../android/app-access.md#source_map)

### iOS
* [iOS Symbol File Upload](../ios/app-access.md#source_map)

## Common Issues

- [Android Privacy Review](../android/app-access.md#third-party)
- [iOS Other Related](../ios/app-access.md#FAQ)
- [Android Other Related](../android/app-access.md#FAQ)

---

This concludes the translation of the provided content. If you need further assistance or have additional sections to translate, please let me know!