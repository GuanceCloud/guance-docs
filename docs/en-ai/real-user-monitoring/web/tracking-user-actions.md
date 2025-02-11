# Tracking User Actions

## Overview

Browser monitoring automatically detects user interactions and provides deeper insights into user behavior without requiring you to manually monitor every click in your application.

You can achieve the following goals:

- Understand the performance of key interactions (for example, clicking an action button)
- Quantify feature adoption
- Identify steps leading to a browser error

## Controlling Collection of Action Data

The `trackUserInteractions` initialization parameter collects user clicks within the application, which means that sensitive and private data contained in the page may be included to identify elements that users interact with.

## Tracking User Interactions

The RUM SDK automatically tracks clicks. A click operation is created if **all** of the following conditions are met:

- Activity is detected after a click. [Page activity status](../../security/page-performance.md#page-active)
- The click does not result in loading a new page; in such cases, the RUM SDK generates another RUM View event.
- The Action name can be obtained.

## Action Metrics

| Metric                            | Type       | Description                             |
| --------------------------------- | ---------- | --------------------------------------- |
| `action.duration`                 | number(ns) | The loading time of the action.         |
| `action.action_long_task_count`   | number     | Count of all long tasks collected for this action. |
| `action.action_resource_count`    | number     | Count of all resources collected for this action. |
| `action.action_error_count`       | number     | Count of all errors collected for this action. |

The RUM SDK calculates the action loading time by listening to page activity after each click. When the page is no longer active, the action is considered complete.

## Action Attributes

| Attribute                   | Type   | Description                                                                                            |
| --------------------------- | ------ | ------------------------------------------------------------------------------------------------------ |
| `action.action_id`          | String | UUID of the user action.                                                                               |
| `action.action_type`        | String | Type of user action. For custom user actions, it is set to "custom".                                   |
| `action.action_target`      | String | Element that the user interacted with. Applies only to automatically collected actions.               |
| `action.action_name`        | String | A user-friendly name (e.g., "Click on #checkout"). For custom user actions, the operation name given in the API call. |

## Naming Actions

The RUM SDK uses various strategies to obtain the name of a click action. If you want more control, you can define the `data-guance-action-name` attribute on clickable elements (or any parent element).

For example:

```html
<a class="btn btn-default" href="#" role="button" data-guance-action-name="Test Button">Click Me!</a>
```

Using the `actionNameAttribute` initialization parameter, you can add a custom attribute to elements to specify the action name.

For example:

```html
<script>
   window.DATAFLUX_RUM.init({
     ...
     trackUserInteractions: true,
     actionNameAttribute: 'data-custom-name',
     ...
   })
</script>

<a class="btn btn-default" href="#" role="button" data-custom-name="Click Button">Click Me!</a>
```

When both attributes exist on an element, `data-guance-action-name` takes precedence.

## Custom Actions

To extend user Action data, use the `addAction` API to create custom Actions. [Refer to details](./custom-sdk/add-action.md)