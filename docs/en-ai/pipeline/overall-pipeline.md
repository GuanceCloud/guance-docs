# Managing Pipelines

---

## Options

### Single Operation

Click the button under the operations on the right side of the Pipeline file to edit, delete, enable, or disable that data entry.

???+ warning "Note"

    - After editing a Pipeline file, the default effective time is 1 minute;
    - After deleting a Pipeline file, it cannot be restored and needs to be recreated; if there is an official library Pipeline file with the same name, DataKit will automatically match the official library Pipeline file for text processing;
    - After disabling a Pipeline file, it can be re-enabled; if there is an official library Pipeline file with the same name, DataKit will automatically match the official library Pipeline file for text processing.

![](img/1-pipeline-1.png)

### Batch Operations

You can batch-enable, disable, export, or delete multiple Pipeline files.

**Note**: This feature is only visible to workspace owners, administrators, and standard members; read-only members do not see this option.

![](img/1-pipeline-5.png)

### Import

You can create a Pipeline by importing a JSON file.

**Note**: The imported JSON file must be a configuration JSON file from <<< custom_key.brand_name >>>.

![](img/1-pipeline-3.png)

## Official Pipeline Library

<<< custom_key.brand_name >>> provides a standard official library for log data, helping you quickly structure your log data.

In the <<< custom_key.brand_name >>> workspace **Logs > Pipelines**, click **Official Pipeline Library** to view the built-in standard Pipeline files, including nginx, apache, redis, elasticsearch, mysql, etc.

Select and open any Pipeline file, such as `apache.p`, to see the built-in parsing rules. If you need to customize modifications, click the :heavy_plus_sign: Clone button in the top-right corner.

![](img/2.pipeline_2.png)

???+ warning "Note"

    - Official Pipeline library files are not editable;
    - The official Pipeline library comes with multiple log sample test data sets; before cloning, choose the log sample test data that fits your needs;
    - After saving changes to the cloned Pipeline, the log sample test data is saved synchronously.

The Pipeline file name is automatically generated based on the selected log source. Click **Confirm** to create a custom Pipeline file.

**Note**: DataKit will automatically retrieve the official library Pipeline file. If the cloned custom Pipeline file has the same name as the official Pipeline, DataKit will prioritize the newly created custom Pipeline file configuration. If the cloned custom Pipeline file has a different name from the official Pipeline, you need to modify the corresponding Pipeline file name in the relevant collector's Pipeline.

<!-- 
After creation, you can view all custom Pipeline files already created in **Logs > Pipelines**, supporting editing, deleting, enabling, or disabling Pipelines.

![](img/2.pipeline_4.png)
-->

## Precautions

Pipelines can perform the following operations on data collected by DataKit:

- Add, delete, or modify the values or data types of `field` and `tag`;

- Convert `field` to `tag`;

- Modify the name of the Mearsurement;

- Discard current data (`drop()`);

- Terminate the execution of the Pipeline script (`exit()`).

When using Pipelines to process different data types, the original data structure may be affected. It is recommended to confirm that the data processing results meet expectations through [debugging](./use-pipeline/pipeline-quick-start.md) before use.