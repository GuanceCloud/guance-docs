# 告警策略：更精细化的通知对象配置
---


## 优化告警规则配置

为了应对复杂多变的监控环境，更灵活地进行异常事件的告警，告警策略新增了【过滤】功能，在进行告警规则配置时，【过滤】功能允许在原有等级基础上增加更细致的过滤条件，仅匹配等级+过滤条件的事件才会发送给对应的通知对象。

![](img/alert-strategy.png)

## 告警规则配置


### 初见【过滤】功能


点击通知对象右侧的【+】号，即可弹出过滤条件输入框。

过滤规则：

1. 点击过滤后，可自动获取当前工作空间字段列出，`key:value` 匹配支持等于、不等于、通配和通配取反；

2. 每条告警规则下仅能添加一组过滤条件，一组条件中可包含一条/多条过滤规则，过滤规则相结合进行条件的筛选。

过滤规则为 `key:value` 值匹配进行过滤，相同 `key` 字段的多个过滤条件之间为 OR 的关系，不同 `key` 字段的过滤条件之间为 AND 的关系。

![](img/alert-strategy-1.png)

### 配置告警规则

【过滤】功能在通知配置中生效，可应用于自定义通知时间配置、普通配置。

#### 常规通知配置
   
**场景**：全部事件适用统一通知规则时使用，可直接在【通知配置】中进行规则的配置。  

- 选择事件等级后，点击通知对象右侧的【+】号，在弹出的过滤条件框中输入过滤条件。  

- 只有同时满足等级和过滤条件的事件才会发送给对应的通知对象。

![](img/alert-strategy-2.png)

#### 自定义通知配置
   
**场景**：特定时间内触发的事件需对特定的成员进行告警，可点击【自定义通知时间】进行配置。  

- 在【自定义通知配置】中进行周期、时间等必要配置，选择事件等级，点击通知对象右侧的【+】号，在弹出的过滤条件输入框中配置过滤条件。    
- 在【其他时刻】配置域中选择好等级，点击通知对象右侧的【+】号，在弹出的过滤条件输入框中配置过滤条件。  

![](img/alert-strategy-3.png)

**效果**：

配置了自定义通知时间的告警策略，在监控器触发事件后，会先进行触发时间的判断，根据事件触发时间是否在自定义通知配置的周期、时间内，进行【自定义通知配置】或者【其他时刻】的规则判断。后续会对事件进行等级、过滤条件的规则检测，只有同时满足规则中配置的等级和过滤条件的事件，才会发送给对应的通知对象。

### 其他应用场景

过滤条件和等级结合，共同作为检测规则项对事件进行判断，从而匹配通知对象。

#### 等级全选

**场景**：若监控器触发的事件，不管等级如何，只要事件的 `key:value` 值匹配，就要向特定的人进行告警。

**操作**：可在等级处选择【全部】，点击【+】号进行过滤条件处进行规则的填充。配置后，异常事件只会进行过滤条件的检测。

![](img/alert-strategy-4.png)

#### 同一等级可配置多组通知规则

事件等级选择的次数限制放开，同一等级可以在多组通知规则中进行选取配置。

**场景**：若监控器触发了多个同等级事件，带有不同属性的事件需要向不同的对象进行告警。

**操作**：可配置多个通知规则，多个规则选择一样的等级，分别配置不同的过滤条件。选取通知对象后，就可以根据属性值向对应的人员发送告警。

![](img/alert-strategy-5.png)

## 通知对象支持自定义外部邮箱

为了便于更好地处理问题，系统支持将异常告警发送给外部成员，您可直接点击通知对象输入域，自行输入自定义外部邮箱。

应用范围：

1. 新建告警策略，手动输入通知对象；
2. 新建监控器，编辑事件详情中@添加。

**注意**：此功能仅针对 SAAS 商业版和部署版。
