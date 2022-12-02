# 4515-nginx-timeout-建议重新设置读取客户端标头和正文的超时值
---

## 规则ID

- 4515-nginx-timeout


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- client_header_timeout和client_body_timeout指令定义了服务器等待从客户端发送报头或正文的时间。如果连续的60s内没有收到客户端的1个字节, 返回408



## 扫描频率
- 0 */30 * * *

## 理论基础


- 设置客户端报头和正文超时有助于服务器减轻可能发生的DDOS攻击。通过使请求超时，服务器能够释放可能正在等待正文或头的资源






## 风险项


- nginx安全



## 审计方法
- 
若要验证client_body_timeout和client_header_timeout指令的当前设置，请发出以下命令。您还应该手动检查nginx配置，看看是否包含可能位于/etc/nginx目录之外的语句。如果不存在，则将该值设置为默认值
```bash
grep -ir timeout /etc/nginx
# 输出应当包含以下内容
client_body_timeout 10;
client_header_timeout 10;
```



## 补救
- 
查找nginx配置的HTTP或服务器块，并将设置的client_header_timeout和client_body_timeout指令添加到该配置中。下面的示例将超时设置为10秒
```bash
client_body_timeout 10;
client_header_timeout 10;
```



## 影响


- 无




## 默认值


- 默认情况下超时控制为60s




## 参考文献


- 无



## CIS 控制


- 无


