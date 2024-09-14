# OpenSearch 索引绑定  {#opensearch}

选择 **OpenSearch**，填写所需信息。填写完成后，可点击**测试**用户名和密码的正确性。

**注意**：仅支持绑定 OpenSearch 1.0.x 及以上版本。

:material-numeric-1-circle-outline: 账号授权

1. 域名：OpenSearch 的用户访问地址，请确保在公共网络上可以访问。  
2. 用户名：访问 OpenSearch 时的用户名字。 
3. 密码：访问 OpenSearch 时需要的密码。 

:material-numeric-2-circle-outline: 资源授权

1. OpenSearch Index：OpenSearch 中需要绑定查看的索引名称。 
2. 观测云 Index：观测云工作空间唯一标识的索引名称，由用户自定义填写，且不支持重复的名字，配置完成后，可用于筛选索引名称。
    - **注意**：该索引名称与 OpenSearch 无关，仅用于您后续在观测云中的数据筛选。 

:material-numeric-3-circle-outline: [字段映射](./index.md#mapping)。      

:material-numeric-4-circle-outline: 点击**确定**，即可完成索引绑定，您可以在**查看器**通过切换索引进行查看。

## Elasticsearch/OpenSearch 绑定外部索引配置说明 {#add-up}

由于 Elasticsearch/OpenSearch 的 `index` 存在因滚动策略导致某个 `index` 产生多个索引规则或名称，本配置说明**主要介绍当您需要查询当前 `index` 下所有数据或查询当前 `index` 下某个索引对应数据，如何在观测云进行配置**。

### 索引、别名和分片

- 索引别名是用于引用一个或多个现有索引的辅助名称；  
- 一个别名可以绑定多个索引，一个索引也可以绑定多个别名。

<img src="../../img/2.index_out_1.png" width="70%" >

如上图所示 index 1 这个索引中共有 2 个分片，如果用户需要查询的是 index 1 中的日志内容，在观测云中只需绑定 index name 为 index 1 的索引即可，对于分片数量及大小无任何感知。

### 索引滚动

![](../img/2.index_out_2.jpg)

如上图所示是以 ES 按照每天一个滚动索引的规则为例，`Log-1` 是这些索引的别名，Log-1 - 2022/10/01 等是 index name。

- 如果需要在观测云中绑定所有索引，则需要绑定这个索引别名，参考如下示例：

![](../img/3.log_index_4.png)

- 如果需要在观测云中绑定其中的某个索引，或者配置中没有滚动策略，则只需要绑定具体 index name，参考如下示例：

![](../img/3.log_index_5.png)

## 更多阅读


<font size=3>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **字段映射**</font>](./index.md#mapping)

</div>


</font>