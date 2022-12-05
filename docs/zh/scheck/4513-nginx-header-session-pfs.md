# 4513-nginx-header-session-pfs-建议禁用session恢复，以实现完全正向保密
---

## 规则ID

- 4513-nginx-header-session-pfs


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- 应该禁用HTTPS会话的会话恢复，以便能够实现Perfect forward secrecy(完全正向保密协议)



## 扫描频率
- 0 */30 * * *

## 理论基础


- 完全正向保密协议是一种加密机制，它使过去的会话密钥即使在服务器的私钥被泄露的情况下也不会被泄露。如果攻击者记录到服务器的所有流量并将其存储，然后在没有完全正向保密协议的情况下获得私钥，则所有通信都将受到破坏。由于具有完全正向保密，使用Diffie Hellman为用户发起的每个会话生成会话密钥，从而将会话泄露仅隔离到该通信会话。允许会话恢复打破了完美的前向保密；如果攻击者能够破坏以前的会话和与服务器的通信，则这会扩大攻击者的攻击范围






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep -ir ssl_session_tickets /etc/nginx
# 输出应当包含以下内容
ssl_session_tickets off;
```



## 补救
- 
编辑文件/etc/nginx/nginx.conf或涉及到https配置的文件。示例：
```bash
ssl_session_tickets off;
```



## 影响


- 无




## 默认值


- 默认情况下不启用完全正向保密协议




## 参考文献


- [imperialviolet](https://www.imperialviolet.org/2013/06/27/botchingpfs.html)



- [perfect-forward-secrecy](https://scotthelme.co.uk/perfect-forward-secrecy/)



## CIS 控制


- 无


