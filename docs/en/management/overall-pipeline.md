# Text Processing (Pipelines)

---

Text processing (Pipelines) is used for data parsing. By defining parsing rules, various data types are cut into structured data that meet our requirements. For example, the timestamp of the log, the status of the log, and other specific fields are extracted by Pipeline as labels.

## Preconditions

- [Install DataKit](../datakit/datakit-install.md)
- DataKit version requirement >= 1.5.0

To ensure the proper use of Pipeline, upgrade DataKit to 1.5.0 and above. Too low a version will cause some Pipeline functions to fail. Before `DataKit<1.5.0` version:

- Default Pipeline functionality is not supported;

- Multiple selection of data sources is not supported, and only one source can be selected per Pipeline. Therefore, if your version is lower than 1.5.0 and you choose multiple data sources, it will not take effect;

- Pipeline name for fixed build does not support modifications. For example, if the log source is nginx, the pipeline name is fixed to nginx.p. Therefore, if your version is lower than 1.5.0 and the Pipeline name is inconsistent with the data source name, the Pipeline will not take effect;

## New Pipeline

In the Guance workspace "Management"-"Pipelines", click "New pipeline" to create a new pipeline file. Or you can click "Pipelines" to create it in the shortcut entry of metrics, logs, user access, application performance, infrastructure and security inspection function directory.

![](img/1-pipeline-2.png)

Note: After the pipeline file is created, DataKit needs to be installed before it will take effect. DataKit will get the configured pipeline file from the workspace regularly. The default time is 1 minute, which can be modified in `conf.d/datakit.conf`.

```
[pipeline]
  remote_pull_interval = "1m"
```

### Configuration Description

On the new pipeline page, you can first "filter" out the data range you want to process text, and then "define the parsing rules". If you want to test whether the input parsing rules are correct and effective, you can enter the corresponding data in the "Sample Parsing Test" for testing. After passing the test, click "Save" to create a pipeline file.

**1.Basic Settings**

- Filtering: data types include logs, indicators, user access monitoring, application performance monitoring, basic objects, custom objects, networks, security check and support multiple choices;
- Pipeline name: Enter a custom Pipeline file name;

???+ attention

    The custom Pipeline file cannot have the same name, but it can have the same name as the official Pipeline. In this case, DataKit will automatically obtain the custom Pipeline file configuration first. If you manually configure the Pipeline file name in the `.conf` file of the collector, DataKit takes precedence over the manually configured Pipeline file name.

- Set as default Pipeline: Check "Set as default Pipeline". If the current data type does not match other Pipeline scripts when matching Pipeline processing, the data will be processed according to the rules of the default Pipeline script.

???+ attention

    Only one "default Pipeline" can be set for each data type. A confirmation box will pop up when there is duplication when creating/importing, asking whether to replace it. It has been checked as the default Pipeline, and there will be a "default" mark after the name.

**2.Define Parsing Rules**
Define parsing rules for data from different sources, support a variety of script functions, and directly view its syntax format by observing the list of script functions provided by the cloud, such as `add_pattern()` ; Refer to the documentation [Pipeline manual](../developers/pipeline.md);

**3.Sample Analysis Test**

According to the selected data type, input the corresponding data, and test it based on the configured parsing rules.

- Click "One-click to obtain samples" to automatically obtain the collected data;
- Click "Add" to add multiple sample data (up to 3 pieces);
- Click "Start Test" to return multiple test results; If you enter more than one sample data in the same test text box for testing, only one test result will be returned.

???+ attention

    Pipeline created in Guance workspace is stored in the `<datakit installation directory>/Pipeline_remote directory`, and each type of Pipeline file is stored in the corresponding secondary directory, where the files in the primary directory are log Pipeline by default. If the indicator `cpu.p` is stored in the `<datakit installation directory >/Pipeline_remote/metric/cpu.p directory`, refer to the doc [Pipeline category data processing](../developers/datakit-pl-global.md).

![](img/7.pipeline_1.png)

### Debug Pipeline {#test}

In the Pipeline editing page, it supports testing for the filled-in parsing rules, and only needs to input data in the "sample parsing test" for testing. If the parsing rules do not conform, the error prompt result will be returned. Sample analysis test is not required. After sample analysis test, the test data is saved synchronously.

#### One Click to Get Sample Test

Guance supports one-click collection of sample test data. When creating/editing Pipeline, click "One-click Collection of Samples" under "Sample Analysis Test", and the system will automatically select the latest data from the collected data reported to the workspace according to the screened data range, and fill it into the test sample box as a sample for testing. When obtaining sample data with one click, only the data in the last 6 hours will be queried each time. If no data is reported in the last 6 hours, it cannot be obtained automatically.

**Debugging sample:**

The following is a sample of reported metric data obtained with one click. The measurement is cpu, and the labels are cpu and host. The fields from usage_guest to usage_user are metric data, and the last 1667732804738974000 is the timestamp. From the return results, we can clearly understand the data structure of one-click sample.

![](img/7.pipeline_2.png)

#### Manually Enter Sample Test

You can also enter sample data directly and manually for testing. Guance supports two format types:

- Log data can be directly input into message content for testing in sample parsing test. For more log Pipeline, please refer to the doc [log Pipeline user manual](../logs/pipelines/manual.md);
- Other data types first convert the content into "line protocol" format, and then input it for sample analysis test.
  
##### Line Protocol Sample

![](img/5.pipeline_5.png)

**Example description:**

- cpu and redis are index sets; tag1 and tag2 are tag sets; f1, f2, and f3 are field sets (where f1=1i is int, f2=1. 2 is float by default, and f3= "abc" is string); 162072387000000000 is the timestamp;
- The indicator set and the tag set are separated by commas; A plurality of labels are separated by commas;
- A space separates the tag set from the field set; Multiple fields are separated by commas;
- A space separates the field set from the timestamp; Timestamp required;
- If it is object data, it must have a `name` label, otherwise the protocol will report an error; It is best to have a `message` field, which is mainly convenient for full-text search.

See the doc [DataKit API](../datakit/apis.md) for more line protocol details.

For more information on how to get the line protocol data, configure the output file of `output_file` in `conf.d/datakit.conf` and view the line protocol in that file.

  ```
  [io]
    output_file = "/path/to/file"
  ```


#### Terminal Command Line Debugging

In addition to debugging Pipeline from Guance studio, you can also debug Pipeline from the terminal command line. See the doc [how to write Pipeline script](../developers/datakit-pl-how-to.md).

### Configuration Sample

Examples of Pipeline configuration can be found in the doc [log Pipeline use manual](../logs/pipelines/manual.md) and [DataKit Pipeline use manual](../logs/pipelines/datakit-manual.md).

## Operate Pipeline

### Edit/Delete/Enable/Disable

In Guance workspace "Management"-"Pipelines", click the button under the operation on the right to edit/delete/enable/disable the pipeline file.
Note:

- After editing the pipeline file, the default effective time is 1 minute;
- After deleting the pipeline file, it cannot be restored and needs to be recreated; If there is an official library pipeline file with the same name, DataKit will automatically match the official library pipeline file for text processing;
- After the pipeline file is disabled, it can be restored by enabling; If there is an official library pipeline file with the same name, DataKit will automatically match the official library pipeline file for text processing;

![](img/1-pipeline-1.png)

### Batch operation

The "batch operation" function supports users to "batch export" and "batch delete" in the pipeline file list. By selecting batch operations, you can select multiple pipeline files for export and deletion at the same time.

In Guance workspace "Management"-"Text Processing", click "Batch Operation" to "Batch Export" or "Batch Delete" Pipelines.

???+ attention

    This function is only displayed for workspace owners, administrators and standard members, but not for read-only members.


### Import/export

Support "import/export Pipeline" in Guance workspace "management"-"text processing (Pipelines)", that is, create Pipeline by importing/exporting JSON files.

???+ attention

    The imported JSON file needs to be the configuration JSON file from Guance.

Select the pipeline file to be deleted, and click "Confirm Delete" to delete the current pipeline file.

![](img/1-pipeline-3.png)

## Pipeline Official Library

Guance provides a standard official Pipeline library for log data to help you quickly structure your log data.

In Guance workspace "Log"-"pipeline", click "pipeline Official Library" to view the built-in standard pipeline official website file library, including nginx, apache, redis, elasticsearch, mysql and so on.

![](img/2.pipeline_1.png)

Select to open any pipeline file, such as apache.p, and you can see the built-in parsing rules. If you need to customize and modify it, you can click "Clone" in the upper right corner.
Note:

- The official pipeline library file does not support modifications.
- Pipeline official library comes with multiple log sample test data, and you can select the log sample test data that meets your own needs before "cloning".
- After the cloned Pipeline is modified and saved, the log sample test data is saved synchronously.

![](img/2.pipeline_2.png)

Automatically generate the pipeline file name with the same name according to the selected log source, and click OK to create a custom pipeline file.

???+ attention

    DataKit will automatically obtain the official library pipeline file. If the cloned custom pipeline file has the same name as the official pipeline, DataKit will give priority to automatically obtaining the newly built custom pipeline file configuration; If the cloned custom pipeline file has a different name from the official pipeline, the file name of the corresponding pipeline needs to be modified in the pipeline of the corresponding collector.

![](img/2.pipeline_3.png)

After the creation is completed, you can view all the custom pipeline files that have been created in "Log"-"Pipelines", and support editing/deleting/enabling/disabling the pipeline.

![](img/2.pipeline_4.png)

## Notes:

Pipeline can do the following on the data collected by DataKit:

- Add, delete, modify values or data types for field and tag

- Change field to tag
  
- Modify the measurement name

- Drop current data`drop()`）

- Terminate the run of the Pipeline script（`exit()`）

  When using Pipeline to process different data types, it will affect the original data structure. It is recommended to confirm that the data processing results meet expectations through [debugging](../developers/datakit-pl-global/#examples) before using it.
