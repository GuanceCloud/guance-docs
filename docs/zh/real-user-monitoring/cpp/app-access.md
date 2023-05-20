# CPP 应用接入
---
## 前置条件

- 安装 DataKit（[DataKit 安装文档](../../datakit/datakit-install.md)）

## 应用接入
当前 CPP 版本暂时支持 Windows 和 Linux 平台。登录观测云控制台，进入「用户访问监测」页面，点击左上角「新建应用」，即可开始创建一个新的应用。

1.输入「应用名称」、「应用ID」，选择 「自定义」 应用类型

- 应用名称：用于识别当前用户访问监测的应用名称。
- 应用 ID ：应用在当前工作空间的唯一标识，对应字段：app_id 。该字段仅支持英文、数字、下划线输入，最多 48 个字符。

![](../img/image_14.png)
## 安装
![](https://img.shields.io/badge/dynamic/json?label=github&color=orange&query=$.version&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/version.json) ![](https://img.shields.io/badge/dynamic/json?label=cpp&color=blue&query=$.cpp_version&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=gcc&color=blue&query=$.gcc_support&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=cmake&color=blue&query=$.cmake&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/ft-sdk-package/badge/cpp/info.json)


**源码地址**：[https://github.com/GuanceCloud/datakit-cpp](https://github.com/GuanceCloud/datakit-cpp)

**Demo 地址**：[https://github.com/GuanceCloud/datakit-cpp/ft-sdk-sample](https://github.com/GuanceCloud/datakit-cpp/tree/dev/ft-sdk-sample)



## 初始化

```cpp

	auto sdk = FTSDKFactory::get("ft_sdk_config.json");
	sdk->init();

    FTSDKConfig gc;
    gc.setServerUrl("http://10.0.0.1:9529")
        .setEnv(EnvType::PROD)
        .addGlobalContext("custom_key","custom_value")
        .setEnableFileDBCache(true);

```

| **字段** | **类型** | **必须** | **说明** |
| --- | --- | --- | --- |
| setServerUrl | string | 是 | datakit 安装地址 URL 地址，例子：http://10.0.0.1:9529，端口默认 9529。注意：安装 SDK 设备需能访问这地址 |
| setEnv | enum EnvType | 否 | 环境，默认`prod` |
| setEnableFileDBCache | Bool | 否 | 是否开启本地数据库|
| addGlobalContext | Dictionary | 否 | [添加自定义标签](#user-global-context ) |
