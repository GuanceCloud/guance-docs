# React Native Application Integration

---

## Prerequisites

**Note**: If you have enabled the [RUM Headless](../../dataflux-func/headless.md) service, the prerequisites are automatically configured for you. You can directly integrate your application.

- Install [DataKit](../../datakit/datakit-install.md);
- Configure the [RUM Collector](../../integrations/rum.md);
- Configure DataKit to be [publicly accessible and install the IP geolocation database](../../datakit/datakit-tools-how-to.md#install-ipdb).

## Application Integration

**Note**: The current React Native version only supports Android and iOS platforms.

1. Enter the application name;
2. Enter the application ID;
3. Choose the integration method.

![](../img/image_13.png)

## Installation {#install}

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.guance.com/ft-sdk-package/badge/react-native/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.guance.com/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.guance.com/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

**Source Code Repository**: [https://github.com/GuanceCloud/datakit-react-native](https://github.com/GuanceCloud/datakit-react-native)

**Demo Repository**: [https://github.com/GuanceCloud/datakit-react-native/example](https://github.com/GuanceCloud/datakit-react-native/tree/dev/example)

In the project directory, run the following command in the terminal:

```bash
npm install @cloudcare/react-native-mobile
```

This will add the following line to your package.json:

```json
"dependencies": {    
   "@cloudcare/react-native-mobile: [lastest_version],
   ···
}
```

**Additional Configuration for Android:**

* Configure Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting) to collect app launch events, network request data, and Android Native related events (page transitions, click events, native network requests, WebView data).
* Note that you need to configure the Guance Android Maven repository address in Gradle as well. Both the Plugin and AAR require configuration. Refer to the example [build.gradle](https://github.com/GuanceCloud/datakit-react-native/blob/dev/example/android/build.gradle) for details.

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
| datakitUrl | string | Yes | Datakit access URL, example: [http://10.0.0.1:9529](http://10.0.0.1:9529/), default port 9529. **Note:** Only one of `datakit` or `dataway` configurations is required. |
| datawayUrl | string | Yes | Dataway access URL, example: [http://10.0.0.1:9528](http://10.0.0.1:9528/), default port 9528. **Note:** Only one of `datakit` or `dataway` configurations is required. |
| clientToken | string | Yes | Authentication token, must be used with `datawayUrl` |
| debug | boolean | No | Enable log printing, default `false` |
| env | string | No | Environment configuration, default `prod`, any single word like `test` |
| envType | enum EnvType | No | Environment configuration, default `EnvType.prod`. Note: Only one of `env` or `envType` needs to be configured |
| service | string | No | Set the business or service name, affecting the `service` field in Log and RUM data. Default: `df_rum_ios`, `df_rum_android` |
| autoSync | boolean | No | Enable automatic synchronization, default `true` |
| syncPageSize | number | No | Set the number of items per sync request. Larger values consume more computing resources. Range [5,) |
| syncSleepTime | number | No | Set the interval between syncs. Range [0,5000], default not set |
| enableDataIntegerCompatible | boolean | No | Enable this if web data coexistence is needed. This setting handles web data type storage compatibility issues. |
| globalContext | object | No | Add custom tags. Refer to [here](../android/app-access.md#key-conflict) for rules |
| compressIntakeRequests | boolean | No | Compress sync data |
| enableLimitWithDbSize | boolean | No | Enable DB cache size limit feature. <br>**Note:** When enabled, `logCacheLimitCount` and `rumCacheLimitCount` in Log and RUM configurations become invalid. Supported in SDK 0.3.10 and above |
| dbCacheLimit | number | No | DB cache size limit. Range [30MB,), default 100MB, unit byte. Supported in SDK 0.3.10 and above |
| dbDiscardStrategy | string | No | Set data discard rules in the database.<br>Discard strategy: `FTDBCacheDiscard.discard` discards new data (default), `FTDBCacheDiscard.discardOldest` discards old data. Supported in SDK 0.3.10 and above |

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
| androidAppId | string | Yes | App ID, obtained from the User Access Monitoring console |
| iOSAppId | string | Yes | App ID, obtained from the User Access Monitoring console |
| sampleRate | number | No | Sampling rate, range [0,1], 0 means no collection, 1 means full collection, default 1. Applies to all View, Action, LongTask, Error data within the same session_id |
| enableAutoTrackUserAction | boolean | No | Automatically track `React Native` component click events. After enabling, you can set `actionName` using `accessibilityLabel`. For more customization, refer to [here](#rum-action) |
| enableAutoTrackError | boolean | No | Automatically track `React Native` errors |
| enableNativeUserAction | boolean | No | Track `Native Action`, such as button clicks and app launch events, default `false` |
| enableNativeUserView | boolean | No | Automatically track `Native View`. Pure `React Native` apps should disable this, default `false` |
| enableNativeUserResource | boolean | No | Automatically track `Native Resource`. Since React-Native's network requests use system APIs on iOS and Android, enabling `enableNativeUserResource` ensures all resource data is collected. |
| errorMonitorType | enum ErrorMonitorType | No | Additional error event monitoring types |
| deviceMonitorType | enum DeviceMetricsMonitorType | No | View performance monitoring type |
| detectFrequency | enum DetectFrequency | No | View performance monitoring sampling frequency |
| enableResourceHostIP | boolean | No | Whether to collect the IP address of the target domain. Affects only the default collection when `enableNativeUserResource` is true. Supported on iOS >= iOS 13. On Android, Okhttp caches IP addresses for the same domain, so it only generates once unless the server IP changes. |
| globalContext | object | No | Add custom tags to distinguish user monitoring data sources. If tracking is needed, the parameter `key` should be `track_id`, and `value` can be any value. Refer to [here](../android/app-access.md#key-conflict) for rules |
| enableTrackNativeCrash | boolean | No | Whether to collect `Native Error` |
| enableTrackNativeAppANR | boolean | No | Whether to collect `Native ANR` |
| enableTrackNativeFreeze | boolean | No | Whether to collect `Native Freeze` |
| nativeFreezeDurationMs | number | No | Set the threshold for collecting `Native Freeze` delays, range [100,), unit milliseconds. Default 250ms on iOS, 1000ms on Android |
| rumDiscardStrategy | string | No | Discard strategy: `FTRUMCacheDiscard.discard` discards new data (default), `FTRUMCacheDiscard.discardOldest` discards old data |
| rumCacheLimitCount | number | No | Maximum number of RUM entries cached locally [10000,), default 100_000 |

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
| enableLinkRumData | boolean | No | Whether to link with `RUM` |
| enableCustomLog | boolean | No | Enable custom logs |
| logLevelFilters | Array<FTLogStatus> | No | Log level filters |
| globalContext | NSDictionary | No | Add custom log tags, refer to [here](../android/app-access.md#key-conflict) for rules |
| logCacheLimitCount | number | No | Maximum number of log entries cached locally [1000,), larger values increase disk cache pressure, default 5000 |
| discardStrategy | enum FTLogCacheDiscard | No | Set log discard rules when limits are reached. Default `FTLogCacheDiscard.discard`, `discard` discards new data, `discardOldest` discards old data |

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
| enableLinkRUMData | boolean | No | Whether to link with `RUM` data, default `false` |
| enableNativeAutoTrace | boolean | No | Enable automatic native network tracing for iOS NSURLSession and Android OKhttp. Since `React Native` network requests use system APIs on iOS and Android, enabling `enableNativeAutoTrace` ensures all `React Native` data is traced. |

> **Note:**
>
> * Ensure the SDK is initialized before registering the App in your top-level `index.js` file to ensure the SDK is fully ready before calling any other methods.
> * Perform RUM, Log, and Trace configurations after the basic configuration is complete.
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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection of `Native View` by setting `enableNativeUserView`. For `React Native View`, since React Native provides extensive libraries for screen navigation, manual collection is supported by default. You can manually start and stop views using the following methods.

#### Custom View

##### Usage Method

```typescript
/**
 * View loading time.
 * @param viewName view name
 * @param loadTime view loading time
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

**If you are using `react-native-navigation`, `react-navigation`, or `Expo Router` navigation components in React Native, you can refer to the following methods for automatic collection of `React Native View`:**

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

  If you use `createNativeStackNavigator();` to create a native navigation stack, it is recommended to add `screenListeners` to enable collection, which can record page loading times. Specific usage is as follows:

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

  If you do not use `createNativeStackNavigator();`, you need to add the automatic collection method in the `NavigationContainer` component as follows:

  **Note: This method cannot collect page loading times**

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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableAutoTrackUserAction` and `enableNativeUserAction`, or manually add actions using the following methods.

#### Usage Method

```typescript
/**
 * Start RUM Action. RUM will bind the possible Resource, Error, LongTask events triggered by this Action.
 * Avoid adding multiple Actions within 0.1 seconds, as only one Action can be associated with a View at a time. New Actions added while the previous Action has not ended will be discarded. Adding Actions using `addAction` does not affect each other.
 * @param actionName action name
 * @param actionType action type
 * @param property event context (optional)
 * @returns a Promise.
 */
startAction(actionName:string,actionType:string,property?:object): Promise<void>;
 /**
  * Add Action event. This type of data cannot be associated with Error, Resource, LongTask data, and there is no discard logic.
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

After enabling `enableAutoTrackUserAction`, the SDK will automatically collect click operations of components with an `onPress` attribute. If you want to perform some customized operations based on automatic tracking, the SDK supports the following operations:

* Customize the `actionName` of a component's click event

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

  Add the `ft-enable-track` custom parameter and set its value to `false`

```typescript
  <Button title="Action Click" 
          ft-enable-track="false"
          onPress={()=>{
                console.log('btn click');
          }}
  />
```

* Add extra properties to a component's click event

  Add the `ft-extra-property` custom parameter and set its value as a JSON string

```typescript
  <Button title="Action 添加额外属性"
          ft-extra-property='{"e_name": "John Doe", "e_age": 30, "e_city": "New York"}'
          onPress={()=>{
                 console.log("btn click")
          }}
  />
```

### Error

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableAutoTrackError`, or manually add errors using the following methods.

#### Usage Method

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

When initializing the SDK [RUM Configuration](#rum-config), you can enable automatic collection by configuring `enableNativeUserResource`, or manually add resources using the following methods.

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

> Currently, log content is limited to 30 KB, and any characters exceeding this limit will be truncated.
### Usage Method

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

## Tracer Network Link Tracing

When initializing the SDK [Trace Configuration](#trace-config), you can enable automatic network link tracing. Custom collection methods and examples are as follows:

### Usage Method

```typescript
/**
 * Get trace HTTP request header data.
 * @param url request URL
 * @returns trace added request header parameters  
 * @deprecated use getTraceHeaderFields() instead.
 */
getTraceHeader(key:String, url: String): Promise<object>;
/**
 * Get trace HTTP request header data.
 * @param url request URL
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
 * @param userId user ID.
 * @param userName user name.
 * @param userEmail user email
 * @param extra additional user information
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
 * @param userId user ID.
 * @param userName user name.
 * @param userEmail user email
 * @param extra additional user information
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

### Usage Method

```typescript
/**
 * Close running objects in the SDK
 */
shutDown():Promise<void>
```

### Usage Example

```typescript
FTMobileReactNative.shutDown();
```

## Clearing SDK Cache Data

Use `FTMobileReactNative` to clear unsent cache data.

### Usage Method

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

## Active Data Synchronization

When `FTMobileConfig.autoSync` is set to `true`, no additional operations are required, and the SDK will automatically synchronize data.

When `FTMobileConfig.autoSync` is set to `false`, you need to actively trigger the data synchronization method.

### Usage Method

```typescript
/**
 * Actively synchronize data when `FTMobileConfig.autoSync=false`. Need to call this method to synchronize data.
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
 * Add custom global parameters. Applied to RUM and Log data.
 * @param context custom global parameters.
 * @returns a Promise.
 */
appendGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM global parameters. Applied to RUM data.
 * @param context custom RUM global parameters.
 * @returns a Promise.
 */
appendRUMGlobalContext(context:object):Promise<void>;
/**
 * Add custom RUM and Log global parameters. Applied to Log data.
 * @param context custom Log global parameters.
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

#### Adding Script for Automatic Symbol File Packaging

Script tool: [cloudcare-react-native-mobile-cli](https://github.com/GuanceCloud/datakit-react-native/blob/dev/cloudcare-react-native-mobile-cli-v1.0.0.tgz)

`cloudcare-react-native-mobile-cli` is a script tool that helps configure automatic acquisition of React Native and Native sourcemaps during release builds and packages them into zip files.

Add it locally to `package.json` development dependencies.

For example, place `cloudcare-react-native-mobile-cli.tgz` in the React Native project directory:

```json
 "devDependencies": {
    "@cloudcare/react-native-mobile-cli":"file:./cloudcare-react-native-mobile-cli-v1.0.0.tgz",
  }
```

Run `yarn install` after adding.

**Note: Android environments require adding Gradle Plugin [ft-plugin](../android/app-access.md#gradle-setting), version requirement: >=1.3.4**

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

In the React Native project directory, execute the terminal command `yarn ft-cli setup` to automatically acquire React Native and Native sourcemaps during release builds and package them into zip files. If you see the following logs, the setup is successful.

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

**Release build packaged zip file location:**

iOS: Inside the iOS folder (./ios/sourcemap.zip)

Android: In the RN project directory (./sourcemap.zip)

### Manual Packaging of Symbol Files

[React Native Zip Package Instructions](../sourcemap/set-sourcemap.md/#sourcemap-zip)

### Upload

[File Upload and Deletion](../sourcemap/set-sourcemap.md/#upload)

## WebView Data Monitoring

To monitor WebView data, integrate the [Web Monitoring SDK](../web/app-access.md) in the WebView accessed pages.

## Custom Tag Usage Examples {#track}

### Build Configuration Method

1. Use `react-native-config` for multi-environment configuration, setting custom tag values in different environments.

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

1. Using persistent storage methods like `AsyncStorage`, obtain stored custom tags when initializing the SDK.

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

2. Add or change custom tags to the file at any point.

```typescript
AsyncStorage.setItem("track_id",valueString,(error)=>{
    if (error){
        console.log('存储失败' + error);
    }else {
        console.log('存储成功');
    }
})
```

3. Restart the app for changes to take effect.

### SDK Runtime Addition

After the SDK is initialized, use `FTReactNativeRUM.appendGlobalContext(globalContext)`, `FTReactNativeRUM.appendRUMGlobalContext(globalContext)`, `FTReactNativeRUM.appendLogGlobalContext(globalContext)` to dynamically add tags. These changes take effect immediately, and subsequent reported RUM or Log data will automatically include the tag data. This method is suitable for scenarios where tag data needs to be fetched later, such as requiring network requests to obtain the data.

```typescript
//SDK initialization pseudo-code, obtaining
FTMobileReactNative.sdkConfig(config);

function getInfoFromNet(info:Info){
	let  globalContext = {"delay_key":info.value}
	FTMobileReactNative.appendGlobalContext(globalContext);
}
```

## Hybrid Development with Native and React Native {#hybrid}

If your project is natively developed but includes certain pages or workflows using React Native, follow these steps for installing and configuring the SDK:

* Installation: [Installation](#install) remains unchanged

* Initialization: Refer to [iOS SDK Initialization Configuration](../ios/app-access.md#init) and [Android SDK Initialization Configuration](../android/app-access.md#init) for initialization in the native project.

* React Native Configuration:

    In the React Native side, no further initialization is required. To enable automatic collection of `React Native Error` and `React Native Action`, use the following methods:
    
```typescript
import {FTRumActionTracking,FTRumErrorTracking} from '@cloudcare/react-native-mobile';
//Enable automatic collection of react-native control clicks
FTRumActionTracking.startTracking();
//Enable automatic collection of react-native Errors
FTRumErrorTracking.startTracking();
```

* Native Project Configuration:

    When enabling RUM Resource automatic collection, filter out React Native symbolization calls and Expo log calls that occur only in the development environment. Methods are as follows:

    **iOS**

    === "Objective-C"

        ```objective-c
        #import <FTMobileReactNativeSDK/FTReactNativeRUM.h>
        #import <FTMobileSDK/FTMobileAgent.h>
        
        FTRumConfig *rumConfig = [[FTRumConfig alloc]initWithAppid:rumAppId];
        rumConfig.enableTraceUserResource = YES;
        #if DEBUG
          rumConfig.resourceUrlHandler = ^BOOL(NSURL * _Nonnull url) {
            return filterBlackResource(url);
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
           return filterBlackResource(url)
        }
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
            rumConfig.isEnableTraceUserResource =