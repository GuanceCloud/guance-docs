# Command Line Interface

## Introduction

The Guance command-line interface (CLI) is a cross-platform command-line tool used to connect to Guance and perform resource management operations on the platform. It is also suitable for importing various third-party ecosystem content into the Guance platform for unified management.

In actual cloud service interaction scenarios, there are three ways to interact with SaaS platforms:

- Imperative APIs and tools: These use operational verbs to explain how to manipulate specific resources, such as RESTful APIs and imperative actions.
- Declarative APIs and tools: These only describe the desired resources. The platform or tool automatically calculates and executes the necessary operations by analyzing the current state.
- Interactive tools: These aim to guide users step-by-step through achieving their goals by interacting with them. For example, an API debugger allows users to continuously adjust parameters and initiate requests until the expected results are achieved.

CLI is a critical developer tool for SaaS providers, serving as another interface for user interaction alongside GUI. CLI is typically used to address software automation issues, enabling automated imperative operations, such as automating operations via scripts that call the CLI to achieve the "last mile" of automation.

The Guance CLI currently supports the following three imperative operations:

- Resource import tool: Used to import third-party ecosystem content into Guance for unified management (e.g., importing Grafana dashboards into Guance).
- Data upload tool: Used to upload one-time data (such as single data files, CI artifacts, etc.) to Guance (e.g., uploading test data).
- Installation tool: Used to install various components of the Guance ecosystem with a single click.

If you wish to start experiencing the capabilities of the Guance CLI, please open the **Use Cases** below, start the interactive guide, and conduct online experiments; or refer to the installation method on the GitHub homepage.

## Use Cases

### Using CLI to Import Grafana Dashboards into Guance

Grafana is a popular open-source data visualization tool that can import data from multiple sources and visualize it. It supports various chart types, such as line charts, bar charts, scatter plots, heatmaps, etc., presenting data in an intuitive manner to help users better understand trends and distributions, aiding in data analysis and decision-making.

The Guance CLI supports exporting Grafana dashboards into a format supported by the Guance platform for import into Guance. Additionally, it can export Terraform files for large-scale project integration.

### Usage Methods

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Guance Grafana Importer - Online Lab</font>](https://killercoda.com/guance-cloud/course/official/grafana-importer)

<br/>

</div>

### Usage Limitations

If the following usage limitations cause inconvenience, please refer to the feedback channels below to contact us and receive 1v1 support.

:material-numeric-1-circle-outline: Partial Panel Format Unsupported

Currently, 10 panel types are supported, including two deprecated types (for compatibility with old dashboards).

If your desired panel type is not supported, please contact us promptly.

:material-numeric-2-circle-outline: Partial Template Variable Syntax Unsupported

PromQL queries in Grafana PromQL dashboards will be translated into DQL queries for Guance, but only non-nested `label_values` expression functions are supported at this time. Other functions like `query_result` will be converted to empty queries.

:material-numeric-3-circle-outline: PromQL Results Do Not Support Abbreviations

PromQL series names are auto-generated based on queries and do not support abbreviations (similar to the `as` keyword in DQL).

### Feedback Channels

https://github.com/GuanceCloud/guance-cli/issues