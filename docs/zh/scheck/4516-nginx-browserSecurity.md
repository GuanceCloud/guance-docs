# 4516-nginx-browserSecurity-建议增加浏览器安全配置
---

## 规则ID

- 4516-nginx-browserSecurity


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- X-Frame-Options的标题应该设置为允许特定的网站或根本没有网站将您的网站作为一个对象嵌入到他们自己的网站中，这取决于您的组织策略和应用程序需求



- X-Content-Type-Options头应用于强制受支持的用户代理检查HTTP响应的内容类型头和来自请求目标的期望内容



- X-XSS-Protection头允许您利用基于浏览器的保护来防止跨站点脚本编写。这应该在您的web服务器上实现，以保护用户，并增加用户对站点的信任。您的策略应该尽可能设置为阻塞模式，以确保在检测到跨站点脚本时浏览器阻塞页面



## 扫描频率
- 0 */30 * * *

## 理论基础


- 设置X-Frame-Options,X-Content-Type-Options,X-XSS-Protection有助于您的网站安全。请根据实际程序需求进行修改!






## 风险项


- nginx安全



## 审计方法
- 
若要验证X-Frame-Options,X-Content-Type-Options,X-XSS-Protection头的当前设置
```bash
grep -ir X-Xss-Protection /etc/nginx
# 输出内容应该包括
add_header X-Xss-Protection "1; mode=block";

grep -ir X-Content-Type-Options /etc/nginx
# 输出内容应该包括
add_header X-Content-Type-Options "nosniff";

grep -ir X-Frame-Options /etc/nginx
# 输出内容应该包括
add_header X-Frame-Options "SAMEORIGIN";
```



## 补救
- 
查找nginx配置的HTTP或服务器块，请根据具体应用程序和web系统需求添加头部信息
```bash
 #减少点击劫持
add_header X-Frame-Options DENY;
#禁止服务器自动解析资源类型
add_header X-Content-Type-Options nosniff;
#防XSS攻击
add_header X-XSS-Protection "1; mode=block";
```



## 影响


- 如果没有配置或没有正确的配置浏览区安全头部信息，会导致网站有入侵和攻击。




## 默认值


- 默认情况没有设置




## 参考文献


- 无



## CIS 控制


- 无


