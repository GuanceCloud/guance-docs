# Basics and Principles
---

The following describes the module design and working principles of DataKit Pipeline, which can help you better understand the features of Pipeline. However, you may choose to skip this section and start using it directly.

## Data Flow in DataKit {#data-flow}

After various collector plugins of DataKit or the DataKit API collect or receive data, the data will go through the Pipeline feature for data manipulation before being uploaded.

DataKit Pipeline includes a programmable data processor (Pipeline) and a programmable [Data Filter](../../datakit/datakit-filter.md) (Filter). The data processor is used for data processing and filtering, while the data filter focuses on the data filtering function.

The simplified data flow in DataKit is shown in the figure below:

![data-flow](img/pipeline-data-flow.drawio.png)

## Data Processor Workflow {#data-processor}

The workflow of the Pipeline data processor is shown in the data flowchart:


![data-processor](img/pipeline-data-processor.drawio.png)
