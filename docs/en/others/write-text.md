# How to Write a Text Document
---

Text documents are edited using Markdown. Markdown is a lightweight markup language with simple syntax that is easy to read and write, used for writing text documents. This article will introduce how to write documents using Markdown.

## 1. Headings

Supports up to six levels of headings, formatted as follows:

```
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
```

Effect as follows:

![](img/1.markdown_1.1.png)

## 2. Text

Supports making text bold, italicized, adding strikethroughs, underlines, and effects can be combined. Format as follows:

```
*Italicized text*
**Bold text**
***Bold and italicized text***
~~Strikethrough text~~ 
~~**Bold strikethrough text**~~ 
~~*Italicized strikethrough text*~~ 
<u>Underlined text</u>
```

Effect as follows:

![](img/1.markdown_2.png)

## 3. Horizontal Rules

Supports adding horizontal rules to the document using three consecutive `*` or `-`, format as follows:

```
***
---
```

Effect as follows:

![](img/1.markdown_3.png)

## 4. Code

Supports displaying code using backticks ``` (the key above the Tab key), format as follows:

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

Effect as follows:

![](img/1.markdown_4.png)

## 5. Tables

Supports separating different cells with `|` and separating headers from other rows with `-`. Format as follows:

```
Default Format | Left Aligned | Centered | Right Aligned |
| --- | :--- | :---: | ---: |
| Table Content | Table Content | Table Content | Table Content |
| Table Content | Table Content | Table Content | Table Content |
```

Effect as follows:

![](img/1.markdown_5.1.png)

## 6. Hyperlinks

Supports representing hyperlinks using square brackets and parentheses. The `description text` is placed in the square brackets, and the `URL` is placed in the parentheses, format as follows:

```
[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>)
```

Effect as follows:

[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>)

Supports directly displaying the link address using `<>` symbols, format as follows:

```
<https://<<< custom_key.brand_main_domain >>>>
```

Effect as follows:

[https://<<< custom_key.brand_main_domain >>>](https://<<< custom_key.brand_main_domain >>>)

## 7. Images

Supports inserting web images into text documents, format as follows:

```
![avatar](https://static.<<< custom_key.brand_main_domain >>>/dataflux-icon/official/community-code.png)
```

Effect as follows:

![](img/1.picture_1.png)