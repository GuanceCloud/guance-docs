# Manage Pipelines

---

## List

### For a Single Pipeline

Click the button next to the Pipeline file operation to edit, delete, enable, or disable that specific data entry.

???+ warning "Note"

    - After editing a Pipeline file, the default effective time is 1 minute;
    - After deleting a Pipeline file, it cannot be recovered and must be recreated; if there is an official library Pipeline file with the same name, DataKit will automatically match the official library Pipeline file for text processing;
    - After disabling a Pipeline file, you can restore it by enabling it again; if there is an official library Pipeline file with the same name, DataKit will automatically match the official library Pipeline file for text processing.

![](img/1-pipeline-1.png)

### Batch Operations

You can enable, disable, export, or delete multiple Pipeline files in batch.

**Note**: This feature is only displayed for workspace owners, administrators, and standard members; read-only members do not have access to it.

![](img/1-pipeline-5.png)

### Import

Pipelines can be created by importing a JSON file.

**Note**: The imported JSON file must be a configuration JSON file from Guance.

![](img/1-pipeline-3.png)

## Official Pipeline Library

Guance provides a standard official Pipeline library for log data to help you quickly structure your log data.

In the Guance workspace, go to **Logs > Pipelines** and click on **Pipeline Library** to view the built-in standard Pipeline official file library, including nginx, apache, redis, elasticsearch, mysql, etc.


Select and open any Pipeline file, such as `apache.p`, and you can see the built-in parsing rules. If you need to customize modifications, you can click the top right corner :heavy_plus_sign: Clone button.

![](img/2.pipeline_2.png)



???+ warning "Note"

    - Official library Pipeline files cannot be modified;
    - The official Pipeline library comes with multiple log sample test data, and you can choose log sample test data that meets your needs before cloning;
    - The log sample test data is saved synchronously after the cloned Pipeline is modified and saved.

Generate a Pipeline file with the same name as the selected log source, and click **Confirm** to create a custom Pipeline file.

**Note**: DataKit will automatically obtain the official library Pipeline files; if the cloned custom Pipeline file has the same name as the official Pipeline, DataKit will prioritize obtaining the newly created custom Pipeline file configuration; if the cloned custom Pipeline file has a different name from the official Pipeline, you will need to modify the corresponding Pipeline file name in the Pipeline of the corresponding collector.

## Precautions

Pipelines can perform the following operations on the data collected by DataKit:

- Add, delete, or modify the values or data types of `fields` and `tags`;

- Change `fields` to `tags`;

- Modify the name of the metric set;

- Discard the current data (`drop()`);

- Terminate the execution of the Pipeline script (`exit()`).

When using Pipeline to process different data types, it will affect the original data structure. It is recommended to use [debugging](./use-pipeline/pipeline-quick-start.md) to confirm that the data processing results meet the expectations before use.
