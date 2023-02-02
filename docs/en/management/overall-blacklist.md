# 黑名单
---

观测云支持通过设置黑名单的方式过滤掉符合条件的不同类型的数据，即配置黑名单以后，符合条件的数据不再上报到观测云工作空间，帮助您节约数据存储费用。

## 前提条件

- [安装 DataKit](../datakit/datakit-install.md)
- DataKit 版本要求 >= 1.4.7

## 新建黑名单

在观测云工作空间，点击「管理」-「黑名单」-「新建黑名单」。

![](img/5.blacklist_1.png)

在「数据来源」，选择数据类型，并在「过滤」添加一条或多条过滤规则，点击"确定"即可开启数据黑名单过滤规则。

- 数据来源：黑名单名称根据数据来源自动生成，支持选择「日志」、「基础对象」、「自定义对象」、「网络」、「应用性能监测」、「用户访问监测」、「安全巡检」、「事件」、「指标」、「Profile」，支持手动输入预设黑名单，包数据来源、字段名，后续通过 DataKit 配置数据来源和字段并上报数据后即可生效。

| 数据类型     | 数据来源（支持自定义预设）                       |
| :----------- | :----------------------------------------------- |
| 日志         | 日志来源（source），如 nginx 等                  |
| 基础对象     | 类别（class），如 HOST 等                        |
| 自定义对象   | 类别（class），如 MySQL 等                       |
| 网络         | 来源（source），如 netflow ，httpflow            |
| 应用性能监测 | 服务（service），如 redis 等，支持选择“全部服务” |
| 用户访问监测 | 应用（app_id）                                   |
| 安全巡检     | 类别（category），如 system 等                   |
| 事件         | 来源（source），如 monitor 等                    |
| 指标         | 指标集，如 cpu 等                                |
| Profile      | 服务（service）                                  |

- 过滤：支持两种条件选择，“任意”和“所有”。“任意”为 “或（OR）”条件，“所有”为“且（AND）”条件。

- 字段名：支持手动输入字段名，必须是精准值，可以在查看器“显示列”查看需要匹配的字段名。

- 字段值：支持手动输入字段值，支持输入单值、多值，支持正则语法。

- 操作符：支持`in / not in / match / not match` 4 种模式，`in / not in` 为精准匹配，`match / not match` 为正则匹配。

| 操作符              | 支持数值类型   | 说明                                                   | 示例              |
| :------------------ | :------------- | :----------------------------------------------------- | :---------------- |
| `in / not in`       | 数值列表       | 指定的字段是否在列表中，列表中支持多类型混杂           | `1,2,"foo",3.5`   |
| `match / not match` | 正则表达式列表 | 指定的字段是否匹配列表中的正则，该列表只支持字符串类型 | `"foo.*","bar.*"` |

注意：数据类型支持字符串、整数、浮点这几种类型。

![](img/5.blacklist_1.2.png)

若选择的「数据来源」是「日志」，则在功能菜单「日志」-「黑名单」下同步创建一条日志过滤规则，反之亦然。

![](img/5.blacklist_1.1.png)





### 示例

以下示例中，新建黑名单，选择「全部来源」的日志，满足`status`为`ok 或 info`，且`host`不为`hz-dataflux-saas-daily-01`，且`service`中不包含`kodo`字样，即同时满足这三个匹配规则的数据将被过滤，不再上报工作空间。

![](img/5.blacklist_2.png)

设置黑名单以后，可以在查看器根据过滤条件来检查黑名单是否生效。在黑名单创建生效后，即符合过滤条件的数据将不再上报到工作空间。



![](img/5.blacklist_4.png)

## Operate Blacklist

### Edit

On the right side of the blacklist, click the "Edit" icon to edit the created data filtering rules. In the following example, when the blacklist is set, the log for "all sources" satisfies ` status ` as `ok or info`, or `host` as `hz-dataflux-saas-daily-01`, or `service` does not contain the word `kodo`, i.e. data satisfying any of these three matching rules is filtered and no longer reported to the workspace.

![](img/5.blacklist_3.png)

### Delete

On the right side of the blacklist, click the "Delete" icon to delete the existing filtering rules. After the filtering rules are deleted, the data will be reported to the workspace normally.

![](img/5.blacklist_5.png)

### Batch operation

In the Guance workspace "Manage"-"Blacklist", click "Batch Operation" to "Batch Export" or "Batch Delete" blacklist.

???- attention

    This function is only displayed for workspace owners, administrators and standard members, and read-only members are not displayed.

![](img/3.black_1.png)

### Import/Export

Support "import/export blacklist" in "management"-"blacklist" of Guance workspace, that is, create blacklist by importing/exporting JSON files.

???- attention

    The imported JSON file needs to be the configuration JSON file from Guance.

## Notes

- Blacklist rules configured in the observation cloud will not take effect if the blacklist is configured in the file `datakit.conf` under the directory `/usr/local/datakit/conf.d` when installing and configuring the datakit;
- DataKit pulls data every 10 seconds, and the blacklist will not take effect immediately after configuration, so it needs to wait at least 10 seconds.
- After the blacklist is configured, it is stored in the `.pull` file under the datakit directory `/usr/local/datakit/data` , and more can be found in the documentation [view blacklist](../dca/index.md).
