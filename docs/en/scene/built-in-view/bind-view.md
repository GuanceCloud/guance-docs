# Bind Built-in Views
---


This involves creating a binding relationship between built-in views (user views) and Explorers. By associating built-in views with tracing services, applications, log sources, projects, or other custom fields, you can view the bound views in the side-sliding details page for matching field values.


## Start Binding {#bind}

1. Go to the **Use Cases > Built-in Views > User Views > Bind** page;
2. Define the view name;
3. Customize the identifier ID;
4. Review the default associated fields. You can choose to keep or delete fields, and also add new `key:value` fields;
5. Confirm.

<img src="../../img/user_view_path.png" width="60%" >

After configuring the binding relationship, you can go to the Explorer's side-sliding details page that matches the bound field values to view this built-in view.


???+ warning "Note"

    To ensure data consistency, when creating a binding relationship between user views and Explorers, you must **add at least one field from the specified object class as the binding relationship for this built-in view**, and the system will automatically synchronize the built-in view based on this binding relationship.


## Field Description

When binding built-in views, in addition to the following fixed fields, it also supports user-defined input of existing fields (`key`) and field values (`value`) to generate binding relationships.

| Field Name | Data Scope |
| --- | --- |
| `service` | The `service` value in the Tracing data of the current workspace | 
| `app_id` | The `app_id` value in the View data of the current workspace | 
| `source` | The `source` value in the Logging data of the current workspace | 
| `project` | The `project` value in the Object data of the current workspace |
| `label` | The `label` value in the Object data of the current workspace | 

???+ abstract "Binding Field Display Logic"

    Matching Pattern: The `value` of the binding field supports the following patterns:

    - Exact match         
    - Fuzzy match   
    
    Display Order: Binding fields are displayed in the following order: `service` > `app_id` > `source` > `project` > `label`. No special processing is done for the order of identical fields.
    
    Time Range: In the Explorer details page, the bound built-in view defaults to displaying data from "the last 15 minutes" and labels the time of the current data record.

## Unbind

To delete a built-in view already bound in the Explorer details:

1. Go back to the built-in view page and locate the view;
2. Click **Bind**;
3. Clear the field content;
4. Confirm.