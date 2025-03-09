# Regular Expressions

Regular expressions are one of the effective means to achieve data security. In <<< custom_key.brand_name >>>, you can apply them to scenarios such as snapshot sharing and sensitive data masking. <<< custom_key.brand_name >>> not only provides a built-in regular expression template library but also supports custom creation of regular expressions, which can be saved as rule libraries for easy future use.

## Customization {#diy}

Navigate to **Manage > Regular Expressions > Custom**, and click **Create Regular Expression** on the right side:

![](img/regrex.png)

Enter the current rule name and the regular expression, then click Preview to view the masking effect in advance. The original text will be masked with `***` based on the matching results from the regular expression on the left.

<img src="../img/regrex-3.png" width="60%" >

After entering the name and pressing Enter, a rule is created; clicking Confirm will finalize the creation of the current rule.

On the customization page, you can view all custom regular expressions. You can perform the following operations on the list:

1. Filter: Filter rules based on the rule library;
2. Search: Quickly search and locate rules by name;
3. Clone: Click to quickly duplicate the current rule;
4. Edit: Click to edit the current rule again;
5. Delete: Supports direct deletion or batch deletion.

![](img/regrex-1.png)

## Template Library

In **Manage > Regular Expressions > Template Library**, you can see all the built-in regular expression templates provided by the system. Click the clone button under the operations on the right to use them.

You can perform the following operations on the list:

1. Filter: Filter rules based on the rule library;
2. Search: Quickly search and locate rules by name;

![](img/regrex-2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Click to view all rules in the template library</font>](./regex-template.md)


</div>