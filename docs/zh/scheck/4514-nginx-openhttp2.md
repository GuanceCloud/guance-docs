# 4514-nginx-openhttp2-建议开启HTTP/2.0,(建议 不影响安全的选项)
---

## 规则ID

- 4514-nginx-openhttp2


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


- HTTP/2.0通过完全多路复用，既引入了性能好处，也提供了一些安全好处。HTTP/2.0改进了密码套件的要求和黑名单。它还将禁用会话重新协商和TLS压缩。这有助于防止诸如犯罪这样的漏洞，并确保我们有更强的加密能力






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep -ir http2 /etc/nginx
# 输出应当包含以下内容
listen 443 ssl http2;
```



## 补救
- 
编辑文件/etc/nginx/nginx.conf或涉及到https配置的文件。示例：
```bash
server {
 listen 443 ssl http2;
}
```



## 影响


- 无




## 默认值


- 默认情况下启用的最高协议为HTTP/1.1




## 参考文献


- [server-side-tls](https://mozilla.github.io/server-side-tls/ssl-config-generator/)



## CIS 控制


- 无


