---
Icon: zy/pipeline
---

# Pipelines

---

Pipelines is a lightweight scripting language that runs on DataKit, used for custom parsing and modification of collected data. By defining parsing rules, they can finely slice various types of data and convert them into structured formats to meet specific data management needs. For example, users can extract timestamps, statuses, and other key fields from logs through Pipelines and use this information as tags.

DataKit leverages the powerful capabilities of Pipelines, allowing users to directly write and debug Pipeline scripts on the Guance workspace page, thereby achieving a finer granularity of data structuring. This processing not only enhances the manageability of data but also supports standardized operations for common data types through the rich function library provided by Pipelines, such as parsing time strings and completing geographical information of IP addresses.

The main features of Pipelines include:
- As a lightweight scripting language, Pipelines offer efficient data processing capabilities;
- It has a rich function library that supports standardized operations for a variety of common data types;
- Users can directly write and debug Pipeline scripts on the Guance workspace page, making the creation and batch activation of scripts more convenient.


Currently, Guance supports the configuration of local and central pipelines.

- **Local Pipeline**: Operate during data collection, requiring the DataKit collector version to be no lower than 1.5.0.
- **Central Pipeline**: Operate after data is uploaded to the console center.

### Use Case

| <div style="width: 130px">Type</div> | Scenario |
| ------ | -------- |
| Local Pipeline | Pre-process logs before data forwarding. |
| Central Pipeline | 1. RUM (Session) data, Profiling data;<br />2. Process RUM data in application performance traces, such as extracting `session`, `view`, `resource`, etc., from the `message` of the trace. |

In addition to the use cases mentioned above, both local and central pipelines can handle other data.

### Prerequisites for Use

<div class="grid" markdown>

=== "Local Pipeline"

    - [Install DataKit](../datakit/datakit-install.md);
    - DataKit version requirement >= 1.5.0.

    To ensure normal use of Pipeline, please upgrade DataKit to 1.5.0 or above. Versions that are too low may cause some Pipeline features to fail.

    Before version `DataKit<1.5.0`:

    - Default pipeline functionality is not supported;

    - Data sources do not support multiple selections; each pipeline can only select one `source`. Therefore, if your version is lower than 1.5.0 and you have selected multiple data sources, it will not take effect;

    - The pipeline name is fixed and does not support modification. For example, if the log source is selected as `nginx`, then the pipeline name is fixed as `nginx.p`. So if your version is lower than 1.5.0 and the pipeline name does not match the data source name, the pipeline will not take effect.

=== "Central Pipeline"

    This feature requires a paid subscription.

</div>

### Create

In the Guance workspace, go to **Management > Pipelines** and click on **Create Pipeline**.

Alternatively, you can create a pipeline from the menu entries for metrics, logs, RUM, APM, infrastructure, and security inspection by clicking on **Pipelines**.

![](img/1-pipeline-2.png)

**Note**: After the pipeline file is created, it will only take effect after installing DataKit, which periodically retrieves the configured pipeline files from the workspace at a default interval of 1 minute. This interval can be modified in `conf.d/datakit.conf`.

```
[pipeline]
  remote_pull_interval = "1m"
```

### Configuration Instructions {#config}

On the new pipeline page, you can first **filter** the data range you want to process textually, then **define parsing rules**. If you want to test whether the input parsing rules are correct, you can input corresponding data in **Sample Parsing Test** for testing. After passing the test, click **Save** to create the pipeline file.

![](img/7.pipeline_1.png)

:material-numeric-1-circle: Basic Settings

- Type: Includes local and central pipelines; the default is the former.

- Filter: That is, to filter the data to be parsed by the pipeline; data types include logs, metrics, user access monitoring, application performance monitoring, basic objects, resource directories, network, security inspection; support for multiple selections.
- Pipeline Name: A custom name for the pipeline file.

**Note**:

1. Pipeline file naming must avoid duplicates. If necessary, you should understand the [logic of Pipeline script storage, indexing, and matching](./use-pipeline/pipeline-category.md#script-store-index-match).

2. Each data type can only set one default pipeline. A confirmation box will appear when there is a duplicate during creation/import, asking if you want to replace it. Pipelines that have been selected as the default will have a `default` mark after the name.

:material-numeric-2-circle: Define Parsing Rules

Define parsing rules for data from different sources, supporting a variety of script functions. You can directly view the syntax format of the script functions provided by Guance from the list, such as `add_pattern()`, etc.

> For information on how to define parsing rules, see [Pipeline Manual](./use-pipeline/index.md).

:material-numeric-3-circle: Sample Parsing Test

Based on the selected data type, input the corresponding data and test it based on the configured parsing rules.

- Click **Get a Sample** to automatically obtain already collected data;
- Click **Add** to add multiple sample data (up to 3 pieces);
- Click **Test** to return multiple test results; if you enter multiple sample data in the same test text box for testing, only one test result will be returned.

**Note**: Pipelines created in the Guance workspace are uniformly saved in the directory `<datakit installation directory>/pipeline_remote`. Each type of pipeline file is saved in the corresponding secondary directory, with the files in the primary directory defaulting to log pipelines. For example, the metric `cpu.p` is saved in the directory `<datakit installation directory>/pipeline_remote/metric/cpu.p`.

> For more details, see [Pipeline Category Data Processing](./use-pipeline/pipeline-category.md).



### Debugging Pipeline {#test}

On the pipeline editing page, you can test the parsing rules that have been filled in by simply entering data in the **Sample Parsing Test**. If the parsing rules do not match, an error message will be returned. The sample parsing test is not mandatory, and the test data is saved synchronously after testing.

#### Get a Sample

Guance supports one-click sample test data acquisition. When creating/editing a pipeline, click **Sample Parsing Test > One-click Get Sample**, and the system will automatically select the latest data from the data that has been collected and reported to the workspace according to the filtered data range as a sample to be filled in the test sample box for testing. When acquiring one-click sample data, each time **only data from the last 6 hours will be queried**. If there is no data reported in the last 6 hours, it will not be automatically obtained.

*Debugging Example:*

The following is a sample of the reported metric data obtained with one click, with the metric set as `cpu`, and the tags as `cpu` and `host`. From `usage_guest` to `usage_user`, all are fields, that is, metric data, and the final `1667732804738974000 `is the timestamp. The return results can clearly understand the data structure of the one-click sample.

![](img/7.pipeline_2.png)

#### Manual Sample Test

You can also manually enter sample data for testing. Guance supports two types of formats:

- Log data can be directly entered in the sample parsing test by `message` content for testing;
- For other data types, first convert the content into "line protocol" format, and then enter it for sample parsing test.

> For more details on log pipelines, see [Log Pipeline Manual](../logs/manual.md).

##### Line Protocol Example

![](img/5.pipeline_5.png)


- `cpu`, `redis` are measurements; tag1, tag2 are tag sets; f1, f2, f3 are field sets (where f1=1i indicates int, f2=1.2 indicates default `float`, f3="abc" indicates `string`); `162072387000000000` is the timestamp;
- Measurements and tag sets are separated by commas; multiple tags are separated by commas;
- There is a space between the tag set and the field set; multiple fields are separated by commas;
- There is a space between the field set and the timestamp; the timestamp is required;
- If it is object data, there must be a `name` tag, otherwise the protocol will error; it is best to have a `message` field, mainly for full-text search.

> For more details on line protocol, see [DataKit API](../datakit/apis.md).

For more ways to obtain line protocol data, you can configure the output file of `output_file` in `conf.d/datakit.conf` and view the line protocol in the file.

  ```
  [io]
    output_file = "/path/to/file"
  ```


#### Terminal Command Line Debugging

In addition to debugging pipelines in the Guance console, you can also debug pipelines through the terminal command line.

> For more details, see [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).

## More Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Pipeline Manual**</font>](../logs/manual.md)

</div>

</font>