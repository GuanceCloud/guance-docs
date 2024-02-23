# 特殊字符转义查询
---

## 查看器

在查看器中部分字符具有特殊意义，例如 `空格` 用于分隔多个单词，所以若检索的内容中包含以下字符需要做特殊处理：`空格` `:` `"` `“` `\` `(` `)` `[` `]` `{` `}` `!`

因为搜索和筛选所用的查询语法不同，特殊字符的处理上也有不同
- 搜索：使用的是 [query_string()](../../dql/funcs.md#query_string) 查询语法
- 筛选：支持多种 [运算符](explorer-search.md#operator) ，包括 `=` `!=` `wildcard` 等

**查看器针对特殊字符有下面两种处理方式**

### 方式一：将文本变成短语

???+ warning 

    - 在文本两侧加`"`双引号，可以将文本变为短语
    - 此写法下双引号的内容会作为一个整体发起匹配搜索，通配符不会生效；  
    - 若文本中含有 `\` `"`，该方式检索不到，请使用 “方式二”查询

举例说明：检索的字段名 `cmdline`, 字段值 `nginx: worker process`

- 搜索

```
"nginx: worker process"   //检索成功，精准匹配单词
```

```
"nginx * process"   //检索失败，因为双引号中 * 不会被认为是通配符
```

- 筛选

```
cmdline:"nginx: worker process"   //检索成功，精准匹配单词
```

```
cmdline:"nginx: worker*"  //检索失败，因为双引号中 * 不会被认为是通配符
```
![](character-filter1.png)
![](character-search1.png)

### 方式二：对字符进行转义

???+ warning 
  
    - 只需要在特殊字符前加一个`\`反斜杠
    - 若检索的文本中本身有 `\` ，搜索和筛选对应的处理方式不同：搜索需要在字符前再加三个`\`反斜杠进行转义；筛选只需要加一个 `\` 反斜杠即可

举例说明：检索的字段名 `cmdline`, 字段值 `
E:\software_installer\vm\vmware-authd.exe` 

- 搜索

```
E\:\\\\software_installer\\\\vm\\\\vmware-authd.exe     //检索成功，精准匹配单词
```

```
E\:\\\\software_installer*exe     //检索成功，通配符模糊匹配
```

- 筛选

```
cmdline:E\:\\software_installer\\vm\\vmware-authd.exe    //检索成功，精准匹配单词
```

```
cmdline:E\:\\software_installer*exe    //检索成功，通配符模糊匹配
```
![](character-filter2.png)
![](character-search2.png)

## DQL 查询

在平台中通 DQL 查询数据时，需要对一些特殊字符做处理，涉及的功能有：图表查询、查询工具、指标分析、监控器等

## 筛选（wildcard）

由于 wildcard 语法中`\`反斜杠有特殊含义，故需要做转义处理，若检索文本中有`\` ，需要在前面再加 1 个`\`反斜杠进行转义查询

若使用其他运算符（= != 等）筛选，不需要做转义处理

## 搜索（query_string）

query_string 语法中`\`和`"`有特殊含义，故需要做转义处理

- `\` ：需要在前面再加 3个 反斜杠\ 实现转义
- `"` ：需要在前面再加 1 个反斜杠\ 实现转义
