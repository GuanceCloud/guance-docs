# CI Explorer
---

## Introduction

Guance supports the visualization of the process and results of built-in CI in Gitlab/Jenkins. Through the CI visualization feature of Guance, you can directly view the CI results in Gitlab/Jenkins, gaining real-time insights into your CI performance, execution time trends, and failure causes. By using CI flame graphs, you can monitor the health status of the entire Pipeline chain during the CI process, helping to ensure code updates.

## Data Query and Analysis

After the process and result data of CI is reported to the Guance workspace, you can query and analyze the success rate, failure reasons, specific failure stages of Pipelines and Jobs by selecting time ranges, searching with keywords, and filtering within the CI Explorer.

![](img/10.ci_5.png)

### Time Controls

The CI Explorer defaults to displaying data from the last 15 minutes. Using the "Time Controls" in the top-right corner, you can choose the time range for data display. For more details, refer to the [Time Controls Documentation](../getting-started/function-details/explorer-search.md#time).

### Search and Filter

In the CI Explorer search bar, multiple search methods are supported, including keyword search, wildcard search, associated search, and JSON search. You can filter values using `labels/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence checks, and non-existence checks. For more on searching and filtering, see the [Explorer Search and Filter Documentation](../getting-started/function-details/explorer-search.md).

### Analysis Mode

In the analysis section of the CI Explorer, multi-dimensional analysis statistics based on **1-3 labels** are supported to reflect data distribution characteristics and trends across different dimensions over time. Guance supports various data chart analysis methods, including time series charts, top lists, pie charts, and treemaps. For more details, refer to the [Explorer Analysis Mode Documentation](../getting-started/function-details/explorer-search.md#analysis).

### Quick Filters

In the CI Explorer quick filters, you can edit "quick filters" and add new filter fields. After adding, you can select field values for quick filtering.

**Note:**

- The default minimum and maximum values for "duration" in quick filters are the smallest and largest durations in the trace data list.
- You can adjust the maximum/minimum values by dragging the progress bar, which will update the input box values synchronously.
- You can manually enter maximum/minimum values and apply the filter by pressing "Enter" or clicking outside the input box.
- If the input format is incorrect, the input box turns red, and no search is performed. Correct formats include pure "numbers" or "number+ns/μs/ms/s/min".
- If no unit is specified, "s" is appended to the number before performing the filter.
- If a unit is manually entered, the search is performed directly.

For more on quick filters, refer to the [Quick Filters Documentation](../getting-started/function-details/explorer-search.md#quick-filter).

### Custom Display Columns

In the Explorer list, you can customize columns by adding, editing, deleting, and dragging display columns. When hovering over the display columns in the Explorer, click the "Settings" button to perform operations such as sorting ascending/descending, moving columns left/right, adding/removing columns, and adding columns to quick filters or groups. For more on customizing display columns, see the [Display Columns Documentation](../getting-started/function-details/explorer-search.md#columns).

### Data Export

In the Explorer list, you can first filter the desired data and then export it for viewing and analysis. Supported export options include CSV files, dashboards, and notes.

## Gitlab

### Pipeline Explorer

In the top-left corner of the Explorer, switch to the "Gitlab Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, and commit time.

![](img/10.ci_5.png)

#### Pipeline Details Page

Click on the data you want to view in the Pipeline list. In the sliding details page, you can see detailed information about the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and related logs.

When you click on an attribute field, you can perform actions like "filter by field value," "exclude field value," "add to display columns," and "copy" for quick filtering.

- "Filter by field value": Adds the field to the Explorer to view all related data.
- "Exclude field value": Adds the field to the Explorer to view data excluding this field.
- "Add to display columns": Adds the field to the Explorer list for viewing.
- "Copy": Copies the field to the clipboard.

![](img/10.ci_7.1.png)

##### Flame Graph

The flame graph clearly displays the flow and execution time of each Job in the entire Pipeline chain. On the right side of the flame graph, you can view the service list and the percentage of execution time. Clicking on a pipeline or job in the flame graph shows the corresponding JSON content in the "Details."

![](img/10.ci_14.png)

##### Flame Graph Explanation

CI visualization primarily collects data on the Pipeline and Job processes. The entire Pipeline process is divided into three stages (stages): Build, Test, Deploy. Each stage has different tasks (Jobs).

- If all tasks in each stage complete normally, the Pipeline executes successfully, and the flame graph will list the total execution time of the Pipeline and each Job.
- If an error occurs during the first stage, Build, it will indicate task failure and the reason for the error.

For better understanding, the following diagram illustrates the Gitlab CI Pipeline process. Referring to the above flame graph, you can clearly see the execution time of each Job and the overall completion time of the Pipeline.

![](img/10.ci_2.png)

##### Job List

Displays all stages and their Job counts in the entire Pipeline chain, including "resource name," "Job count," "execution time," and "execution time ratio." Click any Job to view the corresponding JSON content in the "Details." If there's an error, an error message appears before the Job.

![](img/10.ci_13.png)

### Job Explorer

In the top-left corner of the Explorer, switch to the "Gitlab Job" Explorer to query and analyze the CI Pipeline Job process, including Pipeline ID, Job name, duration, commit content, and commit time.

![](img/10.ci_6.png)

#### Job Details Page

Click on the data you want to view in the Job list. In the sliding details page, you can see detailed information about the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/10.ci_7.2.png)

## Jenkins

### Pipeline Explorer

In the top-left corner of the Explorer, switch to the "Jenkins Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, and commit time.

![](img/17.CI_4.png)

#### Pipeline Details Page

Click on the data you want to view in the Pipeline list. In the sliding details page, you can see detailed information about the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/17.CI_5.png)

### Job Explorer

Using the data type filter bar in the top-left corner, switch to the "jenkins_job" Explorer to query and analyze the CI Pipeline Job process, including Pipeline ID, Job name, duration, commit content, and commit time.

![](img/17.CI_8.png)

#### Job Details Page

Click on the data you want to view in the Job list. In the sliding details page, you can see detailed information about the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/17.CI_9.png)