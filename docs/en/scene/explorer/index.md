# Explorer
---

When processing log data, quickly locating and analyzing key information is crucial. Custom Explorers allow you to create personalized log viewing tools based on your needs.

- Multiple custom chart display settings;
- Custom quick filter fields;
- Custom default columns for list display;
- Bind to associated built-in views.

## Create

You can create an Explorer in three ways.

:material-numeric-1-circle: Directly create a [blank Explorer](#blank);

:material-numeric-2-circle: Import a [custom template](#custom);

:material-numeric-3-circle: Select an Explorer from the [built-in template library](#view).

### Blank Explorer

![](../img/blank_explorer.png)

1. Define the name of the current Explorer;
2. Enter a description for this Explorer as needed;
3. Select [labels](../../management/global-label.md) for easier grouping management later;
4. Select the data type for the current Explorer, including logs, application performance, user access, security checks, Profile;
5. Select the [visibility scope](#range) for the current Explorer;
6. Click confirm to successfully create it.

#### Visibility Scope {#range}

The visibility scope of the Explorer includes:

- Public: Open to all members within the workspace;  
- Private: Visible only to the creator.

???+ warning "Note"

    **Non-public Explorers** shared via link are invisible to non-creators.

### Custom Template {#custom}

![](../img/custom_explorer.png)

1. Define the name of the current Explorer;
2. Enter a description for this Explorer as needed;
3. Upload a custom JSON file;
4. Select [labels](../../management/global-label.md) for easier grouping management later;
5. Select the [visibility scope](#range) for the current Explorer;
6. Click confirm to successfully create it.

### Built-in Template Library {#view}

![](../img/view_explorer.png)

1. The Explorer name defaults to the name of the currently selected view and can be changed as needed;
2. Enter a description for this Explorer as needed;
3. Select [labels](../management/global-label.md) for easier grouping management later;
4. Select the [visibility scope](#range) for the current Explorer;
5. Click confirm to successfully create it.