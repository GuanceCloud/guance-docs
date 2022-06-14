# 4507-nginx-servertoken-确保server_tokens指令设置为`off`
---

## 规则ID

- 4507-nginx-servertoken


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- server_tokens指令负责在错误页和ServerHTTP响应头字段中显示NGINX版本号和操作系统版本。不应显示此信息



## 扫描频率
- 0 */30 * * *

## 理论基础


- 攻击者可以使用这些响应头在网站上进行侦察，然后针对与底层技术相关的特定已知漏洞进行目标攻击。隐藏该版本会放慢速度，并阻止一些潜在的攻击者。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
curl -I 127.0.0.1 | grep -i server
# 结果如果是如下所示，那么建议关闭server_token
Server: nginx/1.14.0
```



## 补救
- 执行下面的命令：
要禁用server_tokens指令，请将其设置为关闭nginx.conf中的server 代码块内：
```bash
server {
 ...
 server_tokens off;
 ...
}
```



## 影响


- 无




## 默认值


- 默认情况下，server_tokens的默认值为开启状态




## 参考文献


- 无



## CIS 控制


- 无


