# Template Management
---

The Template Management page supports viewing, searching, and importing all built-in template projects from Guance.

![](img/18.deployment_2.png)


## Related Actions

1. You can filter templates directly by category or language; in the search box, you can enter keywords to locate specific templates;
2. Click on batch operations to delete selected templates in bulk; you can also click the delete button on the right side of a template for individual deletion;

![](img/deployment-1.png)


### Import Templates

The **Template Management** feature is available in two versions: the version used by Deployment Plan users before updating [1.89.169](./changelog.md#626), and the version after the update. Depending on the version, there may be slight differences in the import process for different types of templates.

Currently, both versions support importing four types of templates: **Built-in Views, Detection Libraries, Custom Explorers, Pipelines**.

<img src="../img/deployment-2.png" width="70%" >

#### Before Version Update

- When selecting different template types, you can download the template directly from the classification dropdown list on the import configuration page;
- For Detection Libraries and Pipelines, after exporting the templates, you need to edit the JSON files according to the official specifications before they can be used.

???- warning "Editing Example"

    :material-numeric-1-circle-outline: Detection Library:

    <img src="../img/detection-template.png" width="60%" >

    1. `checkers`: Replace with the exported checker template;
    2. `title`: Required; name of the detection library;
    3. `summary`: Optional; description of the detection library;
    4. `iconSet`: Optional; logo link for the detection library, defaults to the official logo if not configured;
    5. `thumbnail`: Must not be deleted, otherwise the template cannot be imported.


    :material-numeric-2-circle-outline: Pipeline (Log Pipeline Only):

    <img src="../img/pipeline-template.png" width="60%" >

    1. `pipeline` name; format: xxxx.p;
    2. `pipeline`: Required; parsing rules (Base64 encoded text);
    3. `examples`: Optional; sample data, multiple configurations supported (Base64 encoded text).

#### After Version Update

All four types of templates can now be exported from the frontend console and imported from the management backend.

**Note**: Multiple files can be uploaded at once.

:material-numeric-1-circle-outline: Built-in Views: Exported from the Console > Dashboard/User View.

:material-numeric-2-circle-outline: Custom Explorers: Exported from the Console > Scenarios > Explorer.

:material-numeric-3-circle-outline: Detection Libraries: The [Detection Libraries](../monitoring/monitor/template.md) section in Guance contains various monitor rule templates. Supported export from the [monitor list](../monitoring/monitor/index.md#options).

You can import one or more monitor templates. Detection library names must be unique, but there are no restrictions within the monitors themselves.

:material-numeric-4-circle-outline: Pipelines: Supports multiple types, including log/metrics/RUM.

During the import process, Pipeline names of the same type cannot be duplicated. After successful import, the Pipeline type will be visible in the template list description. If the imported Pipeline template includes test sample data, it will be displayed in the `testData` section of the official template details.

???- warning "Export Example"

    <img src="../img/pipeline-template-1.png" width="60%" >

    1. `category`: Data type; supports non-log templates;  
    2. `name`: Pipeline name;  
    3. `content`: Pipeline script content;  
    4. `testData`: Optional; test sample.

After successful import, the Pipeline type will be automatically identified and filled into the description, distinguishing between Chinese and English.

![](img/deployment-3.png)