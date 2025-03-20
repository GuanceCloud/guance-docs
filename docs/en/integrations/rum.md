---
title     : 'RUM'
summary   : 'Collect user behavior data'
tags:
  - 'RUM'
__int_icon      : 'icon/rum'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The RUM (Real User Monitor) collector is used to collect real-user monitoring data reported from web pages or mobile terminals.

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

It is recommended to deploy RUM separately on the public network, not together with existing services (such as Kubernetes clusters). Since the traffic on this RUM interface may be very high, internal cluster traffic could be disrupted by it. Additionally, some potential internal cluster resource scheduling mechanisms might affect the operation of the RUM service.

- [Install IP geographic information database on DataKit](../datakit/datakit-tools-how-to.md#install-ipdb)
- Starting from [1.2.7](../datakit/changelog.md#cl-1.2.7), due to changes in the installation method of the IP geographic information database, the default installation no longer includes an IP information database and must be manually installed.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/rum` directory under the DataKit installation directory, copy `rum.conf.sample`, and rename it to `rum.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.rum]]
      ## profile Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/v1/write/rum"]
    
      ## used to upload rum session replay.
      session_replay_endpoints = ["/v1/write/rum/replay"]
    
      ## specify which Metrics should be captured.
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

    In *datakit.yaml*, add the `ENV_DEFAULT_ENABLED_INPUTS` environment variable with the `rum` collector name (as shown first in the `value`):

    ```yaml
    - name: ENV_DEFAULT_ENABLED_INPUTS
      value: rum,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container
    ```
<!-- markdownlint-enable -->

### Security Restrictions {#security-setting}

Refer to [Datakit API Access Control](../datakit/datakit-conf.md#public-apis).

### Disable DataKit 404 Page {#disable-404}

You can disable public access to the DataKit 404 page through the following configuration:

```toml
# datakit.conf
disable_404page = true
```

## Metrics {#metric}

The RUM collector defaults to collecting the following Measurement sets:

- `error`
- `view`
- `resource`
- `long_task`
- `action`

## Sourcemap Conversion {#sourcemap}

Typically, production js files or mobile App code undergo obfuscation and compression to reduce application size. The call stack during errors differs significantly from the source code during development, making it inconvenient for debugging. To locate errors back to the source code, sourcemap files need to be used.

DataKit supports this mapping of source code file information. The method involves zipping and compressing the corresponding symbol table files, naming them in the format *[app_id]-[env]-[version].zip*, and uploading them to *[DataKit installation directory]/data/rum/[platform]*. This way, the `error` Measurement set data can be automatically converted, and the `error_stack_source` field is appended to this Measurement set.


<!-- markdownlint-disable MD046 -->
???+ attention "Sourcemap File Limitations"

    All Sourcemap files must have the (*.map*) extension, and each *.map* file (after decompression) must not exceed 4GiB.
<!-- markdownlint-enable -->

### Install Sourcemap Toolset {#install-tools}

First, install the corresponding symbol restoration tools. Datakit provides a one-click installation command to simplify the installation process:

```shell
sudo datakit install --symbol-tools
```

If certain software fails to install during the process, you may need to manually install the corresponding software based on the error prompts.

### Zip Package Packing Instructions {#zip}

<!-- markdownlint-disable MD046 -->
=== "Web"

    Compress and zip the *.map* files generated after webpack obfuscates and compresses the js files, then copy them to *<DataKit installation directory\>/data/rum/web* directory. Ensure that the file paths after decompression match the URL paths in `error_stack`. Assuming the following `error_stack`:

    ```
    ReferenceError
      at a.hideDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1037
      at a.showDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:986
      at <anonymous> @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1174
    ```

    The path to convert is */static/js/app.7fb548e3d065d1f48f74.js*, and its corresponding sourcemap path is */static/js/app.7fb548e3d065d1f48f74.js.map*. Thus, the directory structure after decompressing the corresponding zip package is as follows:

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

=== "Mini Programs"

    The packaging method is basically the same as Web, but note that the packed `.zip` file should be copied to *<DataKit installation directory\>/data/rum/miniapp* rather than *<DataKit installation directory\>/data/rum/web*.

=== "ANDROID"

    Currently, Android has two types of `sourcemap` files: one is the mapping file produced after Java bytecode is compressed and obfuscated by `R8`/`Proguard`, and the other is the unstripped `.so` file compiled from C/C++ native code that retains symbol tables and debugging information. If your Android application contains both these `sourcemap` files, both types of files need to be included in the zip package during packing, and then the zip package should be copied to *<DataKit installation directory\>/data/rum/android*. The directory structure after decompressing the zip package is similar to:

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

    By default, mapping files are located at: *<project folder\>/<Module\>/build/outputs/mapping/<build-type\>/*, `.so` files are found at: *<project folder\>/<Module\>/build/intermediates/cmake/debug/obj/* when using CMake compilation, or at: *<project folder\>/<Module\>/build/intermediates/ndk/debug/obj/* (debug compilation) or *<project folder\>/<Module\>/build/intermediates/ndk/release/obj/* (release compilation) when using NDK compilation.

    The conversion effect is as follows:

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

=== "IOS"

    On the iOS platform, the `sourcemap` files are symbol table files with the `.dSYM` extension containing debug information. These are generally located in the same directory as the `.app` file after project compilation, as shown below:

    ``` shell
    $ ls -l Build/Products/Debug-iphonesimulator/
    total 0
    drwxr-xr-x   6 zy  staff  192  8  9 15:27 Fishing.app
    drwxr-xr-x   3 zy  staff   96  8  9 14:02 Fishing.app.dSYM
    drwxr-xr-x  15 zy  staff  480  8  9 15:27 Fishing.doccarchive
    drwxr-xr-x   6 zy  staff  192  8  9 13:55 Fishing.swiftmodule
    ```

    Note that XCode Release compilation generates `.dSYM` files by default, while Debug compilation does not. You can adjust XCode settings accordingly:

    ```not-set
    Build Settings -> Code Generation -> Generate Debug Symbols -> Yes
    Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File
    ```

    When performing zip packaging, include the corresponding `.dSYM` files into the zip package. If your project involves multiple `.dSYM` files, they should all be packaged into the zip, and then the zip package should be copied to *<DataKit installation directory\>/data/rum/ios*. The extracted directory structure should look similar to the following (`.dSYM` files are essentially directories, similar to macOS executable programs *.app*):


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
???+ attention "RUM Headless Description"

    For [RUM Headless](../dataflux-func/headless.md) users, you can directly upload the compressed package on the page without performing the following file upload and deletion operations.
<!-- markdownlint-enable -->

### File Upload and Deletion {#upload-delete}

After packaging, besides manually copying to the relevant DataKit directory, you can also upload and delete the file via the http interface.

> Starting from Datakit [:octicons-tag-24: Version-1.16.0](../datakit/changelog.md#cl-1.16.0), the sourcemap-related interfaces previously provided by DCA services have been deprecated and moved to DataKit services.

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
- `<token>`: Token in the configuration file `datakit.conf` under `dataway`
- `<app_id>`: Corresponding RUM `applicationId`
- `<env>`: Corresponding RUM `env`
- `<version>`: Corresponding RUM `version`
- `<platform>` Application platforms, currently supported `web/miniapp/android/ios`
- `<sourcemap_path>`: Path of the `sourcemap` compressed package file to be uploaded
- `<error_stack>`: `error_stack` to be verified

<!-- markdownlint-disable MD046 -->
???+ attention
    - The upload and delete interfaces require `token` authentication
    - This conversion process only applies to the `error` Measurement set
    - Currently only supports Javascript/Android/iOS sourcemap conversion
    - If the corresponding sourcemap file is not found, no conversion will occur
    - Sourcemap compressed packages uploaded via the interface do not require DataKit to be restarted to take effect. However, if uploaded manually, DataKit needs to be restarted for it to take effect
<!-- markdownlint-enable -->

## CDN Annotation {#cdn-resolve}

For the `resource` Metric, DataKit attempts to analyze whether the resource uses CDN and the corresponding CDN provider. When the `provider_type` field in the Measurement set has the value "CDN", it indicates that the resource uses CDN, and at this point, the `provider_name` field value represents the specific CDN provider name.

### Customize CDN Query List {#customize-cdn-map}

DataKit includes a built-in list of mainstream CDN provider information. If you find that the CDN you use cannot be correctly identified, you can modify this list in the configuration file. The configuration file is located by default at */usr/local/datakit/conf.d/rum/rum.conf*, specifically depending on your DataKit installation location. The `cdn_map` configuration item in it is used to customize the CDN list set, and the configuration value is a JSON similar to the following:

```json
[
  {
    "domain": "alicdn.com",
    "name": "Alibaba Cloud CDN",
    "website": "https://www.aliyun.com"
  },
  ...
]
```

You can simply copy the [built-in CDN configuration list](built-in_cdn_dict_config.md){:target="_blank"}, modify it, and paste it directly into the configuration file. After modification, DataKit needs to be restarted.

## RUM SESSION REPLAY {#rum-session-replay}

Starting from Datakit [:octicons-tag-24: Version-1.5.5](../datakit/changelog.md#cl-1.5.5), support was added for collecting RUM session replay data. This function requires modifying the RUM collector configuration, adding the `session_replay_endpoints` configuration item, and restarting Datakit.

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

    The RUM configuration file is typically located at */usr/local/datakit/conf.d/rum/rum.conf* (Linux/macOS) and *C:\\Program Files\\datakit\\conf.d\\rum* (Windows), specifically depending on the operating system and Datakit installation location you are using.
<!-- markdownlint-enable -->

### Filtering of RUM Session Replay Data {#rum-session-replay-filter}

Starting from Datakit [:octicons-tag-24: Version-1.20.0](../datakit/changelog.md#cl-1.20.0), support was added for filtering out unnecessary session replay data using configuration. A new configuration item named `filter_rules` was added, formatted similarly as follows (you can refer to the `rum.conf.sample` RUM sample configuration file):

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

`filter_rules` is an array of rules, and each rule has an "or" logical relationship between them. That is, any session replay data that matches any one of the rules will be discarded, and only data that does not match all rules will be retained. The fields currently supported by the filtering rules are shown in the following table:

| Field Name                 | Type     | Description                 | Example              |
|---------------------|--------|--------------------|-----------------|
| `app_id`            | string | Application ID              | appid_123456789 |
| `service`           | string | Service Name               | user_center     |
| `version`           | string | Service Version               | v1.0.0          |
| `env`               | string | Service Deployment Environment             | production      |
| `sdk_name`          | string | RUM SDK Name         | df_web_rum_sdk  |
| `sdk_version`       | string | RUM SDK Version         | 3.1.5           |
| `source`            | string | Data Source               | browser         |
| `has_full_snapshot` | string | Whether it is full data            | false           |
| `raw_segment_size`  | int    | Size of original session replay data (unit: bytes) | 656             |