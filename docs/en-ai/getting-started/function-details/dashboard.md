# Dashboards and Data Linkage
---

Real-time visual data can aggregate and intuitively display core data that enterprises focus on, such as <u>IT, business, etc., enhancing information sharing and communication efficiency, and quickly identifying abnormal data</u>. This helps teams focus on the right and effective tasks, enabling relevant personnel to make better decisions faster.

Guance's dashboard feature provides <u>a rich set of built-in dashboard templates with high customization flexibility, truly connecting the correlation between data</u>, clearly displaying IT system and business Metrics data that users care about, assisting enterprises in real-time monitoring of IT systems and business operations.


## Ready-to-Use Templates

The **System View** is a standard dashboard template provided by Guance, ready-to-use out-of-the-box. It allows quick observation of connected data, helping users track, analyze, and display key performance indicators (KPIs) intuitively, providing an overview of system and business operations.

<div class="grid" markdown>

=== "Method:material-numeric-1-circle-outline: Create from **Dashboards**"

    Click the **Scenarios** module on the left side, then click **Dashboards > New Dashboard**, select or search for the desired view template in **System View**, and click **Confirm** to add it successfully.

    <img src="../../img/dashboard-1.png" width="80%" />

    <img src="../../img/dashboard-2.png" width="80%" />

    **Note**: If the current **Template Library** does not meet your specific needs, you can click **+ New Blank Dashboard** to create a custom view from scratch.

=== "Method:material-numeric-2-circle-outline: Clone from **Built-in Views**"

    Click the **Scenarios** module on the left side, then click **Built-in Views**, select or search for the desired view template in **System View**, preview it, and click **Clone** to add it successfully.

    <img src="../../img/dashboard-3.png" width="80%" />

    <img src="../../img/dashboard-4.png" width="80%" />


=== "View Dashboard After Successful Addition"

    After successfully adding a dashboard, you can immediately view it on the current page. Click **[Add Chart](#chart)** to customize and add various visualization charts. Revisit it from the **Dashboard** list.

    ![](../img/getting-guance-5.png)

</div>


## Custom Visualization Charts {#chart}

Guance includes over 20 standard visualization chart types, which can quickly create different dashboards based on varying business needs, meeting users' requirements for <u>data personalization, readability, format consistency, and efficient comprehensive presentation</u>.

Currently supported chart types include: Time Series, Summary, Table, Treemap, Funnel, Pie Chart, Bar Chart, Histogram, SLO, Top List, Gauge, Scatter Plot, Bubble Chart, China Map, World Map, Hexbin, Text, Image, Video, Command Panel, IFrame, Log Stream, Object List, Alert Statistics, etc.

> For detailed usage of various charts, refer to the documentation [Visualization Charts](../../scene/visual-chart/index.md).

![](../img/dashboard-5.png)

![](../img/dashboard-6.png)

## Data Linkage in Dashboards

Data connected to Guance has <u>high correlation and interactivity</u>.

- Highly correlated data can provide more comprehensive and accurate information, helping users understand the true status of business systems, thus formulating more accurate strategies.
- Interactive data can reduce inefficient collaboration across platforms, teams, and members, truly bringing the <u>"one platform, oversee all" observability experience</u>.

### Achieved via Labels

Guance dashboards can link with modules like infrastructure, logs, APM, RUM, Explorer through custom `Label` associations. When viewing data in other modules, users can <u>view the associated dashboard on the same page</u>.

??? example "Example Background Description"

    - Requirement: Hope to view Kafka usage on hosts named `filebeat-logstash` with Label `kafka` within the **Infrastructure** module;
    - Solution: By associating via `Label`, bind the Kafka monitoring view from the **Dashboard** to the **Infrastructure** module, <u>achieving simultaneous viewing without switching pages</u>.

    ![](../img/dashboard-7.png)

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Add Label"

    Using the addition of `kafka` as an example:

    ![](../img/dashboard-8.png)

=== "Step:material-numeric-2-circle-outline: Bind Label"
    
    - In **Scenarios > Dashboards**, enter an existing dashboard that needs binding; *(if none exists, create a new one)*
    - Click **Settings > Save to Built-in View**, and bind the corresponding `Label`. *(using "Kafka Monitoring View" as an example)*

    ![](../img/dashboard-9.png)

    ![](../img/dashboard-10.png)


=== "Before and After Comparison"

    - Before Binding:

    ![](../img/dashboard-11.png)

    - After Binding:

    ![](../img/dashboard-12.png)

</div>

### Achieved via Chart Links

Visualization charts in Guance dashboards can link with modules like Explorer, other dashboards, infrastructure, external links, etc., via chart links. This enables <u>one-click navigation from the current chart to the target page</u>, allowing for an overview of important metrics followed by targeted in-depth analysis.

Currently, chart links support <u>built-in and custom association links</u>, and variables in the links can be modified using template variables to pass data information, completing data linkage.

> Refer to the documentation [Chart Links](../../scene/visual-chart/chart-link.md) for details.

![](../img/dashboard-13.png)

### Achieved via Monitoring Alerts

Guance has powerful anomaly detection capabilities, offering a series of monitoring templates and supporting custom monitors. Combined with alert notification features, it helps quickly identify, locate, and resolve issues.

> Refer to the documentation [Monitoring](../../monitoring/index.md) for details.

Guance dashboards can link with monitoring alerts, synchronizing monitoring information to prevent missing critical alerts and facilitate team member observations.

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Directly Associate Dashboard in Monitor"

    Open an already created monitor, select the required dashboard under **Associated Dashboard**, and **Save**.<br/>
    (Example shown with "Host Memory Less Than 100M Monitor")

    ![](../img/6.monitor-dashboard_1.png)

=== "Step:material-numeric-2-circle-outline: Navigate from Monitor List"

    In the **Monitor List**, click **View Related View** to navigate to the associated dashboard.

    ![](../img/6.monitor-dashboard_2.png)

</div>