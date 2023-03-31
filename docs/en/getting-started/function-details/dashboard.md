# Flexible Dashboards and Data Linking
---

## Why are dashboards necessary?

Real-time visual data can gather and visually display core data such as **IT and business that enterprises pay attention to, strengthen the efficiency of information sharing and communication, quickly discover abnormal problem data**, help teams pay attention to correct and effective things, and urge relevant personnel to make better decisions faster.

## What is special about Guance dashboards?    
Guance dashboard function has **built-in dashboard templates with various types, providing a high degree of customization flexibility, truly opening up the correlation between data**, clearly displaying IT system and business metric data concerned by users and assisting enterprises to grasp IT system and business operation in real time.

<u>**So what exactly do we have?**</u>   
## Out-of-the-box Templates

**System View** is a standard dashboard template provided by Guance, which can be used out of the box with one click to quickly observe the accessed data, help users intuitively track, analyze and display key performance metrics, and observe the overall operation status of the system and business.

<div class="grid" markdown>

=== "Method:material-numeric-1-circle-outline: Create from **Dashboards**"
    
    Click **Scenes** module on the left, click **Dashboards > Create** in turn, select or search the view template you want in **System View**, and click **Confirm** to successfully add it.

    <img src="../../img/dashboard-1.png" width="80%" />

    <img src="../../img/dashboard-2.png" width="80%" />

    > **Note**: If the current **Template Library** can't meet your specific needs for the time being, you can click **Create** to create your exclusive view from scratch.

=== "Method:material-numeric-2-circle-outline: Clone from **Inner View**"

    Click **Scenes** module on the left, click **Inner View**, select or search the view template you want in "System View", preview and click **Clone** to successfully add it.

    <img src="../../img/dashboard-3.png" width="80%" />

    <img src="../../img/dashboard-4.png" width="80%" />


=== "View Dashboards after Adding"

    After the dashboard is successfully added, you can view it immediately on the jumped page. Click [Add Charts](#chart) to customize and add a variety of visual charts. Enter again and then you can view from the **Dashboards** list.

    ![](../img/getting-guance-5.png)

</div>


## Custom Visual Charts {#chart}


Guance has built-in visual charts of more than 20 standards, which can quickly create different dashboards according to different business requirements, and meet users' requirements for **personalized data, data readability, format consistency, efficient and comprehensive visual display**. <br/>
At present, the supported chart types include: Query value, Pie chart, Bar chart, Histogram, Top list, Gauge, Segmentation Threshold, Scatter Plot, Bubble, Table, Formatting configuration, Tree map, Funnel, China map, World map, Honeycomb, Logs Stream, Object list, Event, Command Panel, Iframe, text, picture, video, etc.

> See [Visual Charts](../../scene/visual-chart/index.md) for more instructions on charts.

![](../img/dashboard-5.png)

![](../img/dashboard-6.png)

## Data Linking of Dashboards

The data accessed by Guance has a **high degree of relevance and interactivity**.

- Highly correlated data can provide more comprehensive and accurate information, helping users understand the real situation of business systems and then formulating more accurate countermeasures;
- Interactive data can reduce inefficient collaboration across platforms, teams and members, and really bring you an observation experience of **One Platform Observes All**.

### Realized in Label Mode

Guance dashboard can be linked with Infrastructure, Logs, APM, RUM, Explorers and other modules by means of custom Label `Label`. When viewing data in ther modules, you can **view the custom bound dashboard at the same time on current page**.

??? example "<u>Example</u>"

    - Requirements: You want to see the usage of Kafka running on the host named `filebeat-logstash` and Label `Kafka` in the **Infrastructure** at the same time.
    - Scenes: Through the Label `Label` association, you can bind the Kafka monitoring view in the **Dashboards** in the **Infrastructure**, so **that you can view without jumping**.

    ![](../img/dashboard-7.png)

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Create Label"

    <u>(Take the example of adding `kafka` here.)</u>

    ![](../img/dashboard-8.png)

=== "Step:material-numeric-2-circle-outline: Bind Label"
    
    - In **Scene > Dashboards**, go to the existing dashboard that needs to be bound. (If none, create one then)
    - Click **Settings > Save to Built-in View** and bind the corresponding `Label`. (Take "Kafka Monitoring View" as an example.)

    ![](../img/dashboard-9.png)

    ![](../img/dashboard-10.png)


=== "Comparison of Effects"

    - Before binding

    ![](../img/dashboard-11.png)

    - After binding

    ![](../img/dashboard-12.png)

</div>

### Realized by Chart Link

Visual charts in Guance dashboard can be linked with the explorer, other dashboards, infrastructure, external links and other modules through chart links. You can **jump from the current chart to the target page with one click**, so as to overview important indicators through the dashboard first, and then make targeted in-depth analysis.

At present, chart links support **built-in association links and custom association links**, and the corresponding variable values in links can be modified through template variables, and data information can be transmitted to complete data linkage.

> See [Chart Links](../../scene/visual-chart/chart-link.md) for more details.

![](../img/dashboard-13.png)



### Realized by Monitors

Guance has powerful anomaly monitoring capability, which not only provides a series of monitoring templates but also supports custom monitors. See [Monitors](../../monitoring/index.md) for more information.

Guance dashboard can be linked with the monitors, synchronize the monitoring information to prevent the omission of important alarm notifications, and thus facilitate the observation of team members.

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Associate **Dashboards** in **Monitors**"

    Open the created monitor, select the dashboard to be associated in **Associated Dashboard** and then **Save**.<br/>
    <u>(Example of Monitor with Host Memory Less than 100M)</u>

    ![](../img/6.monitor-dashboard_1.png)

=== "Step:material-numeric-2-circle-outline: Jump from **Monitor List**"

    In **Monitor List**, click **View Related Views**, and you can jump to view the dashboard associated with it.

    ![](../img/6.monitor-dashboard_2.png)

</div>
