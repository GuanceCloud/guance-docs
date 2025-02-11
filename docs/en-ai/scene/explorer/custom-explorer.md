# Quick Setup of Custom Explorer
---

The Explorer serves as a crucial tool for data observability, enabling us to quickly pinpoint issues through search and filtering methods. Guance supports the creation of **custom Explorers within specific scenarios** in addition to its existing Explorers.

Custom Explorers feature a unified layout, responsive configuration mode, and more scientific data association settings. You can experience the following functionalities within a custom Explorer:

- Multiple customizable chart display settings;
- Custom quick filter fields;
- Custom default columns for lists;
- Binding associated built-in views.

## Getting Started

1. Navigate to the **Scenario > Explorer** page and click **New Explorer** to enter the creation page.

**Note**: If you set up indexes under **Logs > Index**, you can select different log contents corresponding to various indexes in the custom Explorer.

![Explorer setup](../../img/1111.png)

> For more details, refer to [Log Indexing](../../logs/multi-index/index.md).

2. Configure charts:

In edit mode, you can add up to 3 statistical charts.

![](../img/2222.gif)

3. Configure quick filter fields:

Click the **Quick Filter** edit button to add fields and aliases.

![](../img/3333.gif)

4. Configure data list display fields:

Click the **List** edit button to update the default display fields and aliases.

![](../img/4444.gif)

5. After creation, view your new Explorer in the Explorer list.

In non-edit mode, hover over **Data Range** to view all filter conditions.

![Data range](../../img/range.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Customize Your Viewing Needs with Custom Log Explorers</font>](./index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How to Bind Built-in Views</font>](../built-in-view/bind-view.md)

</div>