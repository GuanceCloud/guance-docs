# 拨测任务
---

通过创建基于 `HTTP、TCP、ICMP、WEBSOCKET` 等不同协议的拨测任务，周期性监测不同地域、不同运营商的网络站点质量、网络数据传输稳定性等状况，实现定时、可用性判断条件、多地域地发起自动化测试。

比如，如果您的服务响应开始延缓，或是响应主体错误，拨测可及时提醒您的团队，先于用户发现性能问题及影响范围。

![](../img/search.png)

## 概念先解

| <div style="width: 140px">名词</div>           | 说明            |
| -----------    | ------------------     |
| HTTP 协议      | 超文本传输协议，是一种用于分布式、协作式和超媒体信息系统的基于 TCP/IP 协议之上的应用层协议，是数据通信的基础。通常，HTTP 客户端发起一个请求，创建一个到服务器指定端口（默认是80端口）的 TCP 连接。HTTP 服务器则在那个端口监听客户端的请求。一旦收到请求，服务器会向客户端返回一个状态，比如 `"HTTP/1.1 200 OK"`，以及返回的内容，如请求的文件、错误消息、或者其它信息。 |
| TCP 协议       | 传输控制协议，是一种网络通信协议，规定如何建立和维护两个程序可以交换数据的连接，如何通过 Internet 发送信息。通常，TCP 将消息或文件分解成更小的片段（数据包），通过 Internet 发送，由另一个 TCP 层接收，并将该数据重组为完整的文件或消息。同时 TCP 对数据流进行错误检查，若发现错误，TCP 重新传输数据包，以确保数据的传递。  |
| ICMP 协议      | Internet 控制报文协议，是 TCP/IP 协议簇的子协议，用于在 IP 主机、路由器之间传递控制消息。控制消息是指网络是否通畅、主机是否可达、路由是否可用等网络消息，对用户数据的传递具有重要作用。          |
| WEBSOCKET 协议 | 是一种网络通信协议，是 HTML5 开始提供的一种浏览器与服务器进行全双通信的网络技术。WebSocket 基于 TCP 双向全双工进行消息传递，同一时刻，既可以发送消息，也可以接受消息，服务端可以主动向客户端发送消息，客户端也可以主动向服务端发送消息。         |


## 创建拨测任务 {#create}

在观测云工作空间**可用性监测 > 新建**，可基于 [HTTP](./http.md)、[TCP](./tcp.md)、[ICMP](./icmp.md)、[WEBSOCKET](./websocket.md) 四种协议来创建拨测任务。


???- warning "权限与版本"

    - 标准成员及以上成员可以创建拨测任务；
    - 体验版工作空间最多可创建 5 个拨测任务，且仅支持 “中国区” 拨测节点的使用，如需创建更多拨测任务或使用更多的海外拨测节点，请前往工作空间内[**付费计划与账单**](../../plans/trail.md#upgrade-commercial)页面进行升级。


## 管理任务列表 {#manag}

所有的拨测任务可通过任务列表进行管理，您可进行以下操作：

1. 快捷筛选：基于拨测类型、状态、标签、拨测频率四大筛选项，您可自定义选中进行筛选；
2. 搜索：在搜索栏，输入任务名称快速搜索定位；
3. 排序：可点击名称旁边的排序按钮，对按照创建时间排序的拨测任务进行正序或倒序排列。
4. 批量操作：创建拨测任务后，默认启动拨测任务，您可以在**可用性监测 > 任务**列表针对特定任务批量启用、禁用、删除；您还可以直接在任务右侧点击对应按钮进行删除或启用/禁用操作。
5. 导出 & 导入：您可以以 JSON 文件的格式导出或导入任务。


![](../img/8.use_4.png)

**注意**：若任务关联的拨测节点中有节点被删除，会出现 :warning: 标识。点击该标识，可筛选出所有带标记的任务。



## 高级配置

观测云支持通过**自建节点管理**快速建立分布于全球的私有部署节点.

> 更多操作详情，可参考 [自建节点管理](../self-node.md)；具体部署文档，可参考 [网络拨测](../../integrations/dialtesting.md)。

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **创建 HTTP 拨测任务**</font>](./http.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **创建 TCP 拨测任务**</font>](./tcp.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **创建 ICMP 拨测任务**</font>](./icmp.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **创建 WEBSOCKET 拨测任务**</font>](./websocket.md)

</div>

</font>