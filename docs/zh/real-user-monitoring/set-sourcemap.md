# SourceMap 配置
---

## 简介

Sourcemap（源代码映射）用于将生产环境中的压缩代码映射回原始的源代码。RUM 支持这种源代码文件信息的映射，方法是将对应符号表文件进行 zip 压缩打包、上传，这样就可以对上报的 error 指标集数据自动进行转换。


## Zip 包打包说明


<!-- markdownlint-disable MD046 -->
=== "Web"

    将 js 文件经 webpack 混淆和压缩后生成的 *.map* 文件进行 zip 压缩打包，必须要保证该压缩包解压后的文件路径与 `error_stack` 中 URL 的路径一致。 假设如下 `error_stack`：

    ```
    ReferenceError
      at a.hideDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1037
      at a.showDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:986
      at <anonymous> @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1174
    ```

    需要转换的路径是 */static/js/app.7fb548e3d065d1f48f74.js*，与其对应的 sourcemap 路径为 */static/js/app.7fb548e3d065d1f48f74.js.map*，那么对应压缩包解压后的目录结构如下：

    ```
    static/
    └── js
    └── app.7fb548e3d065d1f48f74.js.map
    
    ```

    转换后的 `error_stack_source`：
    
    ```
    
    ReferenceError
      at a.hideDetail @ webpack:///src/components/header/header.vue:94:0
      at a.showDetail @ webpack:///src/components/header/header.vue:91:0
      at <anonymous> @ webpack:///src/components/header/header.vue:101:0
    ```

=== "小程序"

    同 Web 的打包方式基本保持一致。

=== "Android"

    Android 目前存在两种 `sourcemap` 文件，一种是 Java 字节码经 `R8`/`Proguard` 压缩混淆后产生的 mapping 文件，另一种为 C/C++ 原生代码编译时未清除符号表和调试信息的（unstripped） `.so` 文件，如果你的安卓应用同时包含这两种 `sourcemap` 文件， 打包时需要把这两种文件都打包进 zip 包中。zip 包解压后的目录结构类似：
    
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

    默认情况下，mapping 文件将位于： *<项目文件夹\>/<Module\>/build/outputs/mapping/<build-type\>/*，`.so` 文件在用 CMake 编译项目时位于： *<项目文件夹\>/<Module\>/build/intermediates/cmake/debug/obj/*，用 NDK 编译时位于：*<项目文件夹\>/<Module\>/build/intermediates/ndk/debug/obj/*（debug 编译）或 *<项目文件夹\>/<Module\>/build/intermediates/ndk/release/obj/*（release 编译）。

    转换的效果如下：

    === "Java/Kotlin"

        转换前 `error_stack` :

        ```
        java.lang.ArithmeticException: divide by zero
            at prof.wang.activity.TeamInvitationActivity.o0(Unknown Source:1)
            at prof.wang.activity.TeamInvitationActivity.k0(Unknown Source:0)
            at j9.f7.run(Unknown Source:0)
            at java.lang.Thread.run(Thread.java:1012)
        ```
        
        转换后 `error_stack_source` :
    
        ```
        java.lang.ArithmeticException: divide by zero
        at prof.wang.activity.TeamInvitationActivity.onClick$lambda-0(TeamInvitationActivity.java:1)
        at java.lang.Thread.run(Thread.java:1012)
        ```

    === "C/C++ 原生代码"

        转换前 `error_stack` :
    
        ```
        backtrace:
        #00 pc 00000000000057fc  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_4+12)
        #01 pc 00000000000058a4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_3+8)
        #02 pc 00000000000058b4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_2+12)
        #03 pc 00000000000058c4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_1+12)
        #04 pc 0000000000005938  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_crash+112)
        ...
        ```
        
        转换后 `error_stack_source` :
    
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

    iOS 平台上的 `sourcemap` 文件是以 `.dSYM` 为后缀的带有调试信息的符号表文件，一般情况下，项目编译完和 `.app` 文件在同一个目录下，如下所示：

    ``` shell
    $ ls -l Build/Products/Debug-iphonesimulator/
    total 0
    drwxr-xr-x   6 zy  staff  192  8  9 15:27 Fishing.app
    drwxr-xr-x   3 zy  staff   96  8  9 14:02 Fishing.app.dSYM
    drwxr-xr-x  15 zy  staff  480  8  9 15:27 Fishing.doccarchive
    drwxr-xr-x   6 zy  staff  192  8  9 13:55 Fishing.swiftmodule
    ```

    需要注意，XCode Release 编译默认会生成 `.dSYM` 文件，而 Debug 编译默认不会生成，需要对 XCode 做如下相应的设置：

    ```not-set
    Build Settings -> Code Generation -> Generate Debug Symbols -> Yes
    Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File
    ```

    进行 zip 打包时，把相应的 `.dSYM` 文件打包进 zip 包即可，如果你的项目涉及多个 `.dSYM` 文件，需要一起打包到 zip 包内，之后再把 zip 包拷贝到 *<DataKit 安装目录\>/data/rum/ios* 目录下，zip 包解压后的目录结构类似如下（`.dSYM` 文件本质上是一个目录，和 macOS 下的可执行程序 *.app* 文件类似）：


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

您可以使用 [**source-map-visualization**](https://evanw.github.io/source-map-visualization/) 等来源映射可视化工具，验证文件可用性。


## 文件上传和删除

配置打包完成后，用户可直接在前台页面进行文件上传和删除操作。

![](img/sourcemap_01.png)

在 🔍 栏下方，可查看已上传的文件名称及应用类型，您可输入文件名称搜索；点击 :fontawesome-regular-trash-can: 可删除当前文件。

???+ attention "上传须知"

    - 文件大小不能超过 500M；
    - 文件格式必须为 `.zip`；
    - 请确保该压缩包解压后的文件路径与 `error_stack` 中 URL 的路径一致；
    - 不能同时上传多个文件；
    - 上传同名文件会出现覆盖提示，请注意。


另外，支持 Datakit 采集器配置 Sourcemap 转换。

> 更多详情，可了解[Sourcemap 转换](../integrations/rum.md#sourcemap)。
