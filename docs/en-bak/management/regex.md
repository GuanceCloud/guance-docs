# Regular Expressions

Regular expressions are one of the effective means to achieve data security. In Guance, you can apply regular expressions to use cases such as snapshot sharing and data desensitization. Guance not only provides a out-of-box library of regular expression templates, but also supports custom creation of new regular expressions, which can be saved as rule libraries for convenient future use.

## Custom {#diy}

Go to **Management > Regular Expressions > Custom**, and click **Create** on the right:

![](img/regrex.png)

Enter the current rule name and regular expression, and click Preview to preview the desensitization effect in advance. The original text will be desensitized with `***` according to the matching results of the left regular expression.

<img src="../img/regrex-3.png" width="60%" >

After entering the name, press Enter to create a rule; click Confirm to successfully create the current rule.

On the customization page, you can view all custom regular expressions. You can perform the following operations on the list:

1. Filter: Filter the rules based on the rule library.
2. Search: Quickly search and locate based on the rule name.
3. Clone: Quickly copy the current rule.
4. Edit: Edit the current rule again.
5. Delete: Support direct deletion or batch deletion.

![](img/regrex-1.png)

## Templates

In **Management > Regular Expressions > Templates**, you can see all the built-in regular expression templates in the system. Click the Clone button on the right to use them.

You can perform the following operations on the list:

1. Filter: Filter the rules based on the rule library.
2. Search: Quickly search and locate based on the rule name.

![](img/regrex-2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: View All Rules within the templates</font>](./regex-template.md)

</div>