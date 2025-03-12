# Pipeline Basics and Principles
---

The following sections cover the module design and working principles of DataKit Pipeline, which can help you better understand the Pipeline feature. However, you can choose to skip this content and start using it directly.

## Data Flow in DataKit {#data-flow}

After various collector plugins or the DataKit API collect or receive data, the data will undergo processing via the Pipeline feature before being uploaded.

DataKit Pipeline includes a programmable data processor (Pipeline) and a programmable [data filter](../../datakit/datakit-filter.md) (Filter). The data processor is used for data processing and filtering, while the data filter focuses on data filtering functions.

A simplified view of data flow within DataKit is shown in the following diagram:

![data-flow](img/pipeline-data-flow.drawio.png)

## Data Processor Workflow {#data-processor}

The workflow of the Pipeline data processor is illustrated in the data flow diagram:

![data-processor](img/pipeline-data-processor.drawio.png)