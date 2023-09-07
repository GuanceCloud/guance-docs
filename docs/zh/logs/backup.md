# 数据转发
---


???+ quote "更新日志"

    **2023.9.7**：原【备份日志】正式更名为【数据转发】。

观测云提供日志、链路和用户访问数据转发到外部存储的功能，您可以自由选择外部存储对象，灵活管理数据转发数据。

## 前提条件

观测云商业版用户可使用数据转发功能，[体验版](../billing/trail.md)用户需先[升级商业版](../billing/commercial-version.md)。

## 新建备份

进入**日志 > 数据转发**页面，点击**转发规则 > 新建规则**。

![](img/5.log_backup_1.png)

![](img/back-5.png)

**注意**：数据转发规则创建完成后，每 5 分钟执行一次规则校验。  


### 输入规则名称

在弹出的对话框，输入**规则名称**即可添加一条新的规则，

| 字段      | 描述     | 
| ------------- | -------------- |
| 规则名称 | 限制最多输入 30 个字符。 |
| 同步备份扩展字段      | 默认仅备份 message 内容到数据转发，若勾选此选项，将备份符合筛选条件的整条日志数据。<br/>:warning: 若创建多个数据转发规则，则优先匹配勾选同步备份扩展字段的规则，即若不同的规则命中同一条数据，则优先按照同步备份扩展字段的逻辑展示整条日志数据。     |

### 定义过滤条件

:material-numeric-1-circle-outline: 数据源：日志、链路、用户访问

:material-numeric-2-circle-outline: 过滤条件：支持自定义条件间的运算逻辑，您可以选择**所有条件**、**任意条件**：

- 所有条件：匹配所有过滤条件都满足的日志数据才会被保存到数据转发；

- 任意条件：任意一个过滤条件满足即可被保存到数据转发。

**注意**：不添加过滤条件即表示保存全部日志数据；您可以添加多条过滤条件。

条件运算符见下表：

| 条件运算符      | 匹配类型     | 
| ------------- | -------------- | 
| in 、not in      | 精确匹配，支持多值（逗号隔开） | 
| match、not match | 模糊匹配，支持输入正则语法 | 

![](img/back-1.png)

### 选择存档类型

为提供更加全面的数据转发存储方式，观测云支持以下四种存储路径：

**注意**：四种存档类型全站点开放。

<img src="../img/back-4.png" width="70%" >




#### AWS S3 {#aws}


![](img/s3-0725.png)

1、存档类型选择 **AWS S3**，即表示将匹配到的日志数据保存到 S3 对象存储中；   
2、选择访问类型： 

=== "角色授权"

    ![](img/back-2.png)

    您需使用观测云默认生成的外部 ID 配置 AWS 资源第三方访问权。
    
    [在 AWS 中配置观测云 IAM 角色](./role-auth.md)后，填写存档信息，填入 AWS 账号 ID、AWS 角色名称、地区及 Bucket 名称。

    点击**测试连接**，若上述信息满足规范，则提示测试连接成功；
    
    若未通过测试，您需确认：

    - 外部 ID 是否失效；  
    - 账号 ID 是否正确；  
    - 账号角色是否存在；  
    - 存储桶是否存在；  
    - Region 是否不一致。  

    <font color=coral>**当出现这种情况时，需谨慎操作：**</font>
    
    - 若您点击重新生成外部 ID，历史 ID 将于 24 小时后失效，请尽快前往 AWS 控制台替换；  
    
    - 不要多次点击生成外部 ID，请谨慎操作！

=== "Access Keys"

    ![](img/back-3.png)

    点击下载 AWS 资源授权模板，[前往 AWS 中配置观测云 IAM 策略](./ak-auth.md)。

    配置完成后，填写账号信息，输入 AWS 账号 ID、AWS AK & SK 、地区及 Bucket 名称。

    点击**测试连接**，若上述信息满足规范，则提示测试连接成功；
    
    若未通过测试，您需确认：

    - 账号 ID 是否正确；  
    - AK / SK 是否存在；  
    - 存储桶是否存在；  
    - Region 是否不一致。  


3、点击**确定**，即可创建成功。

**注意**：若存档类型信息有变动，将弹出确认框，进行创建规则的二次确定。

<img src="../img/back-7.png" width="60%" >

#### 华为云 OBS {#obs}


1、存档类型选择**华为云 OBS**，即表示将匹配到规则的日志自动备份到外部 OBS；

![](img/back-8.png)

2、在**配置华为云资源访问授权**，须使用观测云为您提供的专属华为云账号 ID `f000ee4d7327428da2f53a081e7109bd`，[前往添加跨账号访问授权策略](./obs-config.md)；

3、选择地区；

4、在**存储桶**，输入您在华为云的桶名称；

5、点击**确定**，即可创建成功。

#### 阿里云 OSS {#oss}

???+ attention "配置须知"

    备份到外部存储（OSS）的数据目前暂不支持在数据转发查看器中查询分析。为避免产生额外的流量开销，当前仅支持与观测云站点同 Region 的外部存储数据写入。

    - 中国区1（杭州）：cn-hangzhou   
    - 中国区3（张家口）：cn-zhangjiakou   

1、存档类型选择 **阿里云 OSS**，即表示将匹配到的日志数据保存到 OSS 对象存储中；   
2、选择访问类型： 

=== "角色授权"

    ![](img/oss-1.png)

    您需使用观测云默认生成的外部 ID 配置角色授权使用。
    
    [在阿里云配置台配置授权角色](./aliyun-account.md)后，填写存档信息，填入阿里云账号 ID、OSS 角色名称、地区及 Bucket 名称。

    点击**测试连接**，若上述信息满足规范，则提示测试连接成功；
    
    若未通过测试，您需确认：

    - 授权是否成功；  
    - 账号 ID 是否正确；   
    - 存储桶是否存在；  
    - Region 是否不一致。  

    <font color=coral>**当出现这种情况时，需谨慎操作：**</font>
    
    - 若您点击重新生成外部 ID，历史 ID 将于 24 小时后失效，请尽快前往阿里云控制台替换；  
    
    - 不要多次点击生成外部 ID，请谨慎操作！

=== "Access Keys"

    ![](img/oss-2.png)

    您需在阿里云中[配置观测云 RAM 策略](./aliyun-ram.md)。配置完成后，填写账号信息，输入阿里云账号 ID、阿里云 AK & SK 、地区及 Bucket 名称。

    点击**测试连接**，若上述信息满足规范，则提示测试连接成功；
    
    若未通过测试，您需确认：

    - 账号 ID 是否正确；  
    - AK / SK 是否存在；  
    - 存储桶是否存在；  
    - Region 是否不一致。  

3、点击**确定**，即可创建成功。

**注意**：若存档类型信息有变动，将弹出确认框，进行创建规则的二次确定。

<img src="../img/back-7.png" width="60%" >

#### Kafka 消息队列 {#kafka}


![](img/kafka.png)

1、地址：Host:Port，多个节点使用逗号间隔。

2、消息主题：即 Topic 名称。

3、安全协议：

在 Kafka 侧，SASL 可以使用 PLAINTEXT 或者 SSL 协议作为传输层，相对应的就是使用 SASL_PLAINTEXT 或者 SASL_SSL 安全协议。如果使用 SASL_SSL 安全协议，必须配置 SSL 证书。

=== "PLAINTEXT"

    无需任何安全校验，可直接测试连接。

=== "SASL_PLAINTEXT"

    认证方式默认为 PLAIN，可选 SCRAM-SHA-256 与 SCRAM-SHA-512 两种。

    输入在 Kafka 侧执行安全认证的 username/password，再测试连接。

    ![](img/kafka-1.png)

=== "SASL_SSL"

    此处[需上传 SSL 证书](https://kafka.apachecn.org/documentation.html#security_ssl)。

    认证方式默认为 PLAIN，可选 SCRAM-SHA-256 与 SCRAM-SHA-512 两种。

    输入在 Kafka 侧执行安全认证的 username/password，再测试连接。

    ![](img/kafka-2.png)

点击**测试连接**，若上述信息满足规范，则提示测试连接成功；
    
若未通过测试，您需确认：

- 地址是否正确；  
- 消息主题名称是否正确；  
- SSL 证书是否正确；  
- 用户名是否正确；  
- 密码是否正确。

4、点击**确定**，即可创建成功。


## 相关操作

### 查看数据转发

进入**日志 > 数据转发**页面，即可查看符合备份条件的日志数据。

- [时间控件](../getting-started/function-details/explorer-search.md#time) ：通过选择时间范围筛选查看数据转发；
- [搜索和筛选](../getting-started/function-details/explorer-search.md#search) ：通过搜索关键字或者筛选字段的方式查看和分析数据转发；
- 数据转发详情：点击任意一条日志可查看日志的详情，包括日志产生的时间、内容和扩展字段。

<!--
- [显示列](../getting-started/function-details/explorer-search.md#columns) ：在创建数据转发规则时：

    若勾选**同步备份扩展字段**，可自定义添加除了日志产生的时间和内容以外的字段，见下图：

    ![](img/5.log_backup_6.png)

    在创建数据转发规则时，若不勾选**同步备份扩展字段**，则数据转发仅保存日志数据的时间和内容，见下图：

    ![](img/5.log_backup_5.png)
-->



数据转发规则创建以后，统一存储在日志索引下的**数据转发**。规则创建后，您可以查看、编辑、删除。

### 查看、编辑、删除

点击规则右侧 :material-text-search: 、编辑、 :fontawesome-regular-trash-can: 按钮，即可进行相应操作。

**注意**：若需要修改创建的备份规则，可删除规则后再创建新的备份规则。规则删除后已备份的数据不会被删除，但不再产生新的数据转发数据。

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 数据转发计费逻辑</font>](../billing/billing-method/billing-item.md#backup)
- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 日志数据备份到 OSS 最佳实践</font>](../best-practices/partner/log-backup-to-oss-by-func.md)

</div>
