# 数据访问
---

日志、RUM、APM 和指标等数据中可能包含敏感信息，因此出于安全考虑，即便是在同一业务组织内，也需要对数据访问权限进行细致划分。观测云的**数据访问**功能，首先基于不同来源的索引，为目标访问者设定了[成员角色](../management/role-list.md)级别的数据访问范围。此外，为了进一步保护数据，还可以利用正则表达式和脱敏字段等工具，在限制访问的基础上对数据进行必要的"再编辑"，确保敏感信息在不牺牲数据价值的前提下得到妥善处理。
    


在**管理 > 数据访问**页面，借助以下两种方式可开始创建新规则：

:material-numeric-1-circle: 点击页面左上方**新建规则**按钮，即可开始创建；

:material-numeric-2-circle: 若当前页面存在历史访问规则，点击该规则右侧操作下的 :octicons-copy-24: 图标，可以克隆已有规则再创建。


## 开始配置

<img src="../img/data-2.png" width="80%" >

1. 选择数据类型；
2. 定义当前规则的名称；
3. 输入当前规则的描述；
4. 针对您选择的数据类型，选择对应的[**索引**](../logs/multi-index/index.md)、服务、应用和指标；

5. 定义当前规则下，数据的[访问范围](#scope)；

6. 添加需要脱敏的单个或多个字段；

7. 利用正则表达式针对字段内容中的敏感信息进行脱敏；

8. 选定当前访问规则可应用到的单个或多个成员角色，包含系统内默认角色及自建角色；
9. 点击保存。


## 配置须知 {#config}   

### 数据访问范围定义 {#scope}

**数据范围**：在访问规则内的成员只能查看与筛选条件匹配的数据。

不同字段之间的逻辑关系可以自定义选择 **任意(OR)** 或 **所有(AND)**；

- 默认选中 **所有(AND)**，支持切换为**任意(OR)**：

- 逻辑关系示例参考如下：
    
    - 示例 1：（默认 AND）
    
        - host=[host1,host2] AND service = [service1,service2]；
    
    - 示例 2：（切换为任意 OR）

        - host=[host1,host2] OR service = [service1,service2]。
        
- 支持通过 `标签/属性` 进行值的筛选，包括正向筛选、反向筛选、模糊匹配、反向模糊匹配、存在和不存在等多种筛选方式。


### 正则表达式脱敏 {#regex}

在设置访问规则时，尽管已定义数据范围，但仍需额外措施防止敏感或非必要信息泄露。此时，可利用**脱敏字段**或**正则表达式**对数据进行进一步处理，以加强数据保护。

在配置页面，除了直接添加单个的脱敏字段外，如需针对日志 `message` 里的某部分内容进一步作脱敏处理，如不显示 token 或 IP 信息，则可以通过添加正则表达式来满足这一需求。

1. 支持配置多个正则表达式，一个访问规则下最多配置 10 个表达式；
2. 支持禁用、启用某个正则表达式，后续应用和预览仅根据启用的正则表达式适配脱敏；
3. 支持直接在此处编辑、删除某个正则表达式；
4. 支持通过拖拽移动正则表达式位置，数据匹配到此脱敏规则时按照从上到下的顺序应用正则表达式做脱敏处理；
5. 支持在此处直接新建正则表达式：

<img src="../img/data-3.png" width="50%" >


在弹出的窗口中，[输入所需信息](../management/regex.md#diy)。

<img src="../img/data-4.png" width="60%" >

若勾选**应用到规则**，则该条规则会直接被添加至正则表达式下方。

<img src="../img/data-5.png" width="50%" >


### 角色场景与查询权限 {#role_permission}

![](img/data-access-map.png)


#### 简单情况

假设某个成员仅担任一种角色，如 `read-only`，则选中该角色后，系统会仅针对配置的这一角色做查看脱敏。

其中，若选择 “全部” 这一角色，则除 Owner 以外的所有角色都会受到脱敏影响。

<img src="../img/data-9.png" width="60%" >


**注意**：

1. 默认角色未配置数据访问规则时，拥有所有数据的查询权限；
2. 基于**用户角色存在数据查询权限**的基础，数据访问的规则才能生效；
3. 角色匹配规则后，您只能在规则配置的基础范围内继续添加筛选，若超出此范围查询，则返回数据为空。

#### 多角色权限覆盖

若某成员存在多个角色（如下），且每个角色查询权限覆盖范围有差异，最终该成员的数据查询权限**采用角色下的最高权限**。

<img src="../img/logdata_8.png" width="60%" >
    

#### 多规则权限控制

在业务数据复杂且层级繁多的情况下，针对具有不同来源和属性的数据，我们需要设定多条访问规则以适应不同的数据访问需求。

1. 一个规则多个筛选之间关系：同 key 的多个值关系是 OR，不同 key 之间的关系是 AND；  
2. 多个规则之间关系为 OR。  
    
所以，如果：

规则 1：host = [主机1,主机2] AND service = [服务1,服务2]   
规则 2：host = [主机3,主机4] AND source = [来源1,来源2]  

同一角色<u>同时拥有以上两条权限规则</u>，那么实际数据会显示 `规则1 OR 规则2` 来达到并集效果。

实际可以看到数据范围是：  
    
`（host = [主机1,主机2] AND service = [服务1,服务2]）OR （host = [主机3,主机4] AND source = [来源1,来源2]）`

若同一角色拥有多条权限规则，且其中规则 1 内配置有脱敏规则，那么所有权限规则下返回的所有数据都会受到脱敏规则影响。


## 配置示例

1. 选择本工作空间的索引 `rp70`；
2. 设置数据范围为 `host:cn-hangzhou.172.**.**` 及 `service:kodo`；
3. 此处我们不设置脱敏字段，直接编写正则表达式 `tkn_[\da-z]*`，表示对 `token` 信息进行加密；
4. 最后直接将当前访问规则赋予当前工作空间内的所有 `Read-only` 成员。 
5. 点击保存。若需要，可点击左下方**预览**，查看脱敏效果。

<img src="../img/data-6.png" width="80%" >

以上访问规则面向当前工作空间内的所有 `Read-only` 成员，只能访问日志索引为 `rp70` 下，`host:cn-hangzhou.172.**.**` 及 `service:kodo` 的数据，且在这类数据中，无法可见所有 `token` 的信息。




## 应用场景 {#snapshot}      

基于已经生效的数据访问规则，被规则命中的成员接收到的快照数据将自动根据其权限规则进行筛选。即使[快照](../getting-started/function-details/snapshot.md)中包含的数据超出了成员的访问权限，系统也会先行过滤，最终成员只能查看符合其访问规则的数据。


## 管理列表 {#list}

1. 查看：在数据访问规则列表，可直接查看该条规则关联的索引、数据查询条件、是否脱敏以及关联的角色数量与角色对应成员数量等信息。

2. 仅显示跟我相关的规则：

    - 系统默认“关闭”，即默认状态下，该列表会显示所有数据访问规则；

    - 启用这一按钮后，该列表仅显示与当前账号角色关联的数据访问规则。

3. 启用/禁用规则：修改数据访问规则状态。规则被禁用后，不同角色对数据的访问查询范围不受限制，规则启用后恢复。

4. 点击编辑按钮，可修改当前规则的名称、描述、绑定的索引、筛选条件及授权角色等设置。
5. 点击克隆按钮，即可快速复制当前规则。
6. 操作审计：即与该条规则的相关操作记录。
7. 点击删除按钮，即可删除该条规则。
8. 可批量启用、禁用和删除多条规则。

