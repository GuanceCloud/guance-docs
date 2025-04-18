# 更新日志

---
## **1.5.15 (2025/04/14)** {#1-5-15}

1. 修复 Swift Package Manager 编译报错问题

## **1.5.14 (2025/03/07)** {#1-5-14}

1. 新增 RUM `Resource` 数据字段 `resource_first_byte_time`、`resource_dns_time`、`resource_download_time`、`resource_connect_time`、`resource_ssl_time`、`resource_redirect_time`，支持在观测云上 Resource 耗时增强展示，并在支持「应用性能监测」火焰图对齐时间轴

2. 默认开启 `FTMobileConfig.enableDataIntegerCompatible` 

3. 新增支持通过宏定义 `FT_DISABLE_SWIZZLING_RESOURCE` 关闭 SDK 内 URLSession Method Swizzling 方法

4. 优化数据同步，添加失败重传逻辑

## **1.5.13** (2025/02/27) {#1-5-13}

1. 优化页面采集逻辑，防止特殊视图导致 RUM View 采集缺失

## **1.5.12** (2025/02/10) {#1-5-12}

1. 调整文件存储路径配置，修复 tvOS 环境数据库创建失败的问题
2. 更新了 tvOS 环境的默认 `service` 和日志 `source`，分别设置为 `df_rum_tvos` 和 `df_rum_tvos_log`
3. 修复 RUM Action 事件中 `duration` 时长计算不准确的问题

## **1.5.11 (2025/02/05)** {#1-5-11}

1. RUM Resource 采集优化，防止 RUM 开启 Resource 自动采集时采集 SDK 内请求
2. 修复 Widget Extension 中 skyWalking 类型链路追踪失败问题

## **1.5.10 (2025/01/21)** {#1-5-10}

1. 支持通过 `FTTraceConfig.traceInterceptor` 拦截 Request 自定义 Trace，通过 `FTRumConfig.resourcePropertyProvider` 添加 RUM Resource 自定义属性
2. 修复动态添加全局属性方法在多线程访问下的异常问题
3. 优化 WebView 传入数据信息

## **1.5.9 (2025/01/08)** {#1-5-9}

1. 新增支持通过 `FTURLSessionDelegate.traceInterceptor` block 拦截 `URLRequest`，进行自定义链路追踪、更改链路中 spanId 与 traceId
2. RUM Resource 支持采集通过 swift async/await URLSession API 发起的网络请求
3. 修复 LongTask 与 Anr 关联 View 错误问题

## **1.5.8 (2024/12/23)** {#1-5-8}

1. 增加 tvOS 支持
2. 支持通过 `FTRUMConfig.rumCacheLimitCount` 来限制 RUM 最大缓存条目数，
   支持通过 `FTRUMConfig.rumDiscardType` 设置丢弃策略
3. 支持通过 `FTMobileConfig.enableLimitWithDbSize` 限制总缓存大小功能，开启之后
   `FTLoggerConfig.logCacheLimitCount` 及 `FTRUMConfig.rumCacheLimitCount` 将失效，
   支持通过 `FTMobileConfig.dbDiscardType` 设置 db 丢弃策略、
   通过 `FTMobileConfig.dbCacheLimit` 设置 db 缓存限制大小

## **1.5.7 (2024/12/04)** {#1-5-7}

1. 支持通过 `FTRUMConfig.freezeDurationMs` 设置卡顿检测阀值
2. 优化 SDK 的 `shutDown` 方法，避免主线程同步等待导致的卡顿或 WatchDog 崩溃

## **1.5.6 (2024/11/13)** {#1-5-6}

1. 支持使用 `FTMobileConfig.compressIntakeRequests` 对同步数据进行 deflate 压缩配置
2. RUM 添加 `addAction:actionType:property` 与 `startAction:actionType:property:` 方法，
   优化 RUM Action 采集逻辑
3. 修复使用 NSFileHandle 废弃 api 导致的崩溃问题

##  **1.5.5 (2024/11/06)** {#1-5-5}

1. 修复 `FTResourceMetricsModel` 中数组越界导致的崩溃问题

##  **1.5.4 (2024/10/18)** {#1-5-4}

1. 添加全局、log、RUM globalContext 属性动态设置方式
2. 添加清除数据方法，支持删除所有尚未上传至服务器的数据
3. 调整同步间歇支持的最大时间间隔至 5000 毫秒

## **1.5.3 (2024/10/09)** {#1-5-3}

1. 修复 LongTask、Anr 采集时因属性修饰符使用错误而导致的内存访问错误崩溃
2. 使用内部警告日志替换 `FTSwizzler` 中方法签名验证断言
3. 优化采集数据的小数精度

## **1.5.2 (2024/08/21)** {#1-5-2}

1. 修复 Xcode 16 编译缺少 `#include <arm/_mcontext.h>` 头文件问题
2. 自动采集 RUM-Resource 时，过滤掉直接从本地缓存获取或获取类型未知的 Resource，防止采集重复
3. 修复 UITabBarController 子视图 loadingTime 计算逻辑

## **1.5.1 (2024/08/02)** {#1-5-1}

1. 修复行协议数据转义算法，解决因换行符导致数据同步失败问题
2. 优化错误类型为 `network_error` 的错误信息，统一使用英文描述网络请求错误码
3. 优化数据同步逻辑，修复多线程访问已释放 `uploadDelayTimer` 导致的崩溃问题
4. 修复采集崩溃信息时 OC 与 C 字符串转换时编码格式错误导致的崩溃问题

## **1.5.0 (2024/06/03)** {#1-5-0}

1. RUM resource 网络请求添加 remote ip 地址解析功能
2. 添加行协议 Integer 数据兼容模式，处理 web 数据类型冲突问题
3. 日志添加自定义 status 方法
4. 日志数据写入优化、数据同步优化
5. 对传入 SDK 的 NSDictionary 类型参数进行格式处理防止转换 json 失败造成数据丢失

## **1.4.14 (2024/05/29)** {#1-4-14}

1. 修复 `FTSwizzler` 内访问已被销毁的 Class 对象而导致的内存访问错误崩溃
2. 修复向 SDK 传递的 NSDictionary 类型参数实际上是可变对象时可能引发的数据一致性和操作冲突问题

## **1.4.13 (2024/05/15)** {#1-4-13}

1. RUM LongTask、Anr 采集优化，修复 LongTask 堆栈信息采集不准确问题，新增支持采集致命卡顿
2. 修复 `FTSwizzler` 内因多线程同时操作 NSMutableSet 造成的崩溃
3. 修复打包 SDK Framework info.plist 中版本信息缺失问题
4. 修复自定义 NSURLSession 未设置 delegate 时 Resource 的性能指标采集失败问题
5. SDK 内部日志转化为文件功能优化，新增指定文件路径方法

## **1.4.12 (2024/04/26)** {#1-4-12}

1. 修复 SDK 调用注销方法 shutDown 产生的内存泄漏问题
2. 修复采集 RUM-Resource 时与其他库冲突导致崩溃问题
3. 修复崩溃采集 UncaughtExceptionHandler 未传递问题
4. 修复多次初始化 SDK 造成的数据异常

## **1.4.11(2024/03/28)** {#1-4-11}

1. 新增支持数据同步参数配置，请求条目数据，同步间歇时间，以及日志缓存条目数
2. 新增内部日志转文件方法
3. 日志关联 RUM 数据获取错误修复
4. 耗时操作优化
5. 修复 WebView jsBridge 时产生的崩溃，对 WebView 引用改为弱引用

[更多日志](https://github.com/GuanceCloud/datakit-ios/blob/develop/CHANGELOG.md)
