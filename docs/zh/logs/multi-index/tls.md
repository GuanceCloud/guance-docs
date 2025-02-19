# 火山引擎 TLS 索引绑定 
---

选择 **火山引擎 TLS**，填写所需信息。填写完成后，可点击**测试**用户名和密码的正确性。

:material-numeric-1-circle-outline: 账号授权：

1. [获取 TLS 授权文件](../authorize-tls.md).
2. 填写 AccessKey ID / AccessKey Secret （简称 AK / AKS）。

:material-numeric-2-circle-outline: 资源授权：

1. 选择所在地区；
2. 根据上面填写的 AK / AKS，{{{ custom_key.brand_name }}}自动获取 Project、日志项目和日志主题。
3. {{{ custom_key.brand_name }}} Index：默认与 TLS 的名称保持一致，您也可以自定义编辑名称。
    - **注意**：该索引名称与 TLS 无关，用于您后续在{{{ custom_key.brand_name }}}中的数据筛选。
4. 访问类型：为避免配置路径错误，从而出现获取不到数据的问题，此处可根据实际情况选择**内网访问**或**公网访问**。


:material-numeric-3-circle-outline: [字段映射](./index.md#mapping)。    

:material-numeric-4-circle-outline: 点击**确定**，即可完成索引绑定，您可以在**查看器**通过切换索引进行查看。

## 更多阅读


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **获取 TLS 授权文件**</font>](../authorize-tls.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **字段映射**</font>](./index.md#mapping)

</div>


</font>