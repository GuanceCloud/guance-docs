---
icon: zy/pipeline
---

# Pipelines

---

Pipelines is a lightweight scripting language that runs on DataKit, used for custom parsing and modification of collected data. By defining parsing rules, they can finely slice and convert different types of data into structured formats to meet specific data management needs. For example, users can extract timestamps, status, and other key fields from logs through Pipelines and use this information as labels.

DataKit leverages the powerful features of Pipelines, enabling users to directly write and debug Pipeline scripts on the Guance workspace page, thereby achieving more granular structured processing of data. This not only improves the manageability of data but also supports standardized operations on common data through the rich function library provided by Pipeline, such as parsing time strings and completing geographic information for IP addresses.

The main features of Pipeline include:

- As a lightweight scripting language, Pipeline provides efficient data processing capabilities;
- It has a rich function library that supports standardized operations on various common data types;
- Users can directly write and debug Pipeline scripts on the Guance workspace page, making script creation and batch application more convenient.

Currently, Guance supports configuring local Pipelines and central Pipelines.

- Local Pipeline: Runs during data collection, requiring DataKit collector version 1.5.0 or higher;
- Central Pipeline: Runs after data is uploaded to the console center;

## Use Cases

| <div style="width: 130px">Type</div> | Scenario       |
| ------ | -------- |
| Local Pipeline  | Processing logs before forwarding.       |
| Central Pipeline  | 1. User visit (Session) data, Profiling data, Synthetic Tests data;<br />2. Processing user visit data in the trace, such as extracting `session`, `view`, `resource` fields from the `message` of the trace.       |

All other data can be processed by both local and central Pipelines.

## Prerequisites

<div class="grid" markdown>

=== "Local Pipeline"

    - [Install DataKit](../datakit/datakit-install.md);
    - DataKit version must be >= 1.5.0.

    To ensure normal operation of Pipeline, please upgrade DataKit to version 1.5.0 or higher. A lower version may result in some Pipeline functionalities failing.

    In versions prior to `DataKit<1.5.0`:

    - Default Pipeline functionality is not supported;
    
    - Data sources do not support multiple selections; each Pipeline can only choose one `source`. Therefore, if your version is below 1.5.0 and you have selected multiple data sources, it will not take effect;
    
    - Pipeline names are fixed and cannot be modified. For example, if the log source is `nginx`, the Pipeline name is fixed as `nginx.p`. So if your version is below 1.5.0 and the Pipeline name does not match the data source name, the Pipeline will not take effect.

=== "Central Pipeline"

    This feature requires payment.

</div>

## Getting Started 

In the Guance workspace **Management > Pipelines**, click **New Pipeline**.

Alternatively, you can create a Pipeline by clicking **Pipelines** in the menu directory entries for Metrics, Logs, RUM, APM, Infrastructure, Security Check.

![](img/1-pipeline-2.png)

**Note**: After creating a Pipeline file, DataKit must be installed for it to take effect. DataKit periodically retrieves configured Pipeline files from the workspace, with a default interval of 1 minute, which can be modified in `conf.d/datakit.conf`.

```
[pipeline]
  remote_pull_interval = "1m"
```


1. Select the Pipeline type;
2. Choose the data type and add filtering conditions;
3. Enter the Pipeline name, i.e., the custom Pipeline filename;
4. Provide test samples;
5. Input the function script and configure [parsing rules](#config);
6. Click save.


**Note**:

1. If you select logs as the filtering object, Guance automatically filters out Dial Testing data, and when setting as the default Pipeline, it will not apply to Dial Testing data.
2. When selecting "Synthetic Tests" as the filtering object, the type automatically selects "Central Pipeline," and you cannot choose a local Pipeline.
3. Avoid duplicate Pipeline filenames. If necessary, understand the [storage, indexing, and matching logic of Pipeline scripts](./use-pipeline/pipeline-category.md#script-store-index-match).
4. Each data type can only have one default Pipeline. When creating/importing and encountering duplicates, a confirmation dialog will ask whether to replace it. The name of the Pipeline marked as default will have a `default` identifier.


### Test Samples

Based on the selected data type, input corresponding data to test according to the configured parsing rules.

- One-click sample acquisition: Automatically fetches already collected data;
- Add: Can add multiple sample data entries (up to 3);
- Start testing: Returns multiple test results; if you input multiple sample data entries in the same test text box, only one test result is returned.

**Note**: Pipelines created in the Guance workspace are uniformly saved in `<DataKit installation directory>/pipeline_remote` directories. Each type of Pipeline file is stored in its corresponding subdirectory, where files in the top-level directory are default Log Pipelines. For example, `cpu.p` metrics are saved in `<DataKit installation directory>/pipeline_remote/metric/cpu.p`.

> For more details, refer to [Pipeline Data Processing for Various Categories](./use-pipeline/pipeline-category.md).


#### One-click Sample Acquisition

Guance supports one-click sample acquisition for test data. During Pipeline creation/editing, click **Sample Parsing Test > One-click Sample Acquisition**, and the system will automatically select the latest data within the filtered range from the data already reported to the workspace and fill it into the test sample box for testing. One-click sample acquisition queries data only within the last 6 hours. If there is a gap in reporting within the last 6 hours, automatic acquisition will fail.

*Debugging Example:*

The following is a sample of reported metric data acquired via one-click. The measurement is `cpu`, tags are `cpu` and `host`, and fields from `usage_guest` to `usage_user` are the metric data, with the final 1667732804738974000 being the timestamp. From the returned result, the structure of the one-click sample data is clearly understood.

![](img/7.pipeline_2.png)

#### Manual Sample Input

You can also manually input sample data for testing. Guance supports two format types:

- Log data can directly input `message` content for testing in the sample parsing test;
- Other data types should first convert the content into "line protocol" format before entering it for sample parsing tests.

> For more details on Log Pipelines, refer to the [Log Pipeline User Guide](../logs/manual.md).

##### Line Protocol Example

<img src="../img/pipeline_line_protocal.png" width="60%" >

- `cpu`, `redis` are measurements; `tag1`, `tag2` are tag sets; `f1`, `f2`, `f3` are field sets (`f1=1i` indicates `int`, `f2=1.2` indicates `float` by default, `f3="abc"` indicates `string`); `162072387000000000` is the timestamp;
- Measurements and tag sets are separated by commas; multiple tags are separated by commas;
- Tag sets and field sets are separated by spaces; multiple fields are separated by commas;
- Field sets and timestamps are separated by spaces; timestamps are mandatory;
- For object data, there must be a `name` tag, otherwise the protocol will error; it's best to have a `message` field for full-text search.

> For more details on line protocol, refer to [DataKit API](../datakit/apis.md).

To obtain more line protocol data, configure `output_file` in `conf.d/datakit.conf` and view the line protocol in the output file.

  ```
  [io]
    output_file = "/path/to/file"
  ```

### Define Parsing Rules {#config}

Manually write or AI-generated parsing rules for different data sources, supporting multiple script functions. You can directly view the syntax format of functions like `add_pattern()` from the script function list provided by Guance on the right side.

> For how to define parsing rules, refer to the [Pipeline Manual](./use-pipeline/index.md).

#### Manual Writing

Write data parsing rules manually, allowing settings for automatic line breaks or content overflow.

#### AI Generation

AI-generated parsing rules provide an initial parsing solution based on model generation, aiming to quickly offer preliminary parsing solutions.

<font size=2>**Note**: Since model-generated rules may not cover all complex situations or scenarios, the returned results may not be entirely accurate. It is recommended to use them as a reference and starting point, adjusting and optimizing further based on specific log formats and requirements.</font>

For example, given the sample input needing extracted content and names:

```
-"date_pl":"2024-12-25 07:25:33.525",
-"m_pl":"[INFO][66] route_table.go 237: Queueing a resync of routing table. ipVersion=0x4"
```

Click to generate Pipeline:

![](img/pipeline_ai.png)

After testing, the returned result is:

<img src="../img/pipeline_ai_1.png" width="70%" >

> For more details, refer to the [Rule Writing Guide](./use-pipeline/pipeline-built-in-function.md).

#### Start Testing {#test}

In the Pipeline editing page, you can test the filled-in parsing rules by entering data in **Sample Parsing Test**. If the parsing rule is incorrect, it returns an error message. Sample parsing tests are not mandatory, and the tested data is synchronized and saved.

## Terminal Command Line Debugging

Besides debugging Pipelines in the Guance console, you can also debug Pipelines via terminal command lines.

> For more details, refer to [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Pipeline User Guide**</font>](../logs/manual.md)

</div>

</font>