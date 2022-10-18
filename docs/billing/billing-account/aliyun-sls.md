#  SLS 存储
---


观测云产品的存储方案新增 SLS 存储，支持阿里云 SLS 用户能够快速使用观测云进行数据查看分析。

本文将介绍观测云商业版中，阿里云账号结算模式下，选择 SLS 存储方案操作流程。关于直接注册商业版，可参考文档 [注册商业版](../../billing/commercial-version.md) 。


## 一键注册商业版 SLS 存储流程

1. 在观测云商业版注册页面，按照注册步骤进入“选择账号结算”界面





2. 选择”阿里云账号结算“后，默认选择 “默认存储” 方式，支持选择 “SLS 存储” 方式





3. 当您选择默认存储方式时，点击下一步，直接跳转第四步开通成功

   

   

   

   当您选择 “SLS 存储方式” 时，点击下一步后，进入阿里云账号绑定页面。下载获取 SLS 授权文件。登录【阿里云】控制台，到 SLS 日志服务上传授权文件，创建RAM账号，获取该账号的AccessKey ID、AccessKey Secret信息。关于创建 RAM 用户具体操作，详情请看文档https://help.aliyun.com/document_detail/38738.html

   

   

   填写AccessKey ID、AccessKey Secret并进行验证，若验证通过，可以进行下一步；若验证未通过，提示【该AK无效，请重新填写】





​     4. 验证通过后显示用户服务协议，同意后提示【成功开通观测云商业版】。






## 阿里云一键开通商业版 SLS 存储流程

在您注册观测云企业账号或创建观测云工作空间时，可选择 默认存储 或 SLS 存储 两种方式。下文将对选择 SLS 存储方式的流程操作进行说明。

### 注册观测云企业账号

在观测云企业账号注册页面，填写信息注册成功后，需选择存储方式：默认存储、 SLS 存储

- 若您选择 默认存储 ，则直接跳转至成功开通页面



- 若您选择 SLS 存储 ，点击同意使用协议，下载 SLS 的授权文件，使用此文件在 SLS 创建 RAM 账号，并正确填写该账号的 AccessKey ID、AccessKey Secret ，验证成功后，跳转至成功开通页面



### 创建观测云工作空间

在观测云工作空间创建页面，填写信息创建成功后，需选择存储方式：默认存储、 SLS 存储

- 若您选择 默认存储 ，则直接跳转至成功开通页面



- 若您选择 SLS 存储 ，点击同意使用协议，下载 SLS 的授权文件，使用此文件在 SLS 创建 RAM 账号，并正确填写该账号的 AccessKey ID、AccessKey Secret ，验证成功后，跳转至成功开通页面



## SLS promql 函数

以下为函数 influxdb 与 SLS promql 函数支持情况对比：

| func                                                         | influxdb                | SLS promql | 备注                               |
| :----------------------------------------------------------- | ----------------------- | :--------- | ---------------------------------- |
| avg                                                          | mean                    | avg        |                                    |
| count                                                        | count                   | count      |                                    |
| derivative(统计表中某列数值的单位变化率)                     | derivative              | rate       | sls不支持by,但可以加其它聚合函数by |
| median                                                       | median                  | quantile   |                                    |
| match                                                        | re                      | like       |                                    |
| bottom（统计某列的值最小 k 个非 NULL 值）                    | bottom                  | bottomk    |                                    |
| top(统计某列的值最大 k 个非 NULL 值。)                       | top                     | topk       |                                    |
| max                                                          | max                     | max        |                                    |
| min                                                          | min                     | min        |                                    |
| percentile（统计表中某列的值百分比分位数）                   | percentile              | quantile   |                                    |
| round                                                        | round                   | round      | 不支持group by                     |
| stddev                                                       | stddev                  | stddev     |                                    |
| sum                                                          | sum                     | sum        |                                    |
| log                                                          | log                     | ln         |                                    |
| p50(百分位)                                                  | percentile              | quantile   |                                    |
| p75(百分位）                                                 | percentile              | quantile   |                                    |
| p90(百分位）                                                 | percentile              | quantile   |                                    |
| p99(百分位）                                                 | percentile              | quantile   |                                    |
| count_distinct                                               | count(distinct())       | 无         |                                    |
| difference(统计表中某列的值与前一行对应值的差)               | difference              | 无         |                                    |
| distinct                                                     | distinct                | 无         |                                    |
| non_negative_derivative(统计表中某列数值的单位变化率，只有正向值) | non_negative_derivative | 无         |                                    |
| first（表中第一条数据）                                      | first                   | 无         |                                    |
| last（表中最新的一条数据）                                   | last                    | 无         |                                    |
| spread(统计表/超级表中某列的最大值和最小值之差)              | spread                  | 无         |                                    |
| mode(众数）                                                  | mode                    | 无         |                                    |
| moving_average(计算连续 k 个值的移动平均数（moving average）) | moving_average          | 无         |                                    |

