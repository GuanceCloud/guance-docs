# DQL 正则式函数

## 概述

日志数据，需要能通过某个字段（例如: `message`）正则提取出子字符串，然后根据子字符串分组展示。

下面以腾讯云 CLS 日志服务为例：

假设原始日志如下 ，想要分析 "succeeded for volume" 后面的具体 volume 分组信息，则可以使用：

```
"succeeded for volume" | select regexp_extract(event.message,'(?:succeeded for volume) "(\S+)"', 1) as m1, count(*) as c1 group by m1 order by c1 desc
```
```
MountVolume.SetUp succeeded for volume "default-token-9dkx7" 
```

![](img/right.png)

![](img/right-1.png)


## 现有实现方式

### 腾讯云 CLS	

通过一系列正则式函数实现：

![](img/right-2.png)

```
* | select regexp_extract(event.message,'(?:succeeded for volume) "(\S+)"', 1) as m1, count(*) as c1 group by m1 order by c1 desc
```

### 阿里云 SLS	

通过一系列正则式函数实现，同 CLS：

![](img/right-3.png)

```
* | select regexp_extract(event.message,'(?:succeeded for volume) "(\S+)"', 1) as m1, count(*) as c1 group by m1 order by c1 desc
```

### 日志易	

通过实现 `parse` 指令实现，`parse` 指令可以在查询时候动态抽取字段。（根据正则表达式）

![](img/right-4.png)

![](img/right-5.png)

```
appname:linux | parse "Did not receive identification string from (?<ip>\d+\.\d+\.\d+\.\d+) port (?<port>\d+)" |  stats count() by ip,port
```

> 日志易 `parse` 方式，在高版本 ES7.13 中，可以使用 [runtimeField](https://www.elastic.co/guide/en/elasticsearch/reference/current/runtime.html) 实现；  
>
> 但是当前版本（7.10）或者 opensearch 中，可以使用 [terms aggs + script](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-terms-aggregation.html) 实现。


## Kodo 语法扩展

=== "target 添加新的正则式函数"

    现有聚合函数中添加一类，正则式函数：

    ```
    L::`*`:(regexp_extract(event.message,'(?:succeeded for volume) "(\S+)"', 1) as m1, count(`*`) as c1 ) {} by m1
    ```

=== "group by 语句支持函数"

    by 语句支持函数：

    ```
    L::`*`:(count(`*`) as c1 ) {} by regexp_extract(event.message, '(?:succeeded for volume) "(\S+)"', 1, alias='m1') 
    ```


## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **腾讯云正则式函数**</font>](https://cloud.tencent.com/document/product/614/63505#regexp_extract)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **阿里云正则式函数**</font>](https://help.aliyun.com/document_detail/63453.html?spm=a2c4g.322173.0.0.4dc529ecRgUNSs)

</div>
