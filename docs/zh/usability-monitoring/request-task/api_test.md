# API 拨测
---

通过创建基于 HTTP、TCP、ICMP、WebSocket 四种协议的拨测任务，您可以周期性地监测不同地域、不同运营商的网络站点质量、网络数据传输稳定性等状况，实现定时检测、可用性判断以及多地域自动化测试。

例如，当您的服务响应出现延缓或响应内容出错时，拨测功能可以及时提醒您的团队，帮助您在用户发现问题之前，快速定位性能问题及其影响范围。


## 概念先解

| <div style="width: 140px">名词</div>           | 说明            |
| -----------    | ------------------     |
| HTTP 协议      | 超文本传输协议（HTTP）是一种基于 TCP/IP 的应用层协议，用于分布式、协作式和超媒体信息系统的数据通信。通常，HTTP 客户端发起请求，通过 TCP 连接（默认端口为 80）与服务器通信。服务器接收请求后返回状态码（如 `"HTTP/1.1 200 OK"`）及相应内容，包括请求的文件、错误消息或其他信息。 |
| TCP 协议       | 传输控制协议（TCP）是一种网络通信协议，用于建立和维护两个程序之间的可靠连接，确保数据在 Internet 上的正确传输。TCP 将数据分解为数据包发送，并在接收端重组数据，同时进行错误检查和重传机制，以保证数据传输的完整性。  |
| ICMP 协议      | Internet 控制报文协议（ICMP）是 TCP/IP 协议簇的子协议，用于在 IP 主机和路由器之间传递控制消息。它主要用于检测网络是否通畅、主机是否可达、路由是否可用等，对网络通信的可靠性至关重要。          |
| WEBSOCKET 协议 | WebSocket 是一种基于 TCP 的全双工通信协议，自 HTML5 起被广泛支持。它允许浏览器与服务器之间进行双向实时通信，支持客户端与服务器端同时发送和接收消息，实现高效的数据交互。         |


## 开始创建 {#create}

- [HTTP](./http.md)
- [TCP](./tcp.md)
- [ICMP](./icmp.md)
- [WEBSOCKET](./websocket.md)


**注意**：体验版工作空间最多支持创建 5 个拨测任务，且仅限使用“中国区”拨测节点。如需创建更多拨测任务或使用海外拨测节点，请将当前版本[升级为商业版](../../plans/trail.md#upgrade-commercial)。


## 任务标签


在拨测任务的创建页面，您可以在左上角为当前任务添加[**标签**](../../management/global-label.md)，通过全局标签实现工作空间内数据的联动。已添加的标签保存后将直接显示在列表中。您可以通过左侧“快捷筛选 > 标签”快速查找对应标签下的拨测任务。

???+ "标签逻辑补充"

    如果拨测任务节点设置为 `node_name:华南-广州-中国电信`，而您为任务添加了自定义标签 `node_name:自建节点`，则自定义标签将被丢弃，不会写入拨测结果属性中。

