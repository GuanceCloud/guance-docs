# 在项目构建过程中上传 SourceMap

观测云目前提供 `Vite` 插件，能够轻松的在 Web 项目构建的过程中，上传对应目录的 SourceMap 文件。解决在繁杂的手动上传过程。

**注意**：目前支持 Web 应用的上传。

## 准备工作

1. [获取](../../open-api/index.md)对应站点的 `OpenApi` 域名地址；
2. 在观测云[获取](../../open-api/signature-certification.md)对应的 `OpenApi` 所需的 `API KEY`；
3. 在观测云平台上获取 Web 应用的 `applicationId`、`env`、`version` 信息。如果没有应用，需[创建一个新应用](../web/app-access.md)；
4. 准备完毕。

## Vite

安装 [@cloudcare/vite-plugin-sourcemap](https://www.npmjs.com/package/@cloudcare/vite-plugin-sourcemap)

Using npm:

```bash
npm install @cloudcare/vite-plugin-sourcemap --save-dev
```

Using yarn:

```bash
yarn add @cloudcare/vite-plugin-sourcemap --dev
```

Using pnpm:

```bash
pnpm add @cloudcare/vite-plugin-sourcemap --save-dev
```

修改 `vite.config.js` 文件的 `plugins` 选项

```js
// vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { GuanceSourceMapUploadVitePlugin } from '@cloudcare/vite-plugin-sourcemap'
// https://vitejs.dev/config/
export default defineConfig({
  build: {
    sourcemap: true, // Source map generation must be turned on
  },
  plugins: [
    vue(),

    // Put the Sentry vite plugin after all other plugins
    GuanceSourceMapUploadVitePlugin({
      applicationId: 'xxxxx', //  观测云应用 appid
      apiKey: 'xxxxxxxx', // open apikey
      server: 'https://console.guance-xxx.cn',
      filepaths: ['dist/'], // 需要搜索的目录，可以是文件或者文件目录
      logLevel: 'verbose', // 日志打印级别
      //   root: 'dist/', // 需要上传的相对目录对应的跟目录
      env: 'production', // 观测云 应用的 env
      version: '1.0.0', // 观测云应用的 version
    }),
  ],
})
```

## Sourcemap Plugin Options

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
   * 上传后删除所有找到的源映射文件。
   */
  deleteAfterUpload?: boolean
  /**
   * 如果源映射无法通过其 sourceMappingURL 与生成的文件匹配，尝试通过本地磁盘上的文件名进行匹配
   */
  matchSourcemapsByFilename: ?boolean

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

## Sourcemap 在生产环境的是否可见

在生产环境中，出于安全考虑，我们通常不会保留 sourcemap 文件。这些文件允许开发者将压缩或编译后的代码映射回原始源代码，但若被公开，可能会暴露应用程序的内部逻辑，增加安全风险。

为了安全地处理 sourcemap，您可以在配置 GuanceSourceMapUploadVitePlugin 时启用 deleteAfterUpload: true 选项。这样，一旦 sourcemap 被上传到服务器，就会立即从本地文件系统中删除，确保它们不会在生产环境中遗留。

此外，通过设置 vite.config.ts 中的 `build.sourcemap` 为 "hidden"，您可以生成 sourcemap 而不在 JavaScript 文件中包含任何指向它们的引用。这可以防止浏览器尝试下载和查看源代码。

如果启用了 "hidden"，您还应该在 GuanceSourceMapUploadVitePlugin 插件中设置 matchSourcemapsByFilename: true。这个配置确保插件能够根据 JavaScript 文件的名称来识别并上传相应的 sourcemap 文件，即使它们在生成的代码中没有显式的引用。

通过这些措施，您可以在保持应用程序调试便利性的同时，有效保护源代码的安全。

```js
// vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { GuanceSourceMapUploadVitePlugin } from '@cloudcare/vite-plugin-sourcemap'
// https://vitejs.dev/config/
export default defineConfig({
  build: {
    sourcemap: 'hidden', // Source map generation must be turned on
  },
  plugins: [
    vue(),

    // Put the Sentry vite plugin after all other plugins
    GuanceSourceMapUploadVitePlugin({
      applicationId: 'xxxxx', //  观测云应用 appid
      apiKey: 'xxxxxxxx', // open apikey
      server: 'https://console.guance-xxx.cn',
      filepaths: ['dist/'], // 需要搜索的目录，可以是文件或者文件目录
      logLevel: 'verbose', // 日志打印级别
      //   root: 'dist/', // 需要上传的相对目录对应的跟目录
      env: 'production', // 观测云 应用的 env
      version: '1.0.0', // 观测云应用的 version
      deleteAfterUpload: true,
      matchSourcemapsByFilename: true,
    }),
  ],
})
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
