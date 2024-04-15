# Build a Custom Log Explorer
---

Log explorer is an important tool for log observation, supporting us to quickly locate the problem by searching and filtering. Based on the original log observation explorer, Guance supports creating a custom log explorer at the scene.

The custom explorer applies a new unified layout, responsive configuration mode and more scientific data association configuration. The following will *take the Redis log custom explorer as an example*, in which you can experience the following operations:

- Multiple custom chart display settings
- Customizable shortcut filter fields
- Customize the list to display columns by default
- Bind the inner dashboard for viewing associations

## Start Creating

### Create a new Redis log explorer

Go to **Scene > Explorer** page, click **New Explorer** to create a new custom explorer. As shown in the following figure.

Note: If after setting the index in **Log > Index**, it supports to select different indexes corresponding to the log content in the custom explorer. For more details, please refer to the document [log index](../../logs/multi-index.md).

![](../img/1111.gif)

### Configure Redis statistics charts
In edit mode, you can add up to 3 statistical charts. As shown in the figure below.

![](../img/2222.gif)

### Configure shortcut filter fields
Click the **Quick Filter** edit button to add fields and aliases. As shown in the figure below.

![](../img/3333.gif)

### Configure list default display fields
Click the **List** Edit button to edit and update the default display fields and aliases. As shown in the figure below.

![](../img/4444.gif)

### Bind inner dashboard display
Go to **Administration > Inner dashboards > System Views**, search for "redis", and edit **Redis Monitor View** to add a binding relationship. As shown below.

![](../img/5555.gif)

### View Redis log explorer

![](../img/6666.gif)

## More Reading

- [Scene > Explorer help documentation](index.md)
- [Bind inner dashboard](../../scene/built-in-view/bind-view.md)

