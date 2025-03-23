# Bind Built-in Views
---


That is, create a binding relationship between built-in views (user views) and Explorers. Associate built-in views with tracing services, applications, log sources, projects, or other custom fields. Explorers that match field values can view the bound views in the side-sliding details page.


## Start Binding {#bind}

1. Go to the **Use Cases > Built-in Views > User Views > Binding** page;
2. Define the view name;
3. Customize the ID;
4. View default associated fields. You can choose to retain or delete fields, and you can also add new `key:value` fields;
5. Click confirm.

<img src="../../img/user_view_path.png" width="60%" >

After completing the configuration of the binding relationship, you can go to the Explorer's side-sliding details page that matches the binding field value to view this built-in view.


**Note**: To ensure data consistency, when creating a binding relationship between user views and Explorers, you need to **add at least one field under the specified object classification as the binding relationship for this built-in view**, and the system will automatically synchronize the built-in view based on this binding relationship.


## Field Description

When binding built-in views, in addition to the following fixed fields, it also supports users to input existing fields (`key`) and field values (`value`) to generate binding relationships.

| Field Name | Data Scope |
| --- | --- |
| `service` | The `service` value in Tracing data of the current workspace | 
| `app_id` | The `app_id` value in View data of the current workspace | 
| `source` | The `source` value in Logging data of the current workspace | 
| `project` | The `project` value in Object data of the current workspace |
| `label` | The `label` value in Object data of the current workspace | 

???+ abstract "Binding Field Display Logic"

    Matching pattern: The `value` of the binding field supports the following patterns:

    - Exact match         
    - Fuzzy match   
    
    Display order: Binding fields are displayed in the following order: `service` > `app_id` > `source` > `project` > `label`. No special processing is done for the order of identical fields.
    
    Time range: In the Explorer details page, the bound built-in view defaults to displaying data from "the last 15 minutes" and marks the time of the current data record.

## Unbind

If you need to delete the bound built-in view already present in the Explorer details:

1. Go back to the built-in view page and find the view;
2. Click **Bind**;
3. Clear the field content;
4. Click **Confirm**.