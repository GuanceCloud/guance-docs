# 告警聚合通知模板

## 标题

> 您有 {{N}} 条{{等级}}告警通知


## 内容

### 不聚合

> 您有 N 条新的观测云告警
>
> 第 1 / 2 条：
>
> 标题
>
> 内容
>
> <font color=#2F61CC> 前往工作空间查看 </font>
>
> ---
>
> 第 2 / 2 条：
>
> 标题
>
> 内容
>
> <font color=#2F61CC> 前往工作空间查看 </font>


- 前往工作空间查看：即跳转至事件查看器查看当前事件（筛选条件：`df_event_id`）

*示意图：*

<img src="../img/alert-template.png" width="70%" >

### 规则聚合

#### 全部

> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> 关联检测规则：
>
> - {{事件标题}} <font color=#2F61CC> >>查看  </font>

- 查看：跳转至查看器查看当前监控器在聚合周期内产生的所有事件（筛选条件：     `df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-1.png" width="70%" >

#### 检测规则 - 监控器

> 检测类型：监控器
>
> 检测规则名称：{{主机}} CPU 超 {{Result}}%
>
> 检测规则 ID：rule_cdbkjcbsdjcb1234445455
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> <font color=#2F61CC> 前往工作空间查看 </font>

- 跳转至查看器查看当前监控器关联事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-2.png" width="70%" >


#### 检测规则 - 智能巡检

> 检测类型：智能巡检
>
> 检测规则名称：{{主机}} CPU 超 {{Result}}%
>
> 检测规则 ID：rule_cdbkjcbsdjcb1234445455
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> <font color=#2F61CC> 前往工作空间查看 </font>


- 跳转至查看器查看当前智能巡检规则关联事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-3.png" width="70%" >

#### 检测规则 - SLO

> 检测类型：SLO
>
> 检测规则名称：{{主机}} CPU 超 {{Result}}%
>
> 检测规则 ID：rule_cdbkjcbsdjcb1234445455
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> <font color=#2F61CC> 前往工作空间查看 </font>


- 跳转至查看器查看当前 SLO 关联事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-3.png" width="70%" >

#### 检测维度

> 检测维度：service:kodo,host:test
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> 关联检测规则：
>
> - {{事件标题}} <font color=#2F61CC> >>查看  </font>

<img src="../img/alert-template-4.png" width="70%" >

#### 标签

> 标签：service:kodo,host:test
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> 关联检测规则：
>
> - {{事件标题}} <font color=#2F61CC> >>查看  </font>

- 跳转至查看器查看当前检测规则关联事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-5.png" width="70%" >

### 智能聚合

#### 标题聚类

> 标题：{{主机}} CPU 超 {{Result}}%
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> 关联检测规则：
>
> - {{事件标题}} <font color=#2F61CC> >>查看  </font>

- 跳转至查看器查看当前检测规则在聚合周期内产生的所有事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-6.png" width="70%" >

#### 内容聚类

> 标题：{{主机}} CPU 超 {{Result}}%
>
> 关联事件：123
>
> 聚合周期：2023/11/20 10:00 ~ 2023/11/20 10:05
>
> 关联检测规则：
>
> - {{事件标题}} <font color=#2F61CC> >>查看  </font>

- 跳转至查看器查看当前检测规则在聚合周期内产生的所有事件（筛选条件：`df_monitor_checker_id`）

*示意图：*

<img src="../img/alert-template-7.png" width="70%" >