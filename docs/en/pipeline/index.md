---
icon: zy/pipeline
---

# Pipelines

---

Pipelines is a lightweight scripting language that runs on DataKit, used for custom parsing and modification of collected data. By defining parsing rules, they can finely slice and convert different types of data into structured formats to meet specific data management needs. For example, users can extract timestamps, status, and other key fields from logs via Pipelines and use these pieces of information as tags.

DataKit leverages the powerful functionality of Pipelines, allowing users to directly write and debug Pipeline scripts on the <<< custom_key.brand_name >>> workspace page, thus enabling finer-grained structural processing of data. This not only enhances the manageability of data but also provides a rich library of functions through Pipeline, supporting standardized operations on common data, such as parsing time strings and completing geographic information for IP addresses.

The main features of Pipeline include:

- As a lightweight scripting language, Pipeline offers efficient data processing capabilities;
- It has a rich function library that supports standardized operations on various common data types;
- Users can directly write and debug Pipeline scripts on the <<< custom_key.brand_name >>> workspace page, making script creation and batch effectiveness more convenient.


Currently, <<< custom_key.brand_name >>> supports configuring local Pipelines and central Pipelines.

- Local Pipeline: Runs during data collection, requiring DataKit collector version 1.5.0 or higher;
- Central Pipeline: Runs after data is uploaded to the console center;

## Use Cases

| <div style="width: 130px">Type</div> | Scenario       |
| ------ | -------- |
| Local Pipeline  | Process logs before data forwarding.       |
| Central Pipeline  | 1. User access (Session) data, Profiling data, Synthetic Tests data;<br />2. Process user access data in the chain, such as extracting `session`, `view`, `resource` fields from the `message` in the chain.       |

All other data mentioned above can be handled by both local/central Pipelines.

## Prerequisites

<div class="grid" markdown>

=== "Local Pipeline"

    - [Install DataKit](../datakit/datakit-install.md);
    - DataKit version requirement >= 1.5.0.

    To ensure normal use of Pipeline, please upgrade DataKit to version 1.5.0 or higher. A lower version may cause some Pipeline functions to fail.

    In versions of `DataKit<1.5.0`:

    - Default Pipeline functionality is not supported;

    - Data sources do not support multiple selections; each Pipeline can only choose one `source`. Therefore, if your version is below 1.5.0 and you have selected multiple data sources, it will not take effect;

    - Pipeline names are fixed and cannot be modified. For example, if the log source selects `nginx`, then the Pipeline name is fixed as `nginx.p`. Therefore, if your version is below 1.5.0 and the Pipeline name does not match the data source name, the Pipeline will not take effect.

=== "Central Pipeline"

    This feature requires paid usage.

</div>

## Create 

On the <<< custom_key.brand_name >>> workspace **Management > Pipelines**, click **Create Pipeline**.

Alternatively, you can create by clicking **Pipelines** in the menu directory entries for Metrics, Logs, User Analysis, APM, Infrastructure, Security Check.

<img src="img/1-pipeline-2.png" width="50%" >

**Note**: After creating a Pipeline file, DataKit must be installed for it to take effect. DataKit periodically retrieves configured Pipeline files from the workspace, with a default time of 1 minute, which can be modified in `conf.d/datakit.conf`.

```
[pipeline]
  remote_pull_interval = "1m"
```


1. Select Pipeline type;
2. Select data type and add filtering conditions;
3. Input Pipeline name, i.e., the custom Pipeline filename;
4. Provide [test samples](#sample);
5. Input function scripts and configure [parsing rules](#config);
6. Click save.


**Note**:

- If the filtering object is selected as logs, <<< custom_key.brand_name >>> will automatically filter out Testing data, even if the Pipeline is set as default, it will not apply to Testing data.
- If the filtering object is selected as "Synthetic Tests", the type will automatically be set to "Central Pipeline" and the local Pipeline cannot be selected.
- Pipeline filenames should avoid duplication. If necessary, please refer to [Pipeline Script Storage, Indexing, Matching Logic](./use-pipeline/pipeline-category.md#script-store-index-match).
- Each data type only supports setting one default Pipeline. When creating or importing new ones, if duplicates appear, the system will prompt a confirmation box asking whether to replace. The name of the Pipeline already set as default will display the `default` identifier.


### Test Samples {#sample}

Based on the selected data type, input corresponding data for testing according to the configured parsing rules.

1. One-click sample acquisition: Automatically acquires already collected data, including Message and all fields;
2. Add: You can add multiple sample data (up to 3).

**Note**: Pipeline files created in the workspace are uniformly saved under the `<datakit installation directory>/pipeline_remote` directory. Among them:

- Files under the first-level directory are default Log Pipelines.
- Each type of Pipeline file is saved in the corresponding second-level directory. For example, the Metrics Pipeline file `cpu.p` is saved in the `<datakit installation directory>/pipeline_remote/metric/cpu.p` path.

> For more details, please refer to [Pipeline Category Data Processing](./use-pipeline/pipeline-category.md).


#### One-click Sample Acquisition

When creating/editing a Pipeline, click **Sample Parsing Test > One-click Sample Acquisition**, and the system will automatically select the latest piece of data within the filtered data range from the data already collected and reported to the workspace, filling it into the test sample box for testing. Each click of "One-click Sample Acquisition" will only query data from the last 6 hours; if no data has been reported in the last 6 hours, automatic sample acquisition will not be possible.

*Debugging Example:*

Below is an automatically acquired Metrics data sample, with the Measurement being `cpu` and the tags being `cpu` and `host`. Fields from `usage_guest` to `usage_user` are all Metrics data, and the final `1667732804738974000` is the timestamp. Through the returned result, you can clearly understand the data structure of the one-click sample acquisition.

![](img/7.pipeline_2.png)

#### Manual Sample Input

You can also manually input sample data for testing, supporting two format types:

- Log data can directly input `message` content for testing in the sample parsing test;
- Other data types first convert the content into "line protocol" format, then input it for sample parsing testing.

> For more details about Log Pipelines, please refer to [Log Pipeline User Manual](../logs/manual.md).

##### Line Protocol Example

<img src="img/pipeline_line_protocal.png" width="60%" >


- `cpu`, `redis` are Measurements; `tag1`, `tag2` are tag sets; `f1`, `f2`, `f3` are field sets (`f1=1i` indicates `int`, `f2=1.2` indicates default as `float`, `f3="abc"` indicates `string`); `162072387000000000` is the timestamp;
- Measurements and tag sets are separated by commas; multiple tags are separated by commas;
- Tag sets and field sets are separated by spaces; multiple fields are separated by commas;
- Field sets and timestamps are separated by spaces; timestamps are mandatory;
- If the data is object data, it must have a `name` tag, otherwise the protocol will error; preferably have a `message` field, mainly for convenience in full-text search.

> For more details about line protocols, please refer to [DataKit API](../datakit/apis.md).

To obtain more line protocol data, you can configure the `output_file` in `conf.d/datakit.conf` and view the line protocol in this file.

  ```
  [io]
    output_file = "/path/to/file"
  ```

### Define Parsing Rules {#config}


By manually writing or AI-defining parsing rules for different data sources, support for various script functions is provided, and the syntax format of the script functions provided on the right side of <<< custom_key.brand_name >>> can be directly viewed, such as `add_pattern()`.

> For how to define parsing rules, please refer to [Pipeline Manual](./use-pipeline/index.md).

#### Manual Writing

Autonomously write data parsing rules, text auto-wrap or content overflow can be set.

#### AI Generation

AI-generated parsing rules are based on model-generated Pipeline parsing, aiming to quickly provide an initial parsing solution.

<font size=2>**Note**: Since the rules generated by the model may not cover all complex situations or scenarios, the returned results may not be entirely accurate. It is recommended to use it as a reference and starting point, and make further adjustments and optimizations after generation based on the specific log format and requirements.</font>

Now, based on the sample input, specify the content and names to extract, for example:

```
-"date_pl":"2024-12-25 07:25:33.525",
-"m_pl":"[INFO][66] route_table.go 237: Queueing a resync of routing table. ipVersion=0x4"
```

Click to generate Pipeline:

![](img/pipeline_ai.png)


After testing, the returned result is as follows:

<img src="img/pipeline_ai_1.png" width="70%" >

> For more details, please refer to [Rule Writing Guide](./use-pipeline/pipeline-built-in-function.md).

#### Start Testing {#test}

In the Pipeline editing page, you can test the filled-in parsing rules. Just input data in the **Sample Parsing Test** section for testing. If the parsing rule does not conform, it will return an error message. The Sample Parsing Test is not mandatory, and the tested data will be synchronized and saved after the test.



## Terminal Command-line Debugging

In addition to debugging Pipelines on the <<< custom_key.brand_name >>> console, you can also debug Pipelines via terminal command lines.

> For more details, please refer to [How to Write Pipeline Scripts](./use-pipeline/pipeline-quick-start.md).


## More Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Pipeline User Manual**</font>](../logs/manual.md)

</div>

</font>