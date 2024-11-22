# SLS Logstore 索引绑定 {#sls}

选择 **SLS Logstore**。观测云支持 [RAM 子账号授权](#ram)和[第三方快捷授权](#third-party)两种授权方式：

## RAM 子账号授权 {#ram}

<img src="../../img/sls-index.png" width="60%" >

:material-numeric-1-circle-outline: 账号授权：

1. [获取 SLS 授权文件](../../plans/sls-grant.md).
2. 填写 AccessKey ID / AccessKey Secret （简称 AK / AKS）。

:material-numeric-2-circle-outline: 资源授权：

1. 选择所在地区；
2. 根据上面填写的 AK / AKS，观测云自动获取 Project 和 Logstore。 
3. 观测云 Index：默认与 Logstore 的名称保持一致，您也可以自定义编辑名称。
    - **注意**：该索引名称与 SLS 无关，用于您后续在观测云中的数据筛选。
4. 访问类型：为避免配置路径错误，从而出现获取不到数据的问题，此处可根据实际情况选择**内网访问**或**公网访问**。


:material-numeric-3-circle-outline: [字段映射](./index.md#mapping)。    

:material-numeric-4-circle-outline: 点击**确定**，即可完成索引绑定，您可以在**查看器**通过切换索引进行查看。

???- warning "针对商业版与专属版"

    - 若您是观测云商业版用户，您可以参考文档 [RAM 账号授权](../../plans/sls-grant.md)，获取 AK / AKS 进行索引绑定；       
    - 若您是观测云专属版用户，您可以直接使用开通专属版时的 AK / AKS 进行索引绑定，关于如何开通专属版，可参考 [阿里云市场开通观测云专属版](../../plans/commercial-aliyun-sls.md)；     
    - 若您是观测云专属版用户，且希望绑定其他阿里云账号下的 SLS 日志索引，可参考 [RAM 账号授权](../../plans/sls-grant.md)，获取 AK / AKS 进行索引绑定。


## 第三方快捷授权 {#third-party}

**注意**：中国香港及海外站点不支持此项功能。

<img src="../../img/sls-index-1.png" width="60%" >

:material-numeric-1-circle-outline: 账号授权：

点击 **[立即前往](https://market.console.aliyun.com/auth?role=VendorCrossAccountGUANCEREADONLYRole&token=fe4be994690698821d5f581475e3b441)**，即可跳转至阿里云，登录后进行授权操作。   

![](../img/index-1.png)

点击**同意授权**，弹出**服务商 UID 校验**窗口，UID 获取可点击**服务商权限说明页面**查看。输入 UID 后点击确定，自动跳转前往**阿里云云市场 > 已购买的服务**，此时已授权完成。

![](../img/index-2.png)


:material-numeric-2-circle-outline: 资源授权：

1. 授权完成后，填写您的阿里云账号 ID。填写完成后，观测云会自动获取 Project 和 Logstore。  

2. 观测云 Index：默认与 Logstore 的名称保持一致，您也可以自定义编辑名称。   

    - **注意**：该索引名称与 SLS 无关，用于您后续在观测云中的数据筛选。

3. 访问类型：为避免配置路径错误，从而出现获取不到数据的问题，此处可根据实际情况选择**内网访问**或**公网访问**。

<img src="../../img/index-3.png" width="70%" >

:material-numeric-3-circle-outline: [字段映射](./index.md#mapping)。                 



:material-numeric-4-circle-outline: 点击**确定**，即可完成索引绑定，您可以在**查看器**通过切换索引进行查看。


???+ warning "注意"

    1. 操作跨账号角色授权需**使用阿里云主账号或授权了 RAM 访问控制 GetRole、GetPolicy、CreatePolicy、CreatePolicyVersion、CreateRole、UpdateRole、AttachPolicyToRole 权限**的子账号；

    2. 在验证过程中，如果验证的是被授权的子账号，会自动定位到该子账号所属的主账号，拉取主账号下的 Project 和 Logstore。




## 更多阅读


<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **绑定时如何确认在阿里云市场授权成功？**</font>](../faq.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **获取 SLS 授权文件**</font>](../../plans/sls-grant.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **字段映射**</font>](./index.md#mapping)

</div>


</font>