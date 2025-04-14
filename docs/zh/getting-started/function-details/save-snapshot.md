# 保存快照
---


## 保存入口

进入想要保存快照的页面，调整右上角时间控件、并过滤出需要保存的数据后，使用如下方法即可弹出**保存快照**窗口。

<div class="grid" markdown>

=== ":material-numeric-1-circle:快捷键"

    :fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

    :fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

    ???+ warning "注意"

        您的后台程序存在的快捷键与如上快捷键冲突时，将无法使用**保存快照**的快捷键功能。

    ---

=== ":material-numeric-2-circle:查看器"
        
    查看器 > 顶部快照按钮（搜索框左侧）：

    <img src="../../img/snapshot_explorer.png" width="80%" >

    ---

=== ":material-numeric-3-circle:仪表板"

    查看器 > 顶部设置按钮：

    <img src="../../img/snapshot_dashboard.png" width="80%" >

    ---

</div>


## 开始保存 {#begin-save-snapshot}

成功弹出**保存快照**窗口后，即可对该条快照进行相关设置。


1. 定义快照名称；
2. 设置可见范围：
    - 公开：当前工作空间的用户，都可以查看该条快照；
    - 仅自己可见：其他用户权限查看该条快照。                     
3. 自动获取当前页面上选取的时间范围；可在此处调整时间范围。                    

## 查看快照 {#check}

您可以在以下入口查看已经保存的快照：

<div class="grid" markdown>

=== ":material-numeric-1-circle: 在快照菜单查看"

    **工作空间 > 快捷入口> 快照**菜单，可查看当前工作空间保存的所有快照。

    <img src="../../img/snapshot_in_bar.png" width="50%" >

    ---

=== ":material-numeric-2-circle: 在查看器页面查看" 

    进入**查看器 > 快照**，系统会显示该查看器保存的快照。快照仅在保存时的查看器中可见。例如，在日志查看器保存的快照，无法在 RUM 链路查看器中查看；  

    - Hover 至历史快照，显示快照的时间范围和筛选条件。时间范围分为以下三种：

        - 绝对时间：固定的时间区间。
        - 相对时间：基于当前时间的动态区间。
        - 默认：系统默认的时间设置。

    ![](../img/snapshot_in_explorer.png)

    ---

=== ":material-numeric-3-circle: 在仪表板页面查看"

    进入**场景 > 仪表板**，在页面右上方**历史快照**处可查看当前工作空间保存的所有仪表板快照。

    <img src="../../img/snapshot_in_dashboard.png" width="80%" >


## 管理快照

针对已保存的快照，您可进行以下操作：

<img src="../../img/manag_snapshot.png" width="60%" >

- 在搜索栏中，输入快照名称即可通过关键词进行模糊匹配；       
- 在快照右侧，您可以选择以下操作：  
    - **分享/删除快照**：管理快照的可见性或删除不再需要的快照。    
    - **复制快照链接**：获取快照的直接链接，便于快速分享或引用。      
- 点击**快照名称**，即可打开对应的数据副本，并复现快照保存时的数据标签。       
- 如果在保存快照时，将可见范围设置为[**仅自己可见**](#begin-save-snapshot)，快照名称后面会显示 :material-lock: 图标，其他人将无法查看该快照。    