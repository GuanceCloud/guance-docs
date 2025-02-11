# Regular Expressions

Regular expressions are one of the effective means to achieve data security. In Guance, you can apply them to scenarios such as snapshot sharing and sensitive data masking. Guance not only provides a built-in regular expression template library but also supports creating custom regular expressions, which can be saved as rule sets for easy future use.

## Customization {#diy}

Go to **Management > Regular Expressions > Customization**, and click **Create New Regular Expression** on the right:

![](img/regrex.png)

Enter the current rule name and the regular expression, then click Preview to see the masking effect in advance. The original text will be masked with `***` based on the matching results from the left-side regular expression.

<img src="../img/regrex-3.png" width="60%" >

After entering the name and pressing Enter, the rule is created. Click Confirm to successfully create the current rule.

On the customization page, you can view all custom regular expressions. You can perform the following operations on the list:

1. Filter: Filter rules based on the rule set;
2. Search: Quickly locate rules by searching for the rule name;
3. Clone: Quickly copy the current rule by clicking;
4. Edit: Re-edit the current rule by clicking;
5. Delete: Directly delete or batch delete rules.

![](img/regrex-1.png)


## Template Library

In **Management > Regular Expressions > Template Library**, you can see all the built-in regular expression templates provided by the system. Click the Clone button under Actions on the right to use them.

You can perform the following operations on the list:

1. Filter: Filter rules based on the rule set;
2. Search: Quickly locate rules by searching for the rule name;

![](img/regrex-2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Click to view all rules in the template library</font>](./regex-template.md)


</div>