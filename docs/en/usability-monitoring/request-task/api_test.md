# Synthetic Tests
---

By creating Synthetic Tests tasks based on HTTP, TCP, ICMP, and WebSocket protocols, you can periodically monitor the quality of network sites and the stability of data transmission across different regions and carriers. This enables scheduled testing, availability assessment, and automated testing in multiple regions.

For example, when your service response is delayed or the response content is incorrect, the Synthetic Tests feature can promptly alert your team, helping you quickly identify performance issues and their impact before users discover them.


## Concepts

| <div style="width: 140px">Term</div>           | Description            |
| -----------    | ------------------     |
| HTTP Protocol      | The Hypertext Transfer Protocol (HTTP) is an application-layer protocol based on TCP/IP, used for data communication in distributed, collaborative, and hypermedia information systems. Typically, an HTTP client initiates a request through a TCP connection (default port 80) to communicate with the server. The server receives the request and returns a status code (e.g., `"HTTP/1.1 200 OK"`) along with the requested content, including files, error messages, or other information. |
| TCP Protocol       | The Transmission Control Protocol (TCP) is a network communication protocol used to establish and maintain reliable connections between two programs, ensuring correct data transmission over the Internet. TCP breaks down data into packets for sending and reassembles them at the receiving end, performing error checking and retransmission mechanisms to ensure data integrity.  |
| ICMP Protocol      | The Internet Control Message Protocol (ICMP) is a sub-protocol of the TCP/IP suite, used to pass control messages between IP hosts and routers. It primarily checks if the network is accessible, if hosts are reachable, and if routes are available, which is crucial for reliable network communication.          |
| WebSocket Protocol | WebSocket is a full-duplex communication protocol based on TCP, widely supported since HTML5. It allows real-time bidirectional communication between browsers and servers, supporting simultaneous message sending and receiving from both client and server sides, enabling efficient data interaction.         |


## Start Creating {#create}

- [HTTP](./http.md)
- [TCP](./tcp.md)
- [ICMP](./icmp.md)
- [WEBSOCKET](./websocket.md)


**Note**: A Free Plan workspace supports up to 5 Synthetic Tests tasks, limited to using "China Region" Synthetic Tests nodes. To create more tasks or use overseas nodes, please [upgrade to the Commercial Plan](../../plans/trail.md#upgrade-commercial).


## Task Labels

On the Synthetic Tests task creation page, you can add [**labels**](../../management/global-label.md) in the top-left corner for the current task, enabling data linkage within the workspace via global labels. Added labels will be displayed directly in the list after saving. You can quickly find Synthetic Tests tasks under specific labels using the left-hand "Quick Filter > Labels".

???+ "Additional Label Logic"

    If the Synthetic Tests node is set to `node_name: South China-Guangzhou-China Telecom`, and you add a custom label `node_name: User-defined Node`, the custom label will be discarded and not written into the Synthetic Tests result attributes.