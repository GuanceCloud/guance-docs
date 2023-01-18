---
icon: material/apple-ios
---
# iOS

---

## 视图预览

iOS 应用的概览场景统计 iOS 访问的启动次数、PV 数、页面错误率、页面加载时间、会话分析、性能分析、错误分析等指标。<br/>
从 iOS 应用启动、会话分布、访问用户设备、受欢迎页面排行、页面访问量排行、资源错误排行等方面，可视化的展示用户访问 iOS 应用的数据统计，快速定位用户访问 iOS 应用的问题，提高用户访问性能。还可通过环境、版本筛选查看已经接入的 iOS 应用。

![image](../imgs/input-rum-ios-1.png)

#### 性能分析

iOS 应用的性能分析，通过统计 PV 数、页面加载时间、最受关注页面会话数、页面长任务分析、资源分析等指标，可视化的实时查看整体的 iOS 应用页面性能情况，更精准的定位需要优化的页面，可通过环境、版本等筛选查看已经接入的 iOS 应用。

![image](../imgs/input-rum-ios-2.png)

#### 资源分析

iOS 应用的资源分析，通过统计资源分类、XHR & Fetch 分析、资源耗时分析等指标，可视化的实时查看整体的 iOS 应用资源情况；通过统计资源请求排行，更精准的定位需要优化的资源；可通过环境、版本等筛选查看已经

![image](../imgs/input-rum-ios-3.png)

#### 错误分析

iOS 应用的 JS 错误分析，通过统计错误率、Crash、Crash 版本、网络错误状态分布等指标，可视化的实时查看整体的 iOS 应用错误情况；通过受影响的资源错误统计，可快速定位资源错误；可通过环境、版本等筛选查看已经接入的 iOS 应用。

![image](../imgs/input-rum-ios-4.png)

## 安装部署

### 前置条件

- <[安装 DataKit](../../datakit/datakit-install.md)>

### 应用接入

总共分两步

#### 第 1 步：创建一个 iOS 应用

登录观测云控制台，进入「用户访问监测」页面 - 「新建应用」- 输入「应用名称」- 点击「创建」，即可开始配置。

![image](../imgs/input-rum-ios-5.png)

#### 第 2 步：接入

##### 方式一：CocoaPods 集成（推荐）

![image](../imgs/input-rum-ios-6.png)

1、 配置 `Podfile` 文件。

```objective-c
target 'yourProjectName' do

# Pods for your project
 pod 'FTMobileSDK', '~> 1.1.0-alpha.10'

end

```

在 `Podfile` 目录下执行 `pod install` 安装 SDK

##### 方式二：手动集成（直接下载 SDK）

1、 从 [GitHub](https://github.com/DataFlux-cn/datakit-ios) 获取 SDK 的源代码。

2、 将 `FTMobileSDK` 整个文件夹导入项目。

![image](../imgs/input-rum-ios-7.png)

勾选 「`Copy items id needed`」

![image](../imgs/input-rum-ios-8.png)

3、 添加依赖库：项目设置 `Build Phase` -> `Link Binary With Libraries` 添加：`UIKit` 、 `Foundation` 、`libz.tb`。

### 初始化并调用 SDK

#### 添加头文件

请将 `#import "FTMobileAgent.h"` 添加到 `AppDelegate.m` 引用头文件的位置。

#### 添加初始化代码

示例：

```
 #import <FTMobileAgent/FTMobileAgent.h>
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
     // SDK FTMobileConfig 设置
    FTMobileConfig *config = [[FTMobileConfig alloc]initWithMetricsUrl:@"Your App metricsUrl"];
    config.monitorInfoType = FTMonitorInfoTypeAll;
     //启动 SDK
    [FTMobileAgent startWithConfigOptions:config];
    return YES;
}
```

**metricsUrl 数据上报地址：**

出于安全考虑，DataKit 的 HTTP 服务默认绑定在 `localhost:9529` 上，如果希望从外部访问，需编辑 `/usr/local/datakit/conf.d/datakit.conf` 中的 `http_listen` 字段，将其改成 `0.0.0.0:9529` 或 `其它网卡、端口`。
> **举例：**比如我公网 ip 是 1.1.1.1 我先到配置中改 0.0.0.0，app 中 metricsUrl 地址为 [http://1.1.1.1:9529](http://1.1.1.1:9529/)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - iOS 应用概览> <br/>
<场景 - 新建仪表板 - 模板库 - 系统视图 - iOS 应用错误分析>

## 指标详解

<[iOS 应用数据采集指标](../../real-user-monitoring/ios/app-data-collection.md)>

## 故障排查

暂无
