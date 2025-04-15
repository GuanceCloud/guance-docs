# CI Explorer
---

## Introduction

<<< custom_key.brand_name >>> supports visualization of the built-in CI process and results for Gitlab/Jenkins. You can directly view the CI results in Gitlab/Jenkins through <<< custom_key.brand_name >>>'s CI visualization feature, and get real-time insights into your CI performance, execution time trends, and failure causes. Through the CI flame graph, you can monitor the health status of the entire Pipeline chain during the CI process, helping you ensure code updates.

## Data Query and Analysis

After the process and result data of CI is reported to the <<< custom_key.brand_name >>> workspace, you can query and analyze the success rate, failure reasons, specific failed stages of Pipelines and Jobs in the CI Explorer by selecting a time range, searching keywords, and filtering.

![](img/10.ci_5.png)

### Time Widget

The CI Explorer defaults to showing data from the last 15 minutes. By using the "Time Widget" in the top-right corner, you can select the time range for data display. For more details, refer to the documentation [Time Widget Description](../getting-started/function-details/explorer-analysis.md#time).

### Search and Filtering

In the CI Explorer search bar, multiple search methods are supported including keyword search, wildcard search, associated search, JSON search, etc. You can filter values using `labels/attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, Exist and Not exist, among others. For more on search and filtering, refer to the documentation [Explorer Search and Filter](../getting-started/function-details/explorer-search.md).

### Analysis Mode

In the CI Explorer analysis section, multi-dimensional statistical analysis based on **1-3 labels** is supported, reflecting the distribution characteristics and trends of data across different dimensions over time. <<< custom_key.brand_name >>> supports various data chart analysis methods, including time series graphs, Top Lists, pie charts, and treemaps. For more details, refer to the documentation [Explorer Analysis Mode](../getting-started/function-details/explorer-analysis.md).

### Quick Filter

In the CI Explorer quick filter section, you can edit "quick filters" and add new filter fields. After adding, you can select field values for quick filtering.

**Note:**

- The default minimum and maximum progress bar values for quick filtering of "duration" are the smallest and largest durations in the trace data list.
- You can adjust the maximum/minimum value by dragging the progress bar, and the values in the input box will change synchronously.
- You can manually enter the maximum/minimum value, and press "Enter" or "click outside the input box" to perform filtered searches.
- If the input format is incorrect, the input box turns red, and no search is performed. Correct format: pure "numbers" or "numbers+ns/μs/ms/s/min".
- If no unit is entered for the search, "s" will be automatically added after the number for filtering and searching.
- If a unit is manually entered, the search will be executed directly.

For more on quick filtering, refer to the documentation [Quick Filter](../getting-started/function-details/explorer-filter.md#quick-filter).

### Custom Display Columns

In the Explorer list, you can customize the addition, editing, deletion, and dragging of display columns via "display columns". When hovering over the display column of the Explorer, click the "Settings" button to support operations such as ascending order, descending order, moving columns left, moving columns right, adding columns left, adding columns right, replacing columns, adding to quick filters, adding to groups, and removing columns. For more on customizing display columns, refer to the documentation [Display Column Description](../getting-started/function-details/explorer-analysis.md#columns).

### Data Export

In the Explorer list, you can first filter out the desired data, export it, and then view and analyze it. It supports exporting to CSV files, dashboards, and notes by clicking the "Settings" icon.

## Gitlab

### Pipeline Explorer

In the top-left corner of the Explorer, you can switch to the "Gitlab Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, commit time, etc.

![](img/10.ci_5.png)

#### Pipeline Details Page

Click on the data you want to view in the Pipeline list, and the detailed information of the Pipeline and Job will be displayed in the slide-out detail page, including attributes, flame graphs, Job lists, content details, and related logs.

When clicking on an attribute field with the mouse, you can quickly filter and view by "filtering field values", "reverse filtering field values", "adding to display columns", and "copying".

- "Filtering field values" means adding this field to the Explorer to view all data related to this field.
- "Reverse filtering field values" means adding this field to the Explorer to view all other data except for this field.
- "Adding to display columns" means adding this field to the Explorer list for viewing.
- "Copying" means copying this field to the clipboard.

![](img/10.ci_7.1.png)

##### Flame Graph

The flame graph clearly displays the flow and execution time of each Job in the entire chain of the CI process Pipeline. You can see the corresponding service list and execution time ratio on the right side of the flame graph. Clicking on the pipeline and job in the flame graph allows you to view the corresponding Json content in the "Details".

![](img/10.ci_14.png)

##### Flame Graph Description

CI visualization primarily collects data from the CI process Pipeline and Jobs. The entire Pipeline process is divided into three stages (stages): Build, Test, Deploy. Each stage has different tasks (Jobs).

- When all tasks in each stage complete normally, the Pipeline executes successfully, and the flame graph will list the total execution time of the Pipeline and the execution time of each Job.
- If an error occurs while executing the task in the first stage Build, it will indicate the task failure and the reason for the error.

To make it easier to understand, the following figure is an example of the Gitlab CI Pipeline process. Comparing it with the above flame graph, we can clearly see the execution time of each Job and the total execution time of the entire Pipeline.

![](img/10.ci_2.png)

##### Job List

Displays all stages and their Job counts in the entire Pipeline chain, including "resource names", "Job counts", "execution times", and "execution time ratios". Clicking any Job allows you to view the corresponding Json content in the "Details". If there's an error, an error message will be displayed before the Job.

![](img/10.ci_13.png)

### Job Explorer

In the top-left corner of the Explorer, you can switch to the "Gitlab Job" Explorer to query and analyze the CI Pipeline Job process, including Pipeline ID, Job name, duration, commit content, commit time, etc.

![](img/10.ci_6.png)

#### Job Details Page

Click on the data you need to view in the Job list, and the detailed information of the Pipeline and Job will be displayed in the slide-out detail page, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/10.ci_7.2.png)


## Jenkins

### Pipeline Explorer

In the top-left corner of the Explorer, you can switch to the "Jenkins Pipeline" Explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, commit time, etc.

![](img/17.CI_4.png)

#### Pipeline Details Page

Click on the data you need to view in the Pipeline list, and the detailed information of the Pipeline and Job will be displayed in the slide-out detail page, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/17.CI_5.png)

### Job Explorer

Through the data type filter bar in the top-left corner, you can switch to the "jenkins_job" Explorer to query and analyze the CI Pipeline Job process, including Pipeline ID, Job name, duration, commit content, commit time, etc.

![](img/17.CI_8.png)

#### Job Details Page

Click on the data you need to view in the Job list, and the detailed information of the Pipeline and Job will be displayed in the slide-out detail page, including attributes, flame graphs, Job lists, content details, and related logs.

![](img/17.CI_9.png)