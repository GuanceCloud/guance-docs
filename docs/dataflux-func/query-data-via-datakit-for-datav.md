# 通过 DataV 展示数据
---


本文档主要介绍如何使用本系统通过 DataKit 查询数据，并将数据在 DataV 中展示。

> 提示：本文内容为了文档整体观感，部分截图存在一定演义成分。

> 提示 2：本文示例只有在 DataKit, DataWay 等观测云各组件正确配置/运行，网络正常的情况下才能获得预期效果。

> 提示 3：请始终使用最新版 DataFlux Func 进行操作。

## 1. 背景

对于观测云用户来说，可以从 DataFlux Func 通过 DataKit 查询观测云中的时序数据，并将数据展示在 DataV 中。

DataFlux Func 作为 Python 脚本管理、运行平台，可以提供更灵活、更强大的数据处理能力。

本文假设用户已经在 DataFlux Func 中正确连接了 DataKit。
有关如何在 DataFlux Func 中连接 DataKit，请参考：

- [连接并操作 DataKit](/dataflux-func/connect-to-datakit)

## 2. 编写数据查询函数

进入编辑器，创建脚本并输入以下示例脚本：

~~~python
import arrow

@DFF.API('DataKit Demo')
def datakit_demo():
    # 获取 DataKit 操作对象
    datakit = DFF.SRC('datakit')

    # 使用 DQL 查询数据
    dql = 'M::datakit:(AVG(num_goroutines) AS value) [7d::1d] LIMIT 10'
    status_code, dql_res = datakit.query(dql, dict_output=True)

    # 转换为 DataV 折线图所需的格式
    data = []
    series = dql_res['series'][0]
    for point in series:
        data.append({
            'x': arrow.get(point['time']).format('YYYY-MM-DD'),
            'y': point['value'],
            's': 1,
        })

    print('OK')

    return data
~~~

![](query-data-via-datakit-for-datav/add-sample-code.png)

## 3. 发布脚本

脚本修改后会保存为草稿，需要发布后，才算是正式上线。

![](query-data-via-datakit-for-datav/publish-sample-code.png)

## 4. 配置授权链接

被`@DFF.API(...)`修饰的函数，可以在「管理 - 授权链接」中配置允许外部系统访问。

![](query-data-via-datakit-for-datav/add-auth-link-1.png)

![](query-data-via-datakit-for-datav/add-auth-link-2.png)

## 5. 在 DataV 中配置数据源

在已经创建的「授权链接」列表中，可以找到之前创建的授权链接。

打开「API 调用示例」，可获取本授权链接的各种不同调用方式。

![](query-data-via-datakit-for-datav/config-datav-source-1.png)

![](query-data-via-datakit-for-datav/config-datav-source-2.png)

选择合适的调用方式，在 DataV 中配置即可

![](query-data-via-datakit-for-datav/config-datav-source-3.png)

## 6. 在 DataV 中查看大屏

至此，观测云工作空间中的数据成功在 DataV 上展示

![](query-data-via-datakit-for-datav/datav-screen.png)
