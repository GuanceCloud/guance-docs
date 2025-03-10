# How to Write a Text Document
---

Text documents are edited using Markdown, a lightweight markup language with simple syntax that is easy to read and write, used for creating text documents. This article will introduce how to write documents using Markdown.

## 1. Headings

Markdown supports six levels of headings. The format is as follows:

```
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
```

Effect as shown below:

![](img/1.markdown_1.1.png)

## 2. Text Formatting

Markdown supports formatting text in italics, bold, strikethrough, underline, and these effects can be combined. The format is as follows:

```
*Italic text*
**Bold text**
***Bold and italic text***
~~Strikethrough text~~ 
~~**Bold and strikethrough text**~~ 
~~*Italic and strikethrough text*~~ 
<u>Underlined text</u>
```

Effect as shown below:

![](img/1.markdown_2.png)

## 3. Horizontal Rules

Markdown supports adding horizontal rules using three consecutive `*` or `-`. The format is as follows:

```
***
---
```

Effect as shown below:

![](img/1.markdown_3.png)

## 4. Code Blocks

Markdown supports displaying code using backticks ``` (the key above the Tab key). The format is as follows:

C
```
// C code
```

Java
```
// Java code
```

Python
```
# Python code
```

Effect as shown below:

![](img/1.markdown_4.png)

## 5. Tables

Markdown supports creating tables using pipes `|` to separate cells and dashes `-` to separate headers from other rows. The format is as follows:

```
Default | Left-aligned | Center-aligned | Right-aligned |
| --- | :--- | :---: | ---: |
| Table content | Table content | Table content | Table content |
| Table content | Table content | Table content | Table content |
```

Effect as shown below:

![](img/1.markdown_5.1.png)

## 6. Hyperlinks

Markdown supports creating hyperlinks using square brackets `[]` and parentheses `()`. The link description is placed inside the square brackets, and the URL is placed inside the parentheses. The format is as follows:

```
[<<< custom_key.brand_name >>>](https://www.guance.com)
```

Effect as shown below:

[<<< custom_key.brand_name >>>](https://www.guance.com)

Markdown also supports directly displaying URLs using angle brackets `<>`. The format is as follows:

```
<https://www.guance.com>
```

Effect as shown below:

[https://www.guance.com](https://www.guance.com)

## 7. Images

Markdown supports inserting web images into text documents. The format is as follows:

```
![avatar](https://static.<<< custom_key.brand_main_domain >>>/dataflux-icon/official/community-code.png)
```

Effect as shown below:

![](img/1.picture_1.png)