# Use Case Examples
---

???+ warning "Prerequisite"

    The charts have been created in the dashboard, and now links need to be added to the charts.


## Using Variables

*Example of jumping to another view:*

### Step One: Add Chart Link
 
1. Define the name as “CPU Usage”;
2. Configure the link address based on the preset link and parameters. As shown in the figure, define the parameters:
   
    - `dashboard_id` is `dsbd_b1e00afaa3b14f5e8e259280c8*****`
    - `name` is `CPU loads`
    - Add the time variable `#{TR}` in the link address and add the parameter `time`, defined as `1h` (last 1 hour)
          
3. Select the opening method as “side slide page”;
4. Confirm.

<img src="../../img/chart_link_use_case_for_view.png" width="60%" >

### Step Two: Verify Link Jump

1. After adding the link, select a specific time point in the chart;
2. Click the configured “CPU Usage” link;
3. Open the target view via side slide.


<img src="../../img/chart_link_use_case_for_view_1.png" width="60%" >


<img src="../../img/chart_link_use_case_for_view_2.png" width="60%" >



## Without Using Variables

*Example of jumping to an external help document:*

### Step One: Add Chart Link

1. Define the name as “help docs”;
2. Directly paste the external URL you want to jump to. For example, `https://docs.<<<custom_key.brand_main_domain>>>/scene/visual-chart/chart-link/`;
3. Select the opening method as “side slide page”;
4. Confirm.

<img src="../../img/chart_link_use_case_for_other_url.png" width="60%" >


### Step Two: Verify Link Jump

1. After adding the link, select a specific time point in the chart;
2. Click the configured “help docs” link;
3. Open the target link via side slide.


<img src="../../img/chart_link_use_case_for_other_url_1.png" width="60%" >