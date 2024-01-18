# SourceMap
---

## 对 SourceMap 的需求

过去，我们只使用 HTML、CSS 和 JavaScript 构建 Web 应用，并将相同的文件部署到网络中。

由于现在我们正在构建更复杂的 Web 应用，您的开发工作流可能会涉及使用各种工具。例如:

- 模板语言和 HTML 预处理器：[Pug](https://pugjs.org/)、[Nunjucks](https://mozilla.github.io/nunjucks/)、[Markdown](https://daringFreball.net/projects/markdown/)。

- CSS 预处理器：[SCSS](https://sass-lang.com/)、[LESS](https://lesscss.org/)、[PostCSS](https://postcss.org/)。

- JavaScript 框架：Angular、React、Vue、Svelte。

- JavaScript 元框架：[Next.js](https://nextjs.org/)、[Nuxt](https://nuxt.com/)、[Astro](https://astro.build/)。

- 高级编程语言：[TypeScript](https://www.typescriptlang.org/)、[Dart](https://dart.dev/tools/dart2js)、
[CoffeeScript](https://coffeescript.org/)。

- 等等。


![](../img/sourcemap_05.png)

这些工具需要一个构建流程，以将您的代码转译为浏览器可以理解的标准 HTML、JavaScript 和 CSS。此外，为了优化性能，通常的做法是压缩(例如，使用 [Terser](https://github.com/terser/terser) 缩减和破坏 JavaScript)并合并这些文件，从而缩减其大小并提高网⻚效率。

例如，使用构建工具，我们可以将以下 TypeScript 文件转译并压缩为一行 JavaScript。

``` shell
 /* A TypeScript demo: example.ts */
 document.querySelector('button')?.addEventListener('click', () => {
 const num: number = Math.floor(Math.random() * 101);
 const greet: string = 'Hello';
 (document.querySelector('p') as HTMLParagraphElement).innerText = `${greet}, you
 console.log(num);
 });
```
压缩版本如下所示:

``` shell
 /* A compressed JavaScript version of the TypeScript demo: example.min.js  */
 document.querySelector("button")?.addEventListener("click",(()=>{const e=Math.floor
```
不过，这项优化会增加调试难度。如果压缩代码将所有内容放在一行，并且变量名称较短，则很难确定问题的根源。这正是源映射的用武之地 - 源映射会将您编译的代码映射回原始代码。

## 生成 SourceMap

源映射是名称以 .map 结尾的文件(例如 example.min.js.map 和 styles.css.map)。大多数构 建工具均可生成源映射，例如 [Vite](https://vitejs.dev/)、[webpack](https://webpack.js.org/)、[Rollup](https://rollupjs.org/)、[Parcel](https://parceljs.org/)、[esbuild](https://esbuild.github.io/) 等。 一些工具默认包含源映射，而其他工具可能需要额外配置才能生成。

``` shell
 /* Example configuration: vite.config.js */

 /* https://vitejs.dev/config/ */

 export default defineConfig({
 build: {
 sourcemap: true, // enable production source maps
 },
 css: {
 devSourcemap: true // enable CSS source maps during development
 }
 })
```

## 了解 SourceMap

这些源映射文件包含有关编译后代码如何映射到原始代码的重要信息，使开发者可以轻松调试。下面是一个源代码映射的示例：

``` shell
 {
 "mappings": "AAAAA,SAASC,cAAc,WAAWC, ...",
 "sources": ["src/script.ts"],
 "sourcesContent": ["document.querySelector('button')..."],
 "names": ["document","querySelector", ...],
 "version": 3,
 "file": "example.min.js.map"
 }
```

源映射的最关键要素是 `mappings` 字段。它使用 [VLQ base 64 编码](https://developer.chrome.com/blog/sourcemaps/?hl=zh-cn#base64-vlq-and-keeping-the-source-map-small)字符串，将已编译文件中的行和位置映射到对应的原始文件。您可以使用 [source-map-visualization](https://sokra.github.io/source-map-visualization/) 和[来源映射可视化](https://evanw.github.io/source-map-visualization/)等来源映射可视化工具直观呈现此映射，验证文件可用性。

例如：由可视化工具 **source-map-visualization** 生成的代码示例的可视化图表。

![](../img/sourcemap_03.png)

左侧的**已生成**列显示的是压缩内容，**原始**列显示的是原始来源。

可视化工具会对 **original** 列中的每一行进行颜色编码，以及 **generated** 列中对应的代码。 **mappings** 部分显示了已解码的代码映射。例如，条目 65-> 2:2表示:

- **生成的**代码：单词 const 在压缩内容中的位置 65 处开始。

- **原始**代码：字词 const 从原始内容中的第 2 行和第 2 列开始。

![](../img/sourcemap_04.png)

这样，开发者就可以快速确定经过缩减的代码与原始代码之间的关系，从而使调试过程更加顺畅。

浏览器开发者工具会应用这些源代码映射，以帮助您直接在浏览器中更快地查明调试问题。
