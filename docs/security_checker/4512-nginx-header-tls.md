# 4512-nginx-header-tls-建议只使用了现代的TLS协议
---

## 规则ID

- 4512-nginx-header-tls


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- 对于所有客户端连接和上游连接，只能在NGINX中启用现代TLS协议。删除遗留的TLS和SSL协议(SSL3.0、TLS1.0和1.1)，并启用新兴的和稳定的TLS协议(TLS1.2)，可以确保用户能够利用强大的安全功能，并保护他们免受不安全的遗留协议的影响



## 扫描频率
- 0 */30 * * *

## 理论基础


- 为什么禁用SSL3.0：POODLE Vulnerability漏洞允许攻击者利用CBC的漏洞，利用SSL3.0获取明文信息。SSL3.0也不再符合FIPS140-2标准



- 为什么禁用TLS1.0：当PCIDSS合规性要求它不用于任何处理信用卡号的应用程序时，TLS1.0被禁止使用。TLS1.0不使用现代保护功能，而且几乎所有不支持TLS1.2或更高版本的用户代理都不再得到其供应商的支持



- 为什么禁用TLS1.1：由于与更高版本的TLS相关联的安全性增加了，因此应该禁用TLS1.0。现代浏览器将在2019年初开始标记TLS1.1



- 为什么启用TLS1.2：TLS1.2利用了一些安全特性，包括现代密码套件、完美的正向安全和身份验证加密。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep -ir ssl_protocol /etc/nginx
```



## 补救
- 
编辑文件/etc/nginx/nginx.conf 示例：
```bash
# WEB
sed -i "s/ssl_protocols[^;]*;/ssl_protocols TLSv1.2;/" /etc/nginx/nginx.conf
# proxy
sed -i "s/proxy_ssl_protocols[^;]*;/proxy_ssl_protocols TLSv1.2;/" /etc/nginx/nginx.conf
# 如果没有配置过 则注意位置：
# web
server {
 ssl_protocols TLSv1.2;
}

# proxy
location / {
 proxy_ssl_protocols TLSv1.2;
 }
```



## 影响


- 禁用某些TLS可能不允许遗留的用户代理连接到您的服务器。禁用与后端服务器的特定协议的协商也可能会限制您与旧服务器连接的能力。在选择TLS协议时，您应该始终考虑是否需要支持旧的用户代理或服务器




## 默认值


- 默认情况下，NGINX不指定TLS协议，并接受所有TLS版本




## 参考文献


- [webkit.org-blog](https://webkit.org/blog/8462/deprecation-of-legacy-tls-1-0-and-1-1-versions/)



## CIS 控制


- 无


