# CI Explorer
---

## Introduction

Guance supports visualizing the process and results for Gitlab/Jenkins' built-in CI，You can view your CI results in Gitlab/Jenkins directly through the CI visualization feature of Guance, and see your CI performance, execution time trends, and reasons for failure in real time；See the health of the entire Pipeline chain during the CI process in real time with the CI Flame Map to help you provide code update assurance.

## Data query and analysis

Once the CI process and result data is reported to the Guance workspace, you can query and analyze Pipeline and Job success rates, failure causes, and specific failure sessions in the CI explorer by selecting a time range, searching for keywords, filtering, and more.

![](img/10.ci_5.png)

### Time Controls

The CI explorer displays the last 15 minutes of data by default. The 「Time Control」 in the upper right corner allows you to select the time range for which data is displayed.More details can be found in the document [Time control description](../getting-started/necessary-for-beginners/explorer-search.md#time) 。

### Search & Filter

In the CI explorer search field, it supports various search methods such as keyword search, wildcard search, correlation search, JSON search, etc. It supports value filtering by `tags/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and non-existence, etc.More search and filtering can be found in the document [explorer search and filtering](../getting-started/necessary-for-beginners/explorer-search.md) 。

### Analysis Mode

In the CI explorer analysis column, it supports multi-dimensional analysis statistics based on **1-3 tags** to reflect the distribution characteristics and trends of the data in different dimensions and over time.Guance supports a variety of data graphical analysis methods, including time-series charts, leaderboards, pie charts, and rectangular tree charts.More details can be found in the document [Analysis mode of the explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis) 。

### Shortcut filter

In CI explorer shortcut filter, you can edit "Shortcut Filter" to add a new filter field. Once added, you can select its field value for shortcut filtering.

**Note：**

- The default progress bar minimum and maximum values of the 「Duration」 of the shortcut filter are the minimum and maximum duration of the link data list
- Support dragging the progress bar to adjust the maximum/minimum value, the value in the input box changes synchronously
- Support manual input of max/min values, "press enter" or "click outside the input box" to filter the search
- The input box turns red when the input is not standardized, and no search is performed, correct format: pure "number" or "number + ns/μs/ms/s/min"
- If you do not enter a unit to search, the default is to enter "s" directly after the number entered and then filter the search
- If you enter the units manually, the search is performed directly

For more shortcut filters, please refer to the document [Shortcut Filter](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter) 。

### Custom Display Columns

In the explorer list, you can customize adding, editing, deleting, and dragging display columns by 「Show Columns」.When the mouse is placed on the explorer display column, click the 「Settings」 button to support the display column to ascend, descend, move the column to the left, move the column to the right, add the column to the left, add the column to the right, replace the column, add to shortcut filter, add to group, remove the column and other operations.More custom display columns can be found in the document [Display Column Description](../getting-started/necessary-for-beginners/explorer-search.md#columns) 。

### Data Export

In the explorer list, you can first filter the data you want to export for viewing and analysis, and support exporting to CSV files, dashboards and notes by clicking the small 「Settings」 icon.

## Gitlab

### Pipeline Explorer

In the top left corner of the explorer, you can switch to the 「Gitlab Pipeline」 explorer to query and analyze the CI Pipeline process, including Pipeline ID, name, duration, commit content, commit time, and more.

![](img/10.ci_5.png)

#### Pipeline Details Page

Click on the data you need to view in the Pipeline list, and the Pipeline and Job details, including properties, flame chart, Job list, content details, and associated logs, will be displayed in the scratch detail page.

When the mouse clicks on a property field, it supports "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy" for quick filtering view.

- "Filter field values", i.e. add the field to the explorer to see all the data associated with the field
- "Reverse filter field values", i.e. add the field to the explorer to see data other than that field
- "Add to display column", i.e. add the field to the explorer list for viewing
- "Copy", i.e. copy the field to the clipboard 

![](img/10.ci_7.1.png)

##### Flame chart

The flame chart clearly shows the flow and execution time of each Job in the entire chain of the Pipeline during the CI process.You can see the list of corresponding services and the percentage of execution time on the right side of the flame chart.Click on the pipeline and job in the flame chart to view the corresponding Json content in 「Detail」.

![](img/10.ci_14.png)

##### Flame chart description

CI visualization mainly collects the data of Pipeline and Job in the CI process. The whole process of Pipeline is divided into three stages (stage) of Build, Test and Deploy, and each stage will have different tasks (Job).

- When the tasks in each phase are completed properly, the Pipeline is successfully executed and the execution time of the entire Pipeline and the execution time of each Job are listed on the flame chart.
- When an error occurs in the execution of the task in the first phase of Build, the task will fail and the reason for the error will be indicated.

To make it easier to understand, the following diagram is an example of the Pipeline process for Gitlab CI. Against the flame diagram above, we can clearly see the execution time of each Job and the execution time of the entire Pipeline to completion.

![](img/10.ci_2.png)

##### Job List

Shows all phases and their number of jobs in the entire Pipeline chain, including "Resource Name", "Number of Jobs", "Execution Time", and "Execution Time Share".Click on any Job, you can view the corresponding Json content in 「Detail」, and if there is an error, an error message will be displayed in front of the Job.

![](img/10.ci_13.png)

### Job Explorer

在In the top left corner of the explorer, you can switch to 「Gitlab Jobs」 to query and analyze the CI Pipeline's Job process, including Pipeline ID, Job name, duration, commit content, commit time, and more.

![](img/10.ci_6.png)

#### Job Details Page

Click on the data you need to view in the Job list, and the Pipeline and Job details, including properties, flame chart, Job list, content details, and associated logs, will be displayed in the scratch detail page.

![](img/10.ci_7.2.png)



## Jenkins

### Pipeline Explorer

In the top left corner of the explorer, you can switch to the 「Jenkins Pipeline」 explorer to query and analyze the CI Pipeline process, including the Pipeline ID, name, duration, commit content, commit time, and more.

![](img/17.CI_4.png)

#### Pipeline Details Page

Click on the data you need to view in the Pipeline list, and the Pipeline and Job details, including properties, flame chart, Job list, content details, and associated logs, will be displayed in the scratch detail page.

![](img/17.CI_5.png)

### Job Explorer

The data type filter in the upper left corner allows you to switch to the 「jenkins_job」 explorer to query and analyze the CI Pipeline's Job process, including Pipeline ID, Job name, duration, commit content, commit time, and more.

![](img/17.CI_8.png)

#### Job Details Page

Click on the data you need to view in the Job list, and the Pipeline and Job details, including properties, flame chart, Job list, content details, and associated logs, will be displayed in the scratch detail page.

![](img/17.CI_9.png)
