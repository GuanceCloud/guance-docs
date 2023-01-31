# Custom Dashboard 
---

## Overview

The dashboard can help you quickly locate the cause of the system problem, so the dashboard you create is to know what the dashboard needs to help you solve, and build a dashboard from the perspective of the problem that needs to be solved. <br />This guide can help you quickly build a dashboard.

## Preconditions

You need to create a [Guance account](https://www.guance.com), [install DataKit](../../datakit/datakit-install.md) on your host, start the operation of related integration, and collect data.

## Preface

Before creating a dashboard, you first need to specify the purpose of creating this dashboard. A good dashboard can help your team focus on the right things. To make a dashboard, we need to dig out the information that the team needs to pay attention to and use most frequently, and summarize these information into dashboards. In particular, the details related to SLO and SLI are the dashboards that every excellent team needs.

Dashboards can be divided into **statistical dashboards** and **executive dashboards** according to their uses.

- **Statistics Dashboard**: For example, resource consumption and business statistics, allow you to grasp some statistical information that needs to be concerned in real time.

- **Execution dashboard** is a dashboard that helps your team solve problems, build problems that need to persist and be tracked continuously, and gradually improve it, such as the self-metrics observation dashboard of each service.

## Out-of-the-box Dashboard

Guance provides a large number of out-of-the-box dashboards, for example, for infrastructure classes, you can use out-of-the-box dashboards directly:

1. Go to "Administration" > "Inner Dashboard" and search for the dashboard corresponding to the integration you opened, such as MySQL and Redis.
2. Click "View" on one of the "Inner Dashboard" to open the dashboard to see if the integrated data you opened is displayed.

## Create a Dashboard

### Copy from an Existing Dashboard

To quickly create a dashboard, You can copy a similar dashboard from an existing one, and then make a few modifications or extensions to become a new dashboard. For example, in the Scenario - Dashboard list page, find a similar dashboard you need. After entering the dashboard, find "Copy Dashboard" in the gear icon in the upper right corner:

![](../img/image1.png)

Any changes made to this copied dashboard will not affect the original **dashboard**.

### Clone from Inner Dashboard

To quickly create a dashboard, you can copy an existing similar dashboard, and then make a few modifications or extensions to become a new dashboard. For example, in the **inner dashboard**, find a built-in integrated view, click the **View** button to open the view, and you can see the **Clone** button in the upper right of the open view page:：

![](../img/image2.png)

After cloning, you can see the **Dashboard** you just cloned in the **Scene** > **Dashboard** list. Click to enter this dashboard, and you can add, modify or extend it based on this dashboard to meet the needs of your team. Any changes made to this cloned **dashboard** will not affect the original **inner dashboard**.

### Create a New Dashboard

You can also choose to create a new dashboard, In the upper left corner of the **Scene** - **Dashboard** page, There is a **New Dashboard** button. Click to create a new dashboard. Here, you can also select a "Built-in View" and create a new dashboard with this built-in view as a template. The effect is equivalent to the above-mentioned **Clone from Inner Dashboard**. You can also create a blank **Dashboard** and build a **Dashboard** from scratch.

### Edit the Dashboard

Click a certain dashboard to enter, and click the **Edit** button in the upper right corner to **edit this dashboard**. You can:

1. Drag a chart from the top **chart gallery** to the appropriate location to add a new chart on this **dashboard**.
2. To edit an existing chart, you can modify the title, style configuration and data query configuration.
3. Delete an unnecessary chart.
4. You can go to another dashboard or the current dashboard to copy a chart, and then press Ctrl+V (Command+V on Mac) in the current dashboard to paste it to create a new chart, or you can directly **clone** a chart from the current dashboard.
5. Click on the title bar of a chart and drag it to the position you think fit.

The functions of **edit**, **delete**, **copy** and **clone** of the chart are all concentrated in the drop-down menu in the upper right corner of the chart.

## Add Charts and Display Data in the Most Appropriate Way

When you have decided to display metrics on this dashboard, you need to consider what form the metrics data can be displayed in an optimal way. You can try to use various [chart types](../../scene/visual-chart/index.md), [query methods](../../scene/visual-chart/chart-query.md), [functions](../../scene/visual-chart/chart-query.md) and [aggregation methods](../../scene/visual-chart/chart-query.md) to display data optimally.

Add **view variables** to the **dashboard** to satisfy you to view the data presentation of different objects on one **dashboard**. For example, you don't add a chart of various host metrics information in the **dashboard**, but there are 10 hosts in your system, so you need to create a **host** view variable and refer to it in each host-related chart, so you can switch the value of this view variable to display the information of different hosts.

### Use of Various Charts

Our chart component library has a wealth of chart components that can be used in the **dashboard**:

- **Sequence diagram:** is used to display time sequence metric information. The abscissa of time sequence diagram is always the time dimension, indicating the change of metric value according to time trend. For example, the CPU, memory and other metric values of the host computer, and the values continuously collected and reported by these collectors can show the situation at each time point in the form of timing diagram. You can choose to use one of **line chart**, **area chart** and **bar chart**.
- **Object List Diagram:** Show your infrastructure in list form, including infrastructure objects such as **hosts, containers, processes, etc. It can also be custom objects**.
- **Overview Chart:** Used to display statistical information.
- **Alarm Statistics Chart:** Show different levels of alarm statistics currently generated.
- **Text, Image, Video:** Enrich your dashboard by adding multiple types of resources to the current dashboard, such as explaining the purpose of the current dashboard.
- **Table diagram:** Use labels as grouping aggregation to display index values, and display data in the form of table list, such as displaying metric values such as CPU and memory of hosts by host aggregation.
- **Ranking list:** Displayed in a sort, such as the host with the highest CPU utilization, the host with the least free disk, and the View with the largest visits.
- **SLO:** Display your SLO information in the dashboard, showing your current SLO target value and the remaining amount in the cycle.

You can see more other [charts](../../scene/visual-chart/index.md) and how to use them here.

## Others

### How to Better Organize the Diagrams on the Dashboard

A dashboard can contain many charts. Organizing these charts in an organized way makes it easier and more accurate to use the dashboard.

In principle, you can arrange diagrams from top to bottom according to their importance priority. You can add a **grouping** on the dashboard (in the **chart gallery**), so that all the charts below this **grouping** will be grouped into this grouping, so that you can collapse this grouping and focus more on other charts.

You can use the **text** chart component flexibly, and add **text** chart components in appropriate places to interpret the chart meaning or considerations that explain this area.

In the layout design of charts, people should see more information in one screen area, so the layout of charts should be compact, not vague, and charts with relevant meanings should be placed in the same area.

### How to Use Links on the Dashboard

You can add links to the dashboard in two ways:

1. Add a **text** chart, where Markdown **text** can be added and links can be added to the text.
1. Add custom links in the settings of the chart, use template variables in the custom links, and pass the content information you click to the target link, so that the target page can display different data according to the content you click.

### Share Charts

You can **share** the chart in the drop-down menu in the upper right corner of the chart, and create a **share** link for the chart, so that people from outside can view the chart.

### Share Dashboard 
We can't share the dashboard directly, but we can save the dashboard as a **snapshot** and then share this snapshot.

![](../img/image3.png)

![](../img/image4.png)
