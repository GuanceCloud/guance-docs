# Command Line Interface

## Introduction

The Guance command-line interface (CLI) is a cross-platform command-line tool used to connect to <<< custom_key.brand_name >>> and perform resource management operations on <<< custom_key.brand_name >>>. It is also suitable for importing various third-party ecosystem content into the <<< custom_key.brand_name >>> platform for unified management.

In actual cloud service interaction scenarios, there are three ways to interact with SaaS platforms:

- Imperative APIs and tools: Use operation predicates to explain how to manipulate specific resources, such as RESTful and command actions.
- Declarative APIs and tools: Only describe the desired resources. Specific operations are automatically calculated and executed by the platform or tool through analysis of the current state.
- Interactive tools: Aim to guide users step-by-step towards achieving their goals through interaction. For example, an API debugger allows users to continuously adjust parameters and initiate requests until the expected result is achieved.

CLI is an essential developer tool for SaaS providers, replacing GUI as another interface for user interaction. CLI is typically used to address software automation issues, enabling automated imperative operations, such as calling CLI through scripts to achieve the **last mile** of automated operations.

The Guance CLI currently supports the following three imperative operations:

- Resource import tool: Used to import third-party ecosystem content into <<< custom_key.brand_name >>> for unified management (for example, importing Grafana dashboards into <<< custom_key.brand_name >>>).
- Data upload tool: Used to report one-time data (such as single data files, CI artifacts, etc.) to <<< custom_key.brand_name >>> (for example, uploading test data).
- Installation tool: Used for one-click installation of various components in the <<< custom_key.brand_name >>> ecosystem.

If you wish to start experiencing the capabilities of the Guance CLI, open the **Use Cases** below to launch an interactive guide and perform online experiments; or refer to the installation method on the GitHub homepage for installation.

## Use Cases

### Using CLI to Import Grafana Dashboards into <<< custom_key.brand_name >>>

Grafana is a popular open-source data visualization tool that can import data from multiple sources and present it visually. It supports various chart types such as line charts, bar charts, scatter plots, heatmaps, etc., helping users better understand data trends and distributions through intuitive visual presentations, aiding in data analysis and decision-making.

The Guance CLI supports exporting Grafana dashboards into formats supported by <<< custom_key.brand_name >>> for import into <<< custom_key.brand_name >>>. It can also export Terraform files for large-scale project integration.

### Usage Methods

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; <<< custom_key.brand_name >>> Grafana Importer - Online Lab</font>](https://killercoda.com/guance-cloud/course/official/grafana-importer)

<br/>

</div>

### Usage Limitations

If the following usage limitations cause any inconvenience, please refer to the feedback channels below to contact us for 1v1 support.

:material-numeric-1-circle-outline: Some Panel Formats Not Supported

Currently, 10 panel types are supported, including two deprecated types for compatibility with old dashboards.

If the panel you expect is not supported, please contact us promptly.

:material-numeric-2-circle-outline: Some Template Variable Syntax Not Supported

PromQL queries from Grafana PromQL dashboards will be translated into <<< custom_key.brand_name >>> DQL queries, but only non-nested `label_values` expression functions are currently supported. Other functions like `query_result` will be translated to empty queries.

:material-numeric-3-circle-outline: PromQL Results Do Not Support Abbreviation

Series names in PromQL are auto-generated based on queries and do not support abbreviation (similar to the `as` keyword in DQL).

### Feedback Channels

https://github.com/GuanceCloud/guance-cli/issues