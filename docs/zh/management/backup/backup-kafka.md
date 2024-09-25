# 数据转发至 Kafka 消息队列
---


## 开始配置


1. 地址：`Host:Port`，多个节点使用逗号间隔。

2. 消息主题：即 Topic 名称。

3. 安全协议：在 Kafka 侧，SASL 可以使用 PLAINTEXT 或者 SSL 协议作为传输层，相对应的就是使用 SASL_PLAINTEXT 或者 SASL_SSL 安全协议。如果使用 SASL_SSL 安全协议，必须配置 SSL 证书。

4. 点击**测试连接**，若上述信息满足规范，则提示测试连接成功。点击确定即可保存当前规则。
    
???+ warning "若未通过测试："

    您需确认：

    - 地址是否正确；  
    - 消息主题名称是否正确；  
    - SSL 证书是否正确；  
    - 用户名是否正确；  
    - 密码是否正确。


### PLAINTEXT

无需任何安全校验，可直接测试连接。

### SASL_PLAINTEXT

认证方式默认为 PLAIN，可选 SCRAM-SHA-256 与 SCRAM-SHA-512 两种。

输入在 Kafka 侧执行安全认证的 username/password，再测试连接。

![](../img/kafka-1.png)

### SASL_SSL

此处[需上传 SSL 证书](https://kafka.apachecn.org/documentation.html#security_ssl)。

认证方式默认为 PLAIN，可选 SCRAM-SHA-256 与 SCRAM-SHA-512 两种。

输入在 Kafka 侧执行安全认证的 username/password，再测试连接。

![](../img/kafka-2.png)




