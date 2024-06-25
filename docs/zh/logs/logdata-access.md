# 数据访问
---


为使当前工作空间内不同[成员角色](../management/role-list.md)数据查询范围更精细，观测云支持在**数据访问**页面为不同角色配置对应的日志数据访问查询范围。同时，若当前工作空间被赋予了其他工作空间的数据查看权限，可在此页面针对这部分被授权查看的数据做访问控制。      

![](img/data_001.png)

## 配置规则 {#config}   

在**日志 > 数据访问**页面，借助以下两种方式可开始创建新规则：

1. 点击**新建规则**按钮，即可开始创建新的数据访问规则；

2. 点击 :octicons-copy-24: 图标，可以克隆已有规则创建新的规则。

在弹出的新建页面中，选择[**索引**](../logs/multi-index.md)，设置筛选条件，并决定授权的角色对象。


![](img/data-2.png)

:material-numeric-1-circle-outline: 索引：多选；当前工作空间内日志索引（包含日志默认索引、自定义索引、绑定的外部索引）以及[被授权的所有可查看索引](./cross-workspace-index.md)；

![](img/logdata_6.png)


:material-numeric-2-circle-outline: 数据范围：不同字段之间的逻辑关系可以自定义选择 **任意(OR)** 或 **所有(AND)**；

- 默认选中 **所有(AND)**，支持切换为**任意(OR)**：

- 逻辑关系示例参考如下：
    
    - 示例 1：（默认 AND）
    
        - host=[host1,host2] AND service = [service1,service2]；
    
    - 示例 2：（切换为任意 OR）

        - host=[host1,host2] OR service = [service1,service2]。
        
- 支持通过 `标签/属性` 进行值的筛选，包括正向筛选、反向筛选、模糊匹配、反向模糊匹配、存在和不存在等多种筛选方式。

:material-numeric-3-circle-outline: 脱敏字段：选择您需要脱敏的字段；支持多选；

:material-numeric-4-circle-outline: 正则表达式：

- 支持配置多个正则表达式，一个访问规则下最多配置 10 个表达式；
- 支持禁用、启用某个正则表达式，后续应用和预览仅根据启用的正则表达式适配脱敏；
- 支持直接在此处编辑、删除某个正则表达式；
- 支持通过拖拽移动正则表达式位置，数据匹配到此脱敏规则时按照从上到下的顺序应用正则表达式做脱敏处理

<img src="../img/data-3.png" width="50%" >

- 支持在此处直接新建正则表达式：

![](img/data-3.gif)

在弹出的窗口中，[输入所需信息](../management/regex.md#diy)。

<img src="../img/data-4.png" width="60%" >

若勾选**应用到规则**，则该条规则会直接被添加至正则表达式下方。

<img src="../img/data-5.png" width="50%" >

:material-numeric-5-circle-outline: 角色：多选；包含系统内默认角色及自建角色；选中后仅针对配置的角色做查看脱敏。

其中，若您选择 “全部” 这一角色，则除 Owner 以外的所有角色都会受到脱敏影响。

<img src="../img/data-9.png" width="60%" >

您可点击左下方**预览**，查看脱敏效果：

<img src="../img/data-6.png" width="60%" >

**注意**：

- 默认角色未配置数据访问规则时，拥有所有日志的数据查询权限；
- 基于**用户角色存在日志数据查询权限**的基础，日志数据访问的规则才能生效；
- 角色匹配规则后，您只能在规则配置的基础范围内继续添加筛选，若超出此范围查询，则返回数据为空。

???+ abstract "多角色数据查询权限"

    若某成员存在多个角色（如下），且个角色查询权限覆盖范围有差异，最终该成员的数据查询权限<u>采用角色下的最高权限</u>。

    <img src="../img/logdata_8.png" width="60%" >
    

???+ abstract "权限控制对应关系"

    1、一个规则多个筛选之间关系：同 key 的多个值关系是 OR，不同 key 之间的关系是 AND；  
    2、多个规则之间关系为 OR。  
    
    所以，如果：  
    规则 1：host = [主机1,主机2] AND service = [服务1,服务2]   
    规则 2：host = [主机3,主机4] AND source = [来源1,来源2]  

    用户<u>同时拥有以上两条权限规则</u>，那么实际数据会显示 `规则1 OR 规则2` 来达到并集效果。

    实际可以看到数据范围是：  
    
    `（host = [主机1,主机2] AND service = [服务1,服务2]）OR （host = [主机3,主机4] AND source = [来源1,来源2]）`

    若用户拥有多条权限规则，且其中规则 1 内配置有脱敏规则，那么所有权限规则下返回的所有数据都会受到脱敏规则影响。

<!-- 
*示例：*

1、在**日志 > 索引**页面，新建名为 `tcp_dial_testing` 的索引，筛选过滤条件 `source` 为 `tcp_dial_testing` 的日志数据，并设置数据存储天数为7天。     

![](img/logdata_5.png)

2、回到**数据访问**页面，点击**新建规则**，选择索引 `tcp_dial_testing`，设置筛选条件 `status` 为 `OK`，并选择拥有该日志数据查询的角色。

![](img/logdata_4.png)

3、创建完成后，即可查看该索引下数据访问权限关联的角色数量以及角色下对应的成员数量。


-->




### 快照分享 {#snapshot}      

基于日志数据访问权限的支持，您可以将当前规则下过滤产生的数据作为 **[快照](../getting-started/function-details/snapshot.md)** 进行保存。快照分享后，被分享对象可以在快照页面上方搜索栏查看该数据列表的筛选条件，可以添加搜索条件，从而达到当前快照下的数据更加准确的数据分享效果。  

![](img/logdatasnapshot.png)


## 列表操作 {#list}

:material-numeric-1-circle-outline: 查看

规则配置完成后，可查看该条规则是否脱敏以及关联的角色数量与角色对应成员数量.

![](img/logdata_2.png)

若当前规则配置了脱敏字段和正则表达式，Hover 还可直接在列表显示对应规则内配置的脱敏字段和正则表达式以及正则表达式的启用、禁用状态：

![](img/data-7.png)

【仅显示跟我相关的规则】：

- 默认“关闭”，即显示所有数据访问规则列表；

- 设置【仅显示跟我相关的规则】，仅显示与当前账号角色关联的数据访问规则。

![](img/log-acc01.png)

:material-numeric-2-circle-outline: 修改

点击规则右侧**修改**图标，可修改规则下的索引、筛选条件及授权角色等设置：

![](img/logdata_1.png)

:material-numeric-3-circle-outline: 删除

点击规则右侧 :fontawesome-regular-trash-can: 图标，点击**确认**，即可删除该条规则：
  
![](img/logdata_3.png)

:material-numeric-4-circle-outline: 启用/禁用规则

点击**启用/禁用**开关，可以修改数据访问规则状态，规则禁用后，不同角色对日志数据访问查询范围不受限制，规则启用后恢复。

:material-numeric-5-circle-outline: 批量操作

可以针对特定规则进行批量操作，包括启用、禁用和删除规则。

![](img/logdata_001.png)