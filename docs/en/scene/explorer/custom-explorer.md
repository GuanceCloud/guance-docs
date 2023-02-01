# Quickly build a custom log viewer
---

The log viewer is an important tool for log observation, supporting us to quickly locate the problem by searching and filtering. The "Guance" in the original log observation viewer based on the new custom log viewer support at the scene.

The custom viewer uses a new unified layout, responsive configuration mode and more scientific data association configuration, the following will take the Redis log custom viewer as an example, you can experience the following operations in the custom viewer.

- Multiple custom chart display settings
- Customizable shortcut filter fields
- Customize the list to display columns by default
- Bind the built-in view for viewing associations

## Start creating a custom viewer for the logs
### Create a new Redis log viewer
Go to 「Scene」 - 「Viewer」 page, click 「New Viewer」 to create a new custom viewer. As shown in the following figure.

Note: If after setting the index in 「Log」 - 「Index」, it supports to select different indexes corresponding to the log content in the custom viewer. For more details, please refer to the document [Log Index](../../logs/multi-index.md) 。

![](../img/1111.gif)

### Configuring Redis Statistics Class Charts
In edit mode, you can add up to 3 statistical charts. As shown in the figure below.

![](../img/2222.gif)

### Configure shortcut filter fields
Click the [Quick Filter] edit button to add fields and aliases. As shown in the figure below.

![](../img/3333.gif)

### Configuration list default display fields
Click the [List] Edit button to edit and update the default display fields and aliases. As shown in the figure below.

![](../img/4444.gif)

### Binding built-in view display
Go to [Administration] - [Built-in Views] - [System Views], search for "redis", and edit [Redis Monitor View] to add a binding relationship. As shown below.

![](../img/5555.gif)

### View the Redis Log Viewer

![](../img/6666.gif)

## More references

- [Scene - Viewer Help Documentation](index.md)
- [Binding built-in views](../../scene/built-in-view/bind-view.md)

