# Dashboards and Data Linking
---

Real-time visualized data can aggregate and intuitively display core data that enterprises focus on, such as <u>IT and business data, enhancing information sharing and communication efficiency, and quickly identifying abnormal data</u>. This helps teams focus on the right and effective tasks, enabling relevant personnel to make better decisions faster.

<<< custom_key.brand_name >>> dashboard functionality <u>includes a rich set of built-in dashboard templates, providing high customization flexibility, truly connecting the correlation between data</u>, achieving clear presentation of IT systems and business Metrics data that users care about, assisting enterprises in real-time monitoring of IT systems and business operations.


## Ready-to-Use Templates

The **System View** is a standard dashboard template provided by <<< custom_key.brand_name >>>, ready-to-use out-of-the-box. It allows users to quickly observe connected data, helping them visually track, analyze, and display key performance indicators, monitoring the overall operation of systems and businesses.

<div class="grid" markdown>

=== "Method:material-numeric-1-circle-outline: Create from **Dashboards**"

    Click on the **Scenarios** module on the left side, then click sequentially **Dashboard > Create Dashboard**, choose or search for the desired view template in **System View**, click **Confirm**, and you will successfully add it.

    <img src="../../img/dashboard-1.png" width="80%" />

    <img src="../../img/dashboard-2.png" width="80%" />

    **Note**: If the current **Template Library** cannot meet your specific needs, you can click **+ Create Blank Dashboard** to start building your exclusive view from scratch.

=== "Method:material-numeric-2-circle-outline: Clone from **Built-in Views**"

    Click on the **Scenarios** module on the left side, then click **Built-in Views**, choose or search for the desired view template in **System View**, preview it, and click **Clone** to successfully add it.

    <img src="../../img/dashboard-3.png" width="80%" />

    <img src="../../img/dashboard-4.png" width="80%" />


=== "View Dashboard After Successful Addition"

    After successfully adding the dashboard, you can immediately view it on the current page. Click **[Add Chart](#chart)** to customize and add various visualization charts. Re-enter to view from the **Dashboard** list.

    ![](../img/getting-guance-5.png)

</div>


## Customizable Visualization Charts {#chart}

<<< custom_key.brand_name >>> includes over 20 standard visualization charts, allowing users to quickly create different dashboards based on different business needs, meeting personalized data visualization requirements, ensuring data readability, format consistency, and efficient comprehensive presentation.

Currently supported chart types include: Time Series, Summary, Table, Treemap, Funnel, Pie, Bar, Histogram, SLO, Top List, Gauge, Scatter Plot, Bubble Chart, China Map, World Map, Hexbin, Text, Image, Video, Command Panel, IFrame, Log Flow, Object List, Alert Statistics, etc.

> For detailed usage of each chart type, refer to the documentation [Visualization Charts](../../scene/visual-chart/index.md)

![](../img/dashboard-5.png)

![](../img/dashboard-6.png)

## Data Linking in Dashboards

Data connected to <<< custom_key.brand_name >>> has <u>high correlation and interactivity</u>.

- Highly correlated data provides more comprehensive and accurate information, helping users understand the true state of business systems, thus formulating more accurate strategies;
- Interactive data reduces inefficient collaboration across platforms, teams, and members, truly bringing you the experience of <u>"one platform, overseeing all"</u>.

### Using Labels

<<< custom_key.brand_name >>> dashboards can be linked with modules like Infrastructure, Logs, APM, RUM, Explorer, etc., through custom `Label` tags. When viewing data in other modules, you can also <u>view the associated dashboard on the same page</u>.

??? example "Example Background Description"

    - Requirement: Hope to view Kafka usage on hosts named `filebeat-logstash` with Label `kafka` within the **Infrastructure** module;  
    - Solution: By associating via `Label`, you can bind the Kafka monitoring view from the **Dashboard** module to the **Infrastructure** module, <u>achieving simultaneous viewing without navigation</u>.

    ![](../img/dashboard-7.png)

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Create Label"

    Taking the addition of `kafka` as an example:

    ![](../img/dashboard-8.png)

=== "Step:material-numeric-2-circle-outline: Bind Label"
    
    - In **Scenarios > Dashboards**, enter an existing dashboard that needs binding; *if none exists, create one*
    - Click **Settings > Save as Built-in View**, and bind the corresponding `Label`. *For example, “Kafka Monitoring View”*

    ![](../img/dashboard-9.png)

    ![](../img/dashboard-10.png)


=== "Before and After Effect Comparison"

    - Before Binding:

    ![](../img/dashboard-11.png)

    - After Binding:

    ![](../img/dashboard-12.png)

</div>

### Using Chart Links

Visualization charts in <<< custom_key.brand_name >>> dashboards can link to modules like Explorer, other dashboards, infrastructure, external links, etc., through chart links. You can <u>jump directly to the target page from the current chart</u>, enabling a quick overview of important metrics followed by targeted deep analysis.

Currently, chart links support <u>built-in and custom association links</u>, and can pass data information through template variables, completing data linking.

> For more details, refer to the documentation [Chart Links](../../scene/visual-chart/chart-link.md).

![](../img/dashboard-13.png)


### Using Monitoring Alerts

<<< custom_key.brand_name >>> has powerful anomaly detection capabilities, not only providing a series of monitoring templates but also supporting custom monitors. Combined with alert notification functions, it helps you quickly identify, locate, and resolve issues.

> For more details, refer to the documentation [Monitoring](../../monitoring/index.md).

<<< custom_key.brand_name >>> dashboards can be linked with monitoring alerts, synchronizing monitoring information to comprehensively assist in monitoring and alerting, preventing important alerts from being missed and making it convenient for team members to observe.

<div class="grid" markdown>

=== "Step:material-numeric-1-circle-outline: Directly Associate Dashboard in Monitor"

    Open an already created monitor, select the dashboard to associate under **Associated Dashboard**, and **Save**.<br/>
    (Example shown: “Host Memory Less Than 100M Monitor”)

    ![](../img/6.monitor-dashboard_1.png)

=== "Step:material-numeric-2-circle-outline: Navigate from Monitor List"

    In the **Monitor List**, click **View Related View** to navigate to the associated dashboard.

    ![](../img/6.monitor-dashboard_2.png)

</div>