# 场景示例
---

???+ warning "前提"

    已在仪表板中完成图表创建，现在需要为图表添加链接。


## 使用变量

*以跳转到其他视图为例：*

### 步骤一：添加图表链接
 
1. 定义名称 “CPU Usage”； 
2. 根据预设的链接和参数配置链接地址。如图，定义参数：        
   
    - `dashboard_id` 为 `dsbd_b1e00afaa3b14f5e8e259280c8*****`
    - `name` 为 `CPU loads`
    - 在链接地址中添加时间变量 `#{TR}`，并添加参数 `time`，定义为 `1h` (最近 1 小时)
          
3. 选择打开方式为“侧滑页”；
4. 确定。     

<img src="../../img/chart_link_use_case_for_view.png" width="60%" >

### 步骤二：链接跳转验证

1. 链接添加完成后，在图表中选中某一时间点；
2. 点击配置的 “CPU Usage” 链接；
3. 侧滑打开目标视图。


<img src="../../img/chart_link_use_case_for_view_1.png" width="60%" >


<img src="../../img/chart_link_use_case_for_view_2.png" width="60%" >



## 不使用变量

*以跳转到外部帮助文档为例：*

### 步骤一：添加图表链接

1. 定义名称 “help docs”； 
2. 直接粘贴需要跳转的外部 URL。如图 `https://docs.<<<custom_key.brand_main_domain>>>/scene/visual-chart/chart-link/`；    
3. 选择打开方式为“侧滑页”；
4. 确定。     

<img src="../../img/chart_link_use_case_for_other_url.png" width="60%" >


### 步骤二：链接跳转验证

1. 链接添加完成后，在图表中选中某一时间点；
2. 点击配置的 “help docs” 链接；
3. 侧滑打开目标链接。


<img src="../../img/chart_link_use_case_for_other_url_1.png" width="60%" >
