# How to Write a Text Document
---

Text documents are edited using Markdown, a lightweight markup language with simple syntax that is easy to read and write, used for writing text documents. This article will introduce how to write documents using Markdown.

## 1. Headings

Markdown supports up to six levels of headings. The format is as follows:

```
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
##### H5 Heading
###### H6 Heading
```

Effect as shown below:

![](img/1.markdown_1.1.png)

## 2. Text Formatting

Markdown supports bold, italics, strikethrough, and underline for text formatting, and these effects can be combined. The format is as follows:

```
*italic text*
**bold text**
***italic and bold***
~~strikethrough text~~ 
~~**bold strikethrough**~~ 
~~*italic strikethrough*~~ 
<u>underlined text</u>
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

Markdown supports tables by using pipes `|` to separate columns and dashes `-` to separate headers from other rows. The format is as follows:

```
Default | Left-aligned | Center-aligned | Right-aligned |
| --- | :--- | :---: | ---: |
| Table content | Table content | Table content | Table content |
| Table content | Table content | Table content | Table content |
```

Effect as shown below:

![](img/1.markdown_5.1.png)

## 6. Hyperlinks

Markdown supports hyperlinks using square brackets `[ ]` and parentheses `( )`. The `description` goes in the square brackets and the `URL` goes in the parentheses. The format is as follows:

```
[Guance](https://www.guance.com)
```

Effect as shown below:

[Guance](https://www.guance.com)

Markdown also supports directly displaying URLs using angle brackets `<>`. The format is as follows:

```
<https://www.guance.com>
```

Effect as shown below:

[https://www.guance.com](https://www.guance.com)

## 7. Images

Markdown supports inserting web images into text documents. The format is as follows:

```
![avatar](https://static.guance.com/dataflux-icon/official/community-code.png)
```

Effect as shown below:

![](img/1.picture_1.png)