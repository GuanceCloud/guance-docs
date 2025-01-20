# Elasticsearch 索引绑定  {#es}

选择 **Elasticsearch**，填写所需信息。填写完成后，可点击**测试**用户名和密码的正确性。

**注意**：仅支持绑定 Elasticsearch 7.0+ 及以上版本。

:material-numeric-1-circle-outline: 账号授权

1. 域名：Elasticsearch 的用户访问地址，请确保在公共网络上可以访问。  
2. 用户名：访问 Elasticsearch 时的用户名字。 
3. 密码：访问 Elasticsearch 时需要的密码。 

:material-numeric-2-circle-outline: 资源授权

1. Elasticsearch Index：Elasticsearch 中需要绑定查看的索引名称。 
2. 观测云 Index：观测云工作空间唯一标识的索引名称，由用户自定义填写，且不支持重复的名字，配置完成后，可用于筛选索引名称。
    - **注意**：该索引名称与 Elasticsearch 无关，仅用于您后续在观测云中的数据筛选。 

:material-numeric-3-circle-outline: [字段映射](./index.md#mapping)。                 



:material-numeric-4-circle-outline: 点击**确定**，即可完成索引绑定，您可以在**查看器**通过切换索引进行查看。


## 更多阅读


<font size=2>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **字段映射**</font>](./index.md#mapping)

</div>


</font>