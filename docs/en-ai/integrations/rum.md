---
title: 'RUM'
summary: 'Collect user behavior data'
tags:
  - 'RUM'
__int_icon: 'icon/rum'
dashboard:
  - desc: 'Not available'
    path: '-'
monitor:
  - desc: 'Not available'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The RUM (Real User Monitoring) collector is used to collect user access monitoring data reported from web or mobile ends.

## Configuration {#config}

### Access Methods {#supported-platforms}

<div class="grid cards" markdown>
- :material-web: [JavaScript](../real-user-monitoring/web/app-access.md)
- :material-wechat: [WeChat Mini Program](../real-user-monitoring/miniapp/app-access.md)
- :material-android: [Android](../real-user-monitoring/android/app-access.md)
- :material-apple-ios: [iOS](../real-user-monitoring/ios/app-access.md)
- [Flutter](../real-user-monitoring/flutter/app-access.md)
- :material-react:[ReactNative](../real-user-monitoring/react-native/app-access.md)
</div>

### Prerequisites {#requirements}

- Deploy DataKit as publicly accessible

It is recommended to deploy the RUM collector separately on the public network, not together with existing services (such as a Kubernetes cluster). The traffic on this RUM interface can be substantial and may interfere with internal cluster traffic. Additionally, some internal resource scheduling mechanisms in the cluster might affect the operation of the RUM service.

- Install the [IP geolocation database on DataKit](../datakit/datakit-tools-how-to.md#install-ipdb)
- Since version [1.2.7](../datakit/changelog.md#cl-1.2.7), due to changes in the installation method of the IP geolocation database, it no longer comes pre-installed by default. Manual installation is required.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/rum` directory under the DataKit installation directory, copy `rum.conf.sample`, and rename it to `rum.conf`. An example configuration is as follows:
    
    ```toml
        
    [[inputs.rum]]
      ## profile Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/v1/write/rum"]
    
      ## used to upload rum session replay.
      session_replay_endpoints = ["/v1/write/rum/replay"]
    
      ## specify which metrics should be captured.
      measurements = ["view", "resource", "action", "long_task", "error", "telemetry"]
    
      ## Android command-line-tools HOME
      android_cmdline_home = "/usr/local/datakit/data/rum/tools/cmdline-tools"
    
      ## proguard HOME
      proguard_home = "/usr/local/datakit/data/rum/tools/proguard"
    
      ## android-ndk HOME
      ndk_home = "/usr/local/datakit/data/rum/tools/android-ndk"
    
      ## atos or atosl bin path
      ## for macOS datakit use the built-in tool atos default
      ## for Linux there are several tools that can be used to instead of macOS atos partially,
      ## such as https://github.com/everettjf/atosl-rs
      atos_bin_path = "/usr/local/datakit/data/rum/tools/atosl"
    
      # Provide a list to resolve CDN of your static resource.
      # Below is the Datakit default built-in CDN list, you can uncomment that and change it to your cdn list,
      # it's a JSON array like: [{"domain": "CDN domain", "name": "CDN human readable name", "website": "CDN official website"},...],
      # domain field value can contains '*' as wildcard, for example: "kunlun*.com",
      # it will match "kunluna.com", "kunlunab.com" and "kunlunabc.com" but not "kunlunab.c.com".
      # cdn_map = '''
      # [
      #   {"domain":"15cdn.com","name":"some-CDN-name","website":"https://www.15cdn.com"},
      #   {"domain":"tzcdn.cn","name":"some-CDN-name","website":"https://www.15cdn.com"}
      # ]
      # '''
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.rum.threads]
      #   buffer = 100
      #   threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.rum.storage]
      #   path = "./rum_storage"
      #   capacity = 5120
    
      ## session_replay config is used to control Session Replay uploading behavior.
      ## cache_path set the disk directory where temporarily cache session replay data.
      ## cache_capacity_mb specify the max storage space (in MiB) that session replay cache can use.
      ## clear_cache_on_start set whether we should clear all previous session replay cache on restarting Datakit.
      ## upload_workers set the count of session replay uploading workers.
      ## send_timeout specify the http timeout when uploading session replay data to dataway.
      ## send_retry_count set the max retry count when sending every session replay request.
      ## filter_rules set the the filtering rules that matched session replay data will be dropped, 
      ## all rules are of relationship OR, that is to day, the data match any one of them will be dropped.
      # [inputs.rum.session_replay]
      #   cache_path = "/usr/local/datakit/cache/session_replay"
      #   cache_capacity_mb = 20480
      #   clear_cache_on_start = false
      #   upload_workers = 16
      #   send_timeout = "75s"
      #   send_retry_count = 3
      #   filter_rules = [
      #       "{ service = 'xxx' or version IN [ 'v1', 'v2'] }",
      #       "{ app_id = 'yyy' and env = 'production' }"
      #   ]
    
    ```

    Or simply enable it in the default collectors within *datakit.conf*:

    ``` toml
    default_enabled_inputs = [ "rum", "cpu", "disk", "diskio", "mem", "swap", "system", "hostobject", "net", "host_processes" ]
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    In *datakit.yaml*, add the `rum` collector name to the environment variable `ENV_DEFAULT_ENABLED_INPUTS` (as shown first in the following `value`):

    ```yaml
    - name: ENV_DEFAULT_ENABLED_INPUTS
      value: rum,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container
    ```
<!-- markdownlint-enable -->

### Security Restrictions {#security-setting}

Refer to [DataKit API Access Control](../datakit/datakit-conf.md#public-apis).

### Disable DataKit 404 Page {#disable-404}

You can disable public access to the DataKit 404 page with the following configuration:

```toml
# datakit.conf
disable_404page = true
```

## Metrics {#metric}

The RUM collector defaults to collecting the following measurement sets:

- `error`
- `view`
- `resource`
- `long_task`
- `action`

## Sourcemap Conversion {#sourcemap}

In production environments, js files or mobile App code are often obfuscated and compressed to reduce application size. When errors occur, the call stack differs significantly from the original source code, making troubleshooting difficult. To pinpoint errors back to the source code, sourcemap files are needed.

DataKit supports mapping these source code files by compressing the corresponding symbol table files into a zip package named *[app_id]-[env]-[version].zip* and uploading them to *[DataKit installation directory]/data/rum/[platform]*. This automatically converts the uploaded `error` measurement set data and adds an `error_stack_source` field to it.


<!-- markdownlint-disable MD046 -->
???+ attention "Sourcemap File Limitations"

    All sourcemap files must have the extension (*.map*) and each *.map* file (after decompression) must not exceed 4GiB.
<!-- markdownlint-enable -->

### Install Sourcemap Toolset {#install-tools}

First, install the corresponding symbol restoration tools. DataKit provides a one-click installation command to simplify the installation of these tools:

```shell
sudo datakit install --symbol-tools
```

If any software fails to install during this process, you may need to manually install the corresponding software based on the error messages.

### Zip Package Instructions {#zip}

<!-- markdownlint-disable MD046 -->
=== "Web"

    Compress the *.map* files generated by webpack-obfuscated and compressed js files into a zip package, then copy it to *<DataKit installation directory\>/data/rum/web* directory. Ensure the unpacked file paths match the URL paths in the `error_stack`. Assuming the following `error_stack`:

    ```
    ReferenceError
      at a.hideDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1037
      at a.showDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:986
      at <anonymous> @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1174
    ```

    The path to be converted is */static/js/app.7fb548e3d065d1f48f74.js*, with its corresponding sourcemap path being */static/js/app.7fb548e3d065d1f48f74.js.map*. The unpacked directory structure should look like this:

    ```
    static/
    └── js
        └── app.7fb548e3d065d1f48f74.js.map
    
    ```

    The converted `error_stack_source`:
    
    ```
    
    ReferenceError
      at a.hideDetail @ webpack:///src/components/header/header.vue:94:0
      at a.showDetail @ webpack:///src/components/header/header.vue:91:0
      at <anonymous> @ webpack:///src/components/header/header.vue:101:0
    ```

=== "Mini Program"

    Similar to Web packaging, but note that the packed `.zip` file should be copied to *<DataKit installation directory\>/data/rum/miniapp* rather than *<DataKit installation directory\>/data/rum/web*.

=== "Android"

    Android currently has two types of `sourcemap` files: one is the mapping file produced after Java bytecode is compressed and obfuscated using `R8`/`Proguard`, and the other is unstripped (unremoved symbols and debug information) `.so` files for C/C++ native code. If your Android application includes both types of `sourcemap` files, you need to pack both into the zip package before copying it to *<DataKit installation directory\>/data/rum/android*. The unpacked directory structure looks similar to:

    ```
    <app_id>-<env>-<version>/
    ├── mapping.txt
    ├── armeabi-v7a/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    ├── arm64-v8a/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    ├── x86/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    └── x86_64/
        ├── libgameengine.so
        ├── libothercode.so
        └── libvideocodec.so
    ```

    By default, the mapping file is located at *<project folder\>/<Module\>/build/outputs/mapping/<build-type\>/*, and the `.so` files are found at *<project folder\>/<Module\>/build/intermediates/cmake/debug/obj/* for CMake builds or *<project folder\>/<Module\>/build/intermediates/ndk/debug/obj/* for NDK builds (debug build) or *<project folder\>/<Module\>/build/intermediates/ndk/release/obj/* for release builds.

    Conversion effects:

    === "Java/Kotlin"

        Original `error_stack` :

        ```
        java.lang.ArithmeticException: divide by zero
            at prof.wang.activity.TeamInvitationActivity.o0(Unknown Source:1)
            at prof.wang.activity.TeamInvitationActivity.k0(Unknown Source:0)
            at j9.f7.run(Unknown Source:0)
            at java.lang.Thread.run(Thread.java:1012)
        ```
        
        Converted `error_stack_source` :
    
        ```
        java.lang.ArithmeticException: divide by zero
        at prof.wang.activity.TeamInvitationActivity.onClick$lambda-0(TeamInvitationActivity.java:1)
        at java.lang.Thread.run(Thread.java:1012)
        ```

    === "C/C++ Native Code"

        Original `error_stack` :
    
        ```
        backtrace:
        #00 pc 00000000000057fc  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_4+12)
        #01 pc 00000000000058a4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_3+8)
        #02 pc 00000000000058b4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_2+12)
        #03 pc 00000000000058c4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_1+12)
        #04 pc 0000000000005938  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_crash+112)
        ...
        ```
        
        Converted `error_stack_source` :
    
        ```
        backtrace:
        
        Abort message: 'abort message for ftNative internal testing'
        #00 0x00000000000057fc /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_4+12)
        xc_test_call_4
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:65:9
        #01 0x00000000000058a4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_3+8)
        xc_test_call_3
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:73:13
        #02 0x00000000000058b4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_2+12)
        xc_test_call_2
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:79:13
        #03 0x00000000000058c4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_1+12)
        xc_test_call_1
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:85:13
        #04 0x0000000000005938 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_crash+112)
        xc_test_crash
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:126:9
        ...
        ```

=== "iOS"

    On the iOS platform, the `sourcemap` file is a symbol table file with debugging information and a `.dSYM` extension. It is generally located in the same directory as the `.app` file after project compilation, as shown below:

    ``` shell
    $ ls -l Build/Products/Debug-iphonesimulator/
    total 0
    drwxr-xr-x   6 zy  staff  192  8  9 15:27 Fishing.app
    drwxr-xr-x   3 zy  staff   96  8  9 14:02 Fishing.app.dSYM
    drwxr-xr-x  15 zy  staff  480  8  9 15:27 Fishing.doccarchive
    drwxr-xr-x   6 zy  staff  192  8  9 13:55 Fishing.swiftmodule
    ```

    Note that XCode Release builds generate `.dSYM` files by default, while Debug builds do not. You need to adjust the following settings in XCode:

    ```not-set
    Build Settings -> Code Generation -> Generate Debug Symbols -> Yes
    Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File
    ```

    When zipping up, include the corresponding `.dSYM` files in the zip package. If your project involves multiple `.dSYM` files, they should all be included in the zip package, which should then be copied to *<DataKit installation directory\>/data/rum/ios*. The unpacked directory structure would look similar to this (`.dSYM` files are essentially directories, similar to macOS executable programs *.app*):

    ```
    <app_id>-<env>-<version>/
    ├── AFNetworking.framework.dSYM
    │   └── Contents
    │       ├── Info.plist
    │       └── Resources
    │           └── DWARF
    │               └── AFNetworking
    └── App.app.dSYM
        └── Contents
            ├── Info.plist
            └── Resources
                └── DWARF
                    └── App
    
    ```
<!-- markdownlint-enable -->

---

<!-- markdownlint-disable MD046 -->
???+ attention "RUM Headless Explanation"

    For [RUM Headless](../dataflux-func/headless.md) users, you can directly upload the compressed package via the web interface, eliminating the need for the subsequent file upload and deletion operations.
<!-- markdownlint-enable -->

### File Upload and Deletion {#upload-delete}

After packaging, besides manually copying the files to the relevant DataKit directories, you can also upload and delete files through HTTP interfaces.

> Starting from DataKit [:octicons-tag-24: Version-1.16.0](../datakit/changelog.md#cl-1.16.0), the previously provided sourcemap-related interfaces via DCA services have been deprecated and moved to the DataKit service.

[Upload](../datakit/apis.md#api-sourcemap-upload):

```shell
curl -X PUT '<datakit_address>/v1/sourcemap?app_id=<app_id>&env=<env>&version=<version>&platform=<platform>&token=<token>' -F "file=@<sourcemap_path>" -H "Content-Type: multipart/form-data"
```

[Delete](../datakit/apis.md#api-sourcemap-delete):

```shell
curl -X DELETE '<datakit_address>/v1/sourcemap?app_id=<app_id>&env=<env>&version=<version>&platform=<platform>&token=<token>'
```

[Verify sourcemap](../datakit/apis.md#api-sourcemap-check):

```shell
curl -X GET '<datakit_address>/v1/sourcemap/check?app_id=<app_id>&env=<env>&version=<version>&platform=<platform>&error_stack=<error_stack>'
```

Variable explanations:

- `<datakit_address>`: Address of the DataKit service, e.g., `http://localhost:9529`
- `<token>`: Token configured in the `datakit.conf` file under `dataway`
- `<app_id>`: Corresponding RUM `applicationId`
- `<env>`: Corresponding RUM `env`
- `<version>`: Corresponding RUM `version`
- `<platform>` Application platform, currently supporting `web/miniapp/android/ios`
- `<sourcemap_path>`: Path to the `sourcemap` compressed package file to be uploaded
- `<error_stack>`: `error_stack` that needs verification

<!-- markdownlint-disable MD046 -->
???+ attention
    - The upload and delete interfaces require `token` authentication
    - This conversion process applies only to the `error` measurement set
    - Currently, only JavaScript/Android/iOS sourcemap conversions are supported
    - If the corresponding sourcemap file is not found, no conversion will take place
    - Sourcemap compressed packages uploaded via the interface do not require a DataKit restart to take effect. However, manual uploads require a DataKit restart to take effect.
<!-- markdownlint-enable -->

## CDN Annotation {#cdn-resolve}

For the `resource` measurement set, DataKit attempts to analyze whether resources use a CDN and the specific CDN provider. When the `provider_type` field in the measurement set is "CDN", it indicates that the resource uses a CDN, and the `provider_name` field specifies the CDN provider.

### Customizing the CDN Query List {#customize-cdn-map}

DataKit includes a built-in list of mainstream CDN providers. If you find that the CDN you are using is not correctly identified, you can modify this list in the configuration file, which by default is located at */usr/local/datakit/conf.d/rum/rum.conf* (depending on your DataKit installation location). The `cdn_map` configuration item is used to customize the CDN list, with a JSON format similar to the following:

```json
[
  {
    "domain": "alicdn.com",
    "name": "Aliyun CDN",
    "website": "https://www.aliyun.com"
  },
  ...
]
```

You can simply copy the [built-in CDN configuration list](built-in_cdn_dict_config.md){:target="_blank"}, modify it, and paste it into the configuration file. A restart of DataKit is required after modifications.

## RUM Session Replay {#rum-session-replay}

Starting from DataKit [:octicons-tag-24: Version-1.5.5](../datakit/changelog.md#cl-1.5.5), support was added for collecting RUM session replay data. This requires modifying the RUM collector configuration to add the `session_replay_endpoints` configuration item and restarting Datakit.

```toml
[[inputs.rum]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/v1/write/rum"]

  ## use to upload rum screenshot,html,etc...
  session_replay_endpoints = ["/v1/write/rum/replay"]

  ...
```

<!-- markdownlint-disable MD046 -->
???+ info

    The default location of the RUM configuration file is */usr/local/datakit/conf.d/rum/rum.conf* (Linux/macOS) and *C:\\Program Files\\datakit\\conf.d\\rum* (Windows), depending on your operating system and DataKit installation location.
<!-- markdownlint-enable -->

### Filtering RUM Session Replay Data {#rum-session-replay-filter}

Starting from DataKit [:octicons-tag-24: Version-1.20.0](../datakit/changelog.md#cl-1.20.0), support was added for filtering out unnecessary session replay data using new configuration items named `filter_rules`. The format is similar to the following (refer to the `rum.conf.sample` RUM sample configuration file):

```toml
[inputs.rum.session_replay]
#   cache_path = "/usr/local/datakit/cache/session_replay"
#   cache_capacity_mb = 20480
#   clear_cache_on_start = false
#   upload_workers = 16
#   send_timeout = "75s"
#   send_retry_count = 3
   filter_rules = [
       "{ service = 'xxx' or version IN [ 'v1', 'v2'] }",
       "{ app_id = 'yyy' and env = 'production' }"
   ]
```

`filter_rules` is an array of rules where each rule is logically "or". That is, if any single rule matches, the session replay data will be discarded. Only data that does not match any rule will be retained. Supported fields for filtering rules are listed in the table below:

| Field Name                 | Type     | Description                 | Example              |
|---------------------|--------|--------------------|-----------------|
| `app_id`            | string | Application ID              | appid_123456789 |
| `service`           | string | Service name               | user_center     |
| `version`           | string | Service version               | v1.0.0          |
| `env`               | string | Deployment environment             | production      |
| `sdk_name`          | string | RUM SDK name         | df_web_rum_sdk  |
| `sdk_version`       | string | RUM SDK version         | 3.1.5           |
| `source`            | string | Data source               | browser         |
| `has_full_snapshot` | string | Whether it is full data            | false           |
| `raw_segment_size`  | int    | Size of raw session replay data (unit: bytes) | 656             |