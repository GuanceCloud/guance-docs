# CI Explorer
---

## Introduction

<<< custom_key.brand_name >>> supports the visualization of the process and results of Gitlab/Jenkins's built-in CI. You can directly view the CI results in Gitlab/Jenkins through <<< custom_key.brand_name >>>'s CI visualization feature, gaining real-time insights into your CI performance, execution time trends, and failure reasons. Through the CI flame graph, you can monitor the health of the entire Pipeline chain during the CI process, helping to ensure code updates.

## Data Query and Analysis

After the CI process and result data are reported to the <<< custom_key.brand_name >>> workspace, you can query and analyze Pipeline and Job success rates, failure reasons, specific failure stages, etc., using the CI Explorer by selecting a time range, searching with keywords, or applying filters.

![](img/10.ci_5.png)

### Time Widget

The CI Explorer defaults to displaying data from the past 15 minutes. Using the "Time Widget" in the top-right corner, you can choose the time range for data display. For more details, refer to the [Time Widget documentation](../getting-started/function-details/explorer-search.md#time).

### Search and Filtering

In the CI Explorer search bar, multiple search methods are supported, including keyword search, wildcard search, related search, and JSON search. You can filter values using `tags/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, checking for existence or non-existence, and more. For more information on search and filtering, see the [Explorer Search and Filter documentation](../getting-started/function-details/explorer-search.md).

### Analysis Mode

In the CI Explorer analysis panel, multi-dimensional statistical analysis based on **1-3 tags** is supported to reflect the distribution characteristics and trends of data across different dimensions over time. <<< custom_key.brand_name >>> supports various data chart analysis methods, including time series charts, top lists, pie charts, and treemaps. For more details, refer to the [Explorer Analysis Mode documentation](../getting-started/function-details/explorer-search.md#analysis).

### Quick Filters

In the CI Explorer quick filter section, you can edit "quick filters" and add new filter fields. After adding them, you can select field values for quick filtering.

**Note:**

- The default minimum and maximum values for the "duration" progress bar are the smallest and largest durations in the trace data list.
- You can adjust the maximum/minimum values by dragging the progress bar, which will synchronize changes in the input boxes.
- You can manually enter maximum/minimum values and press "Enter" or click outside the input box to perform a filtered search.
- If the input format is incorrect, the input box turns red, and no search is performed. Correct formats include pure "numbers" or "numbers+ns/μs/ms/s/min".
- If no unit is specified, "s" is added after the entered number before performing the search.
- If a unit is manually entered, the search is performed directly.

For more information on quick filters, refer to the [Quick Filter documentation](../getting-started/function-details/explorer-search.md#quick-filter).

### Custom Display Columns

In the Explorer list, you can customize the display columns by adding, editing, deleting, or dragging display columns. When hovering over the display columns in the Explorer, clicking the "Settings" button allows you to sort columns in ascending or descending order, move columns left or right, add columns to quick filters, add columns to groups, or remove columns. For more information on customizing display columns, refer to the [Display Column documentation](../getting-started/function-details/explorer-search.md#columns).

### Data Export

In the Explorer list, you can first filter out the desired data and then export it for viewing and analysis. Supported export formats include CSV files, dashboards, and notes.

## Gitlab

### Pipeline Explorer

In the top-left corner of the Explorer, you can switch to the "Gitlab Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, commit time, etc.

![](img/10.ci_5.png)

#### Pipeline Details Page

Click on the data you want to view in the Pipeline list, and the detailed page will show the details of the Pipeline and Jobs, including attributes, flame graphs, Job lists, content details, and associated logs.

When you click on an attribute field, you can quickly filter and view data by "filtering field values," "excluding field values," "adding to display columns," or "copying" the field.

- "Filtering field values" adds the field to the Explorer to view all related data.
- "Excluding field values" adds the field to the Explorer to view data excluding this field.
- "Adding to display columns" adds the field to the Explorer list for viewing.
- "Copying" copies the field to the clipboard.

![](img/10.ci_7.1.png)

##### Flame Graph

The flame graph clearly displays each Job's flow and execution time in the entire Pipeline chain during the CI process. On the right side of the flame graph, you can view the corresponding service list and execution time percentages. Clicking on the pipeline and job in the flame graph shows the corresponding Json content in the "Details."

![](img/10.ci_14.png)

##### Flame Graph Explanation

CI visualization primarily collects data from the Pipeline and Jobs during the CI process. The entire Pipeline process is divided into three stages (stages): Build, Test, Deploy. Each stage has different tasks (Jobs).

- If all tasks in each stage complete normally, the Pipeline successfully executes, and the flame graph will list the total execution time of the Pipeline and each Job's execution time.
- If the tasks in the first stage, Build, fail, an error message will indicate the task failure and the reason.

For easier understanding, the following diagram illustrates the Gitlab CI Pipeline process. Referring to the flame graph above, you can clearly see the execution time of each Job and the total execution time of the entire Pipeline.

![](img/10.ci_2.png)

##### Job List

This section displays all stages and their Job counts in the entire Pipeline chain, including "resource name," "Job count," "execution time," and "execution time percentage." Clicking any Job shows the corresponding Json content in the "Details." If there are errors, an error message appears before the Job.

![](img/10.ci_13.png)

### Job Explorer

In the top-left corner of the Explorer, you can switch to the "Gitlab Job" Explorer to query and analyze the CI Pipeline's Job process, including Pipeline ID, Job name, duration, commit content, commit time, etc.

![](img/10.ci_6.png)

#### Job Details Page

Click on the data you want to view in the Job list, and the detailed page will show the details of the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and associated logs.

![](img/10.ci_7.2.png)

## Jenkins

### Pipeline Explorer

In the top-left corner of the Explorer, you can switch to the "Jenkins Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, commit time, etc.

![](img/17.CI_4.png)

#### Pipeline Details Page

Click on the data you want to view in the Pipeline list, and the detailed page will show the details of the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and associated logs.

![](img/17.CI_5.png)

### Job Explorer

Using the data type filter bar in the top-left corner, you can switch to the "jenkins_job" Explorer to query and analyze the CI Pipeline's Job process, including Pipeline ID, Job name, duration, commit content, commit time, etc.

![](img/17.CI_8.png)

#### Job Details Page

Click on the data you want to view in the Job list, and the detailed page will show the details of the Pipeline and Job, including attributes, flame graphs, Job lists, content details, and associated logs.

![](img/17.CI_9.png)