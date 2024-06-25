# 在项目构建过程中上传 sourcemaps

我们目前提供了 webpack 插件，能够轻松的在 Web 项目构建的过程中，上传对应目录的 sourcemaps 文件。解决在繁杂的手动上传过程。
! （目前支持 web 应用的上传）

## 准备工作

1. 获取对应站点的 `OpenApi` 域名地址 ([如何获取](../../open-api/index.md))
2. 在观测云获取对应的 `OpenApi`所需的 `API KEY` （[获取方式](../../open-api/signature-certification.md)）。
3. 在观测云平台上获取 web 应用的`applicationId`、`env`、`version`信息,如果没有应用，可以[创建一个新应用](../web/app-access.md)
4. 准备完毕

## Webpack

安装 [@cloudcare/webpack-plugin](https://www.npmjs.com/package/@cloudcare/webpack-plugin)

```js
 npm install @cloudcare/webpack-plugin --D
```

修改 `webpack.config.js` 文件的 `plugins` 选项

```js
// ....
const { GuanceSourceMapUploadWebpackPlugin } = require('@cloudcare/webpack-plugin')
module.exports = ({ mode }) => ({
  //.....
  devtool: 'hidden-source-map',
  plugins: [
    //.....
    new GuanceSourceMapUploadWebpackPlugin({
      applicationId: 'xxxxx', //  观测云应用 appid
      apiKey: 'xxxxxxxx', // open apikey
      server: 'https://console.guance-xxx.cn',
      filepaths: ['dist/'], // 需要搜索的目录，可以是文件或者文件目录
      logLevel: 'verbose', // 日志打印级别，非必填
      root: 'dist/', // 设置相对路径应计算的目录，非必填
      env: 'production', // 观测云 应用的 env，非必填
      version: '1.0.0', // 观测云应用的 version，非必填
    }),
  ],
})
```

### Sourcemap WebpackPlugin 配置说明

```typescript
interface Options {
  /**
   *
   * 要搜索 sourcemap 的文件/目录。
   * 所有与 “extensions 配置” 列表匹配但与“ignore 配置”不匹配的文件都将被搜索
   * sourcemap JSON 或 `//#sourceMappingURL=` 注释，以便找到生成的文件 + 源映射对，然后源映射将被上传。
   */
  filepaths: Array<string> | string

  /**
   * 观测云平台生成的openApi Key，生成方式参考（https://docs.guance.com/management/api-key/open-api/#_1）
   */
  apiKey: string

  /**
   * 观测云平台 OpenAPi 服务
   */
  server: string
  /**
   * 观测云 RUM 应用对应的 applicationId(必填)
   */
  applicationId: string
  /**
   * 观测云 RUM 应用对应的 version(非必填)
   */
  version?: string
  /**
   * 观测云 RUM 应用对应的 env(非必填)
   */
  env?: string

  /**
   * 寻找所有符合条件的文件列表，但是不上传文件，可用于调试
   */
  dryRun?: boolean

  /**
   * 寻找目录下的文件后缀列表
   * 默认 [".js", ".map"].
   */
  extensions?: Array<string>

  /**
   * 需要忽略的文件列表
   */
  ignore?: Array<string>

  /**
   * 设置相对路径应计算的目录。sourcemaps 上传的相对路径应该要包含在 产生 error 的路径内，因此
   * 这个参数的意义在于控制上传的相对目录
   * 默认为 `process.cwd()`.
   */
  root?: string
  /**
   * 调试时候使用，产生的日志的等级
   */
  logLevel?: 'quiet' | 'normal' | 'verbose'
}
```

### 如何 DEBUG

如果在运行过程中，没有找到对应的 sourcemap，可以通过设置环境变量 `DEBUG=guance:sourcemap-upload` 或者配置 `logLevel: verbose` 运行 build 命令，查看具体运行日志

### 注意事项

### node 版本 `> 16`

### `filepaths` 与 `root` 配置注意事项：

1. 在观测云控制台有一个错误的其中一行 `at SVGGElement.<anonymous> @ http://localhost:8000/js/chunk-vendors.732b3b98.js:1:93427`

2. 引起错误产生的文件相对路径为 `js/chunk-vendors.732b3b98.js`

3. 如果 js 文件在服务端的静态目录为 `dist/js/*.js` `dist/js/*.js.map`

4. 插件配置 `filepaths: ['dist']`

5. 如果在不配置 `root` 的情况下，默认上传到观测云服务端的 sourcemap 文件路径 `dist/js/**.js.map`

6. 这种情况下，就会出现**上传文件的目录路径** 与**产生错误的路径**不匹配的情况，所以这时候应该添加配置 `root:'dist/'`, 保证上传的目录路径为 `js/**.js.map`。
