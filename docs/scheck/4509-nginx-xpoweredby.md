# 4509-nginx-xpoweredby-确保NGINX反向代理不启用信息公开
---

## 规则ID

- 4509-nginx-xpoweredby


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- server和x-powered-by可以指定应用程序所使用的底层技术。如果没有明确指示，NGINX反向代理可以传递这些头，以删除它们。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 攻击者可以使用这些响应头在网站上进行侦察，然后针对与底层技术相关的特定已知漏洞进行目标攻击。移除这些头将减少有针对性攻击的可能性。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep proxy_hide_header /etc/nginx/nginx.conf
# 显示应该是
proxy_hide_header X-Powered-By;
# 如果没有 建议添加
```



## 补救
- 
编辑文件/etc/nginx/nginx.conf并添加header信息 示例：
```bash
location /docs {
....
proxy_hide_header X-Powered-By;
proxy_hide_header Server;
....
}
```



## 影响


- 无




## 默认值


- 默认情况下，是没有这个配置




## 参考文献


- 无



## CIS 控制


- 无


