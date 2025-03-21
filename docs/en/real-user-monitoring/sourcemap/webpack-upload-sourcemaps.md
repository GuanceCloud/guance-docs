# Uploading SourceMap During Project Build

<<< custom_key.brand_name >>> currently provides a `webpack` plugin that can easily upload the corresponding directory's SourceMap files during the build process of Web projects, solving the cumbersome manual upload process.

**Note**: Currently supports uploading for Web applications.

## Preparation

1. [Obtain](../../open-api/index.md) the `OpenApi` domain address for the corresponding site;
2. Obtain the required `API KEY` for the `OpenApi` from <<< custom_key.brand_name >>> [here](../../open-api/signature-certification.md);
3. Obtain the `applicationId`, `env`, and `version` information for the Web application on the <<< custom_key.brand_name >>> platform. If there is no application, you need to [create a new application](../web/app-access.md);
4. Preparation complete.

## Webpack

Install [@cloudcare/webpack-plugin](https://www.npmjs.com/package/@cloudcare/webpack-plugin)

```js
 npm install @cloudcare/webpack-plugin --D
```

Modify the `plugins` option in the `webpack.config.js` file

```js
// ....
const { GuanceSourceMapUploadWebpackPlugin } = require('@cloudcare/webpack-plugin')
module.exports = ({ mode }) => ({
  //.....
  devtool: 'hidden-source-map',
  plugins: [
    //.....
    new GuanceSourceMapUploadWebpackPlugin({
      applicationId: 'xxxxx', // <<< custom_key.brand_name >>> application appid
      apiKey: 'xxxxxxxx', // open apikey
      server: 'https://console.guance-xxx.cn',
      filepaths: ['dist/'], // Directories or files to search
      logLevel: 'verbose', // Log level, optional
      root: 'dist/', // Directory for calculating relative paths, optional
      env: 'production', // <<< custom_key.brand_name >>> application env, optional
      version: '1.0.0', // <<< custom_key.brand_name >>> application version, optional
    }),
  ],
})
```

### Configuration Explanation for SourceMap WebpackPlugin

```typescript
interface Options {
  /**
   *
   * Files/directories to search for sourcemaps.
   * All files that match the list of "extensions" configuration but do not match the "ignore" configuration will be searched
   * for sourcemap JSON or `//#sourceMappingURL=` comments to find generated files + source map pairs, which will then be uploaded.
   */
  filepaths: Array<string> | string

  /**
   * OpenApi Key generated by the <<< custom_key.brand_name >>> platform, see (<<< homepage >>>/management/api-key/open-api/#_1) for generation method
   */
  apiKey: string

  /**
   * <<< custom_key.brand_name >>> OpenApi service
   */
  server: string
  /**
   * ApplicationId (required) for the <<< custom_key.brand_name >>> RUM application
   */
  applicationId: string
  /**
   * Version (optional) for the <<< custom_key.brand_name >>> RUM application
   */
  version?: string
  /**
   * Env (optional) for the <<< custom_key.brand_name >>> RUM application
   */
  env?: string

  /**
   * Search all matching files without uploading them, useful for debugging
   */
  dryRun?: boolean

  /**
   * Delete all found source map files after upload.
   */
  deleteAfterUpload?: boolean
  /**
   * Attempt to match source maps by filename on local disk if sourceMappingURL cannot match with the generated file
   */
  matchSourcemapsByFilename?: boolean

  /**
   * List of file extensions to search within directories
   * Default [".js", ".map"].
   */
  extensions?: Array<string>

  /**
   * List of files to ignore
   */
  ignore?: Array<string>

  /**
   * Directory for calculating relative paths. The relative path of uploaded sourcemaps should be included in the error path,
   * so this parameter controls the relative directory of uploads.
   * Default is the relative path from the execution directory to the search directory `path.relative(process.cwd(), filepath)`
   */
  root?: string
  /**
   * Debugging log level
   */
  logLevel?: 'quiet' | 'normal' | 'verbose'
}
```

### Visibility of SourceMap in Production Environment

In production environments, for security reasons, we typically do not retain SourceMap files. These files allow developers to map minified or compiled code back to the original source code, but if exposed publicly, they may reveal the internal logic of the application, increasing security risks.

To safely handle SourceMaps, you can enable the `deleteAfterUpload: true` option when configuring `GuanceSourceMapUploadWebpackPlugin`. This way, once the SourceMap is uploaded to the server, it will be immediately deleted from the local file system, ensuring that it does not remain in the production environment.

Additionally, by setting Webpack’s `devtool` to `"hidden-source-map"`, you can generate SourceMaps without including any references to them in the JavaScript files. This prevents browsers from attempting to download and view the source code.

If you enable `"hidden-source-map"`, you should also set `matchSourcemapsByFilename: true` in the `GuanceSourceMapUploadWebpackPlugin` plugin. This configuration ensures that the plugin can identify and upload the corresponding SourceMap files based on the names of the JavaScript files, even if they are not explicitly referenced in the generated code.

Through these measures, you can maintain the convenience of debugging your application while effectively protecting the security of your source code.

```js
 const { GuanceSourceMapUploadWebpackPlugin } = require('@cloudcare/webpack-plugin')
 = require('@cloudcare/webpack-plugin')

module.exports = {
  // Ensure that Webpack has been configured to output sourcemaps,
  // but without the `sourceMappingURL` references in build artifacts.
  devtool: 'hidden-source-map',
  // ...
  plugins: [
    // Enable our plugin to upload the sourcemaps once the build has completed.
    // This assumes NODE_ENV is how you distinguish production builds. If that
    // is not the case for you, you will have to tweak this logic.
    process.env.NODE_ENV === 'production'
      ? [
          new GuanceSourceMapUploadWebpackPlugin({
            ...
            deleteAfterUpload: true,
            matchSourcemapsByFilename: true,
          }),
        ]
      : [],
  ],
}
```

### How to DEBUG

If SourceMaps are not found during the run, you can set the environment variable `DEBUG=guance:sourcemap-upload` or configure `logLevel: verbose` when running the build command to view detailed runtime logs.

### Precautions

### Node Version `> 10.13`

### Considerations for `filepaths` and `root` Configuration:

1. In the Guance console, there is an error line `at SVGGElement.<anonymous> @ http://localhost:8000/js/chunk-vendors.732b3b98.js:1:93427`

2. The relative path of the file causing the error is `js/chunk-vendors.732b3b98.js`

3. If the static directory for js files on the server is `dist/js/*.js` `dist/js/*.js.map`

4. Plugin configuration `filepaths: ['dist']`

5. Without configuring `root`, the default value is `dist/`, so the uploaded sourcemap file path to the Guance server would be `dist/js/**.js.map`

6. In this case, the **uploaded file directory path** would not match the **error path**, so you should add the configuration `root:'/'` or `root: ''` to ensure the upload path is `js/**.js.map`.