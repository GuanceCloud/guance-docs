---
icon: zy/pipeline
---

# Pipelines

---

Pipelines is a lightweight scripting language that runs on DataKit, used for custom parsing and modification of collected data. By defining parsing rules, they can finely slice and convert different types of data into structured formats to meet specific data management needs. For example, users can extract timestamps, status, and other key fields from logs using Pipelines and use this information as labels.

DataKit leverages the powerful capabilities of Pipelines, allowing users to write and debug Pipeline scripts directly on the <<< custom_key.brand_name >>> workspace page, thus achieving finer-grained structured processing of data. This not only enhances data manageability but also supports standardized operations on common data through the rich function library provided by Pipeline, such as parsing time strings and enriching IP address geographic information.

Key features of Pipeline include:

- As a lightweight scripting language, Pipeline offers efficient data processing capabilities.
- It has a rich function library supporting standardized operations on various common data types.
- Users can write and debug Pipeline scripts directly on the <<< custom_key.brand_name >>> workspace page, making script creation and batch application more convenient.

Currently, <<< custom_key.brand_name >>> supports configuring local Pipelines and central Pipelines.

- Local Pipeline: Runs during data collection, requiring DataKit collector version 1.5.0 or higher.
- Central Pipeline: Runs after data is uploaded to the console center.

## Use Cases

| <div style="width: 130px">Type</div> | Scenario       |
| ------ | -------- |
| Local Pipeline | Processing logs before forwarding.       |
| Central Pipeline | 1. User access (Session) data, Profiling data, Synthetic Tests data;<br />2. Processing user access data in the trace, such as extracting `session`, `view`, `resource` fields from the `message` in the trace.       |

In addition to the above scenarios, both local and central Pipelines can handle other types of data.

## Prerequisites

<div class="grid" markdown>

=== "Local Pipeline"

    - [Install DataKit](../datakit/datakit-install.md);
    - DataKit version must be >= 1.5.0.

    To ensure normal usage of Pipeline, upgrade DataKit to version 1.5.0 or higher. A lower version may cause some Pipeline functions to fail.

    In versions of `DataKit<1.5.0`:

    - Default Pipeline functionality is not supported;
    
    - Multiple data sources are not supported; each Pipeline can only select one `source`. Therefore, if your version is below 1.5.0 and you have selected multiple data sources, it will not take effect;

    - Pipeline names are fixed and cannot be modified. For example, if the log source is `nginx`, the Pipeline name is fixed as `nginx.p`. If your version is below 1.5.0 and the Pipeline name does not match the data source name, the Pipeline will not take effect.

=== "Central Pipeline"

    This feature requires a paid plan.

</div>

## Create

In the <<< custom_key.brand_name >>> workspace **Management > Pipelines**, click **Create Pipeline**.

Alternatively, you can create Pipelines by clicking **Pipelines** in the menu directory entries for Metrics, Logs, RUM PV, APM, Infrastructure, Security Check.

![](img/1-pipeline-2.png)

**Note**: After creating a Pipeline file, it will only take effect after installing DataKit. DataKit periodically retrieves configured Pipeline files from the workspace, with a default interval of 1 minute, which can be modified in `conf.d/datakit.conf`.

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

1. If you choose logs as the filtering object, <<< custom_key.brand_name >>> will automatically filter out Test data. When setting as the default Pipeline, it will not apply to Test data.
2. When you choose "Synthetic Tests" as the filtering object, the type automatically defaults to "Central Pipeline," and you cannot choose a local Pipeline.
3. Avoid duplicate Pipeline filenames. If necessary, understand the [storage, indexing, and matching logic of Pipeline scripts](./use-pipeline/pipeline-category.md#script-store-index-match).
4. Each data type can only have one default Pipeline. When creating/importing a new one, a confirmation box will appear asking if you want to replace it. The default Pipeline will have a `default` tag after its name.


### Test Samples

Based on the selected data type, input corresponding data to test based on the configured parsing rules.

- One-click sample retrieval: Automatically retrieves already collected data;
- Add: Add multiple sample data (up to 3);
- Start testing: Returns multiple test results; if you input multiple sample data in the same test text box, only one result is returned.

**Note**: Pipelines created in the <<< custom_key.brand_name >>> workspace are saved under `<DataKit installation directory>/pipeline_remote`. Each type of Pipeline file is stored in corresponding subdirectories, with the top-level directory's files being default log Pipelines. For example, `cpu.p` metrics are saved in `<DataKit installation directory>/pipeline_remote/metric/cpu.p`.

> For more details, refer to [Pipeline data processing by category](./use-pipeline/pipeline-category.md).

#### One-click Sample Retrieval

<<< custom_key.brand_name >>> supports one-click sample retrieval for testing data. When creating/editing a Pipeline, click **Sample Parsing Test > One-click Sample Retrieval**. The system will automatically select the latest data within the filtered range from the data reported to the workspace and fill it into the test sample box for testing. One-click sample retrieval queries data only from the last 6 hours. If there is a gap in reporting within the last 6 hours, it will not retrieve any data.

*Debugging Example:*

The following is a sample of reported metric data, with the measurement set as `cpu`, tags as `cpu` and `host`, and fields from `usage_guest` to `usage_user` representing metric data, with the final 1667732804738974000 being the timestamp. From the returned result, you can clearly understand the structure of the one-click retrieved sample data.

![](img/7.pipeline_2.png)

#### Manual Sample Input

You can also manually input sample data for testing. <<< custom_key.brand_name >>> supports two format types:

- Log data can be directly input as `message` content for testing;
- Other data types should be converted into "line protocol" format before inputting for sample parsing tests.

> For more details on log Pipelines, refer to the [Log Pipeline User Guide](../logs/manual.md).

##### Line Protocol Example

<img src="img/pipeline_line_protocal.png" width="60%" >

- `cpu`, `redis` are measurements; `tag1`, `tag2` are tag sets; `f1`, `f2`, `f3` are field sets (`f1=1i` indicates `int`, `f2=1.2` indicates `float`, `f3="abc"` indicates `string`); `162072387000000000` is the timestamp;
- Measurements and tag sets are separated by commas; multiple tags are separated by commas;
- Tag sets and field sets are separated by spaces; multiple fields are separated by commas;
- Field sets and timestamps are separated by spaces; timestamps are mandatory;
- If it is object data, it must have a `name` tag, otherwise the protocol will error; it is best to have a `message` field for full-text search.

> For more details on line protocol, refer to [DataKit API](../datakit/apis.md).

To obtain more line protocol data, configure the `output_file` in `conf.d/datakit.conf` and view the line protocol in that file.

  ```
  [io]
    output_file = "/path/to/file"
  ```

### Define Parsing Rules {#config}

Manually write or AI-generate parsing rules for different data sources. Support multiple script functions, and you can directly view their syntax formats via the script function list provided on the right side of <<< custom_key.brand_name >>>, such as `add_pattern()`.

> For more details on how to define parsing rules, refer to the [Pipeline Manual](./use-pipeline/index.md).

#### Manual Writing

Autonomously write data parsing rules, enabling automatic line breaks or content overflow settings.

#### AI Generation

AI-generated parsing rules are based on model-generated Pipeline parsing, aiming to quickly provide an initial parsing solution.

<font size=2>**Note**: Since model-generated rules may not cover all complex cases or scenarios, the returned results may not be entirely accurate. It is recommended to use them as a reference and starting point, and make further adjustments and optimizations based on specific log formats and requirements.</font>

For example, based on the sample input needing extracted content and names:

```
-"date_pl":"2024-12-25 07:25:33.525",
-"m_pl":"[INFO][66] route_table.go 237: Queueing a resync of routing table. ipVersion=0x4"
```

Click to generate Pipeline:

![](img/pipeline_ai.png)

After testing, the returned result is:

<img src="img/pipeline_ai_1.png" width="70%" >

> For more details, refer to the [Rule Writing Guide](./use-pipeline/pipeline-built-in-function.md).

#### Start Testing {#test}

In the Pipeline editing page, you can test the entered parsing rules by inputting data in the **Sample Parsing Test** section. If the parsing rule is incorrect, it will return an error message. Sample parsing tests are optional, and the tested data will be saved synchronously.

## Terminal Command Line Debugging

In addition to debugging Pipelines on the <<< custom_key.brand_name >>> console, you can also debug them via terminal command lines.

> For more details, refer to [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Pipeline User Guide**</font>](../logs/manual.md)

</div>

</font>