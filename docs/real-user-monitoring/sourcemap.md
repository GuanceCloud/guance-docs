# Sourcemap上传
---

## 概述

应用在生产环境中发布的时候，为了防止代码泄露等安全问题，一般打包过程中会针对文件做转换、压缩等操作。以上举措在保障代码安全的同时也致使收集到的错误堆栈信息是经过混淆后的，无法直接定位问题，为后续 Bug 排查带来了不便。

"观测云" 为 Web 应用程序提供 sourcemap 功能，支持还原混淆后的代码，方便错误排查时定位源码，帮助用户更快解决问题。

**注意**：当前仅支持 Web 应用产生的 JS 错误还原。

## 步骤概述

开始Sourcemap需要您将应用对应的map文件上传到 “观测云”，“观测云” 会根据拿到的map文件自动完成映射还原。通过访问“观测云”「用户访问监测」，您可以及时发现错误堆栈信息（真实的代码发生错误的地方），快速定位到对应代码，排障。具体操作步骤如下：

1. 配置 Javascript bundler：用来映射转换、压缩后的 js 代码
2. sourcemap 打包压缩：得到 zip 格式文件
3. 上传：zip 文件上传至 datakit
4. 在观测云查看：可查看解析后的 error 定位

## 具体操作介绍

### 步骤1 配置 Javascript bundler

以使用 webpackJS 举例，使用内置插件 `SourceMapDevToolPlugin` 生成源映射，在下面查看如何在 `webpack.config.js` 文件中配置它：

```javascript
// ...
const webpack = require('webpack');
module.exports = {
  mode: 'production',
  devtool: false,
  plugins: [
    new webpack.SourceMapDevToolPlugin({
      noSources: false,
      filename: '[file].map'
    }),
    // ...
  ],
  optimization: {
    minimize: true,
    // ...
  },
  // ...
};

```

注意：如果用的是 TypeScript ，在配置 `tsconfig.json` 时设置 `compilerOptions.sourceMap` 为 `true`。

### **步骤2 压缩打包**


将 sourcemap 对应路径的文件夹压缩打包成 zip，命名格式为` <app_id>-<env>-<version>.zip` ，并保证该压缩包解压后的文件路径与 `error_stack` 中 URL 的路径一致。

```shell
zip -q -r <app_id>--.zip sourcemap文件目录
```

假设如下 error_stack：

```shell
ReferenceError
at a.hideDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1037
at a.showDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:986
at <anonymous> @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1174
```

需要转换的路径是 `/static/js/app.7fb548e3d065d1f48f74.js`，与其对应的 sourcemap 路径为 `/static/js/app.7fb548e3d065d1f48f74.js.map`，那么对应压缩包解压后的目录结构如下：

```shell
static/js/app.7fb548e3d065d1f48f74.js.map
```

转换后的 error_stack_source :

```shell
at a.hideDetail @ webpack:///src/components/header/header.vue:94:0
at a.showDetail @ webpack:///src/components/header/header.vue:91:0
at <anonymous> @ webpack:///src/components/header/header.vue:101:0
```

变量说明：

- `＜app_id＞`:对应 RUM 的 applicationId
- `＜dea_address＞`: DCA 服务的地址，如 http://localhost:9531
- `＜sourcemap_path＞`:待上传的 sourcemap 压缩包文件路径
- `＜env＞`：对应 RUM 的 env
- `＜version＞`：对应 RUM 的 version

### **步骤3 上传及删除**

可以手动上传至 datakit 相关目录， `<Datakit 安装目录>/data/rum/web`，这样就可以对上报的 error 数据自动进行转换，并追加 error_stack_source 字段至该指标集中。也可以使用 http 接口上传和删除该文件，前提是开启 DCA 服务。
上传：

```shell
curl -X POST '<dca_address>/v1/rum/sourcemap?app_id=<app_id>&env=<env>&version=<version>' -F "file=@<sourcemap_path>" -H "Content-Type: multipart/form-data"
```

删除：

```shell
curl -X DELETE '<dca_address>/v1/rum/sourcemap?app_id=<app_id>&env=<env>&version=<version>'
```

### **步骤4 在观测云查看**

通过访问“观测云”「用户访问监测」，在页面性能数据（view) 和会话数据（session） 详情页面，点击查看错误详情，您可以及时发现错误堆栈信息（真实的代码发生错误的地方），快速定位到对应代码。

![](img/image.png)

## 注意事项

- 该转换过程，只针对 error 数据。
- 当前只支持 js 的 sourcemap 转换。
- sourcemap 文件名称需要与原文件保持一致，如果未找到对应的 sourcemap 文件，将不进行转换。
- 通过接口上传的 sourcemap 压缩包，不需要重启 DataKit 即可生效，但如果是手动上传，需要重启 DataKit ，方可生效。

## iOS & Android 的 Sourcemap 上传

- [iOS sourcemap 上传](../datakit/rum.md#sourcemap)
- [Android sourcemap 上传](../datakit/rum.md#sourcemap)

