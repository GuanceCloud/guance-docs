# 4508-nginx-defindex-nginx引用index页面不要引用nginx字段
---

## 规则ID

- 4508-nginx-defindex


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- NGINX的默认错误和index.html页面显示该服务器为NGINX。应该删除或修改这些默认页面，以便它们不会宣传服务器的底层基础设施。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 通过收集有关服务器的信息，攻击者可以针对针对其已知漏洞的攻击。删除显示服务器运行NGINX的页面有助于减少对服务器的有针对性的攻击。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep -i nginx /usr/share/nginx/html/index.html
grep -i nginx /usr/share/nginx/html/50x.html
grep -i nginx /usr/share/nginx/html/404.html
# 显示不应该有'nginx'标志
```



## 补救
- 
编辑这些文件：
/usr/share/nginx/html/index.html 
usr/share/nginx/html/50x.html
/usr/share/nginx/html/404.html
移除相关的字段和有nginx相关的行。



## 影响


- 无




## 默认值


- 默认情况下，这些文件都是会有nginx字段




## 参考文献


- 无



## CIS 控制


- 无


