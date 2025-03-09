# Template Management
---

The template management page supports viewing, searching, and importing all built-in template items of <<< custom_key.brand_name >>>.

![](img/18.deployment_2.png)

## Related Operations

1. You can filter templates by category or language; in the search box, you can directly enter keywords to search and locate;
2. Click batch operations to delete selected templates in bulk; you can also directly click the delete button on the right side of the template for operation;

![](img/deployment-1.png)

### Import Templates

The **Template Management** feature is divided into two versions: the version used by Deployment Plan users before updating [1.89.169](./changelog.md#626) and the version after updating. Depending on different versions, there are slight differences when performing import actions for different template types.

Currently, both versions support importing the following categories of templates: **built-in views, detection libraries, custom explorers, Pipeline**.

<img src="../img/deployment-2.png" width="70%" >

#### Before Version Update

- When selecting different template types, you can download templates from the import configuration page > classification drop-down list on the right;
- For detection libraries and Pipeline, after exporting templates, you need to edit the JSON file according to the official template specifications before use.

???- warning "Editing Example"

    :material-numeric-1-circle-outline: Detection Library:

    <img src="../img/detection-template.png" width="60%" >

    1. `checkers`: Replace with the exported monitoring template;
    2. `title`: Required; detection library name;
    3. `summary`: Optional; detection library description;
    4. `iconSet`: Optional; detection library logo link, if not configured, it will display the default official logo;
    5. `thumbnail`: Must be retained but does not require configuration; removing it will prevent import.


    :material-numeric-2-circle-outline: Pipeline (only supports log Pipeline):

    <img src="../img/pipeline-template.png" width="60%" >

    1. `pipeline` name; format: xxxx.p;
    2. `pipeline`: Required; parsing rules (must be Base64 encoded text);
    3. `examples`: Optional; sample data, supports multiple configurations (must be Base64 encoded text).

#### After Version Update

All four types of templates can be exported from the front-end console and imported from the management backend.

**Note**: Multiple files can be uploaded at once.

:material-numeric-1-circle-outline: Built-in Views: Exportable from the console > dashboard/user view creation.

:material-numeric-2-circle-outline: Custom Explorers: Exportable from the console > scenes > explorer creation.

:material-numeric-3-circle-outline: Detection Libraries: <<< custom_key.brand_name >>>'s [detection libraries](../monitoring/monitor/template.md) contain various monitoring rule templates. Supports exporting from the monitor list [options].

You can directly import one or more monitoring templates, where the detection library names cannot be duplicated, but no restrictions apply within the monitors.

:material-numeric-4-circle-outline: Pipeline: Supports multiple types, including logs/metrics/user access, etc.

During import, Pipeline names of the same type cannot be duplicated. After successful import, you can view the Pipeline type in the template list description. If the imported Pipeline template contains test sample data, it will be displayed in the `testData` section of the official template details.

???- warning "Export Example"

    <img src="../img/pipeline-template-1.png" width="60%" >

    1. `category`: Data type; supports non-log templates;
    2. `name`: Pipeline name;
    3. `content`: Pipeline script content;
    4. `testData`: Optional; test samples.

After a successful import, the list description will automatically recognize and fill in the Pipeline type, distinguishing between Chinese and English.

![](img/deployment-3.png)