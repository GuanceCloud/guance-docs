# 4511-nginx-errorlog-确保NGINX启用error访问日志记录
---

## 规则ID

- 4511-nginx-errorlog


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- nginx应该记录所有的error日志。默认启用。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 错误日志记录可用于识别试图利用系统的攻击者并重新创建攻击者的步骤。错误日志记录还有助于识别应用程序中可能出现的问题






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep error_log /etc/nginx/nginx.conf
# 显示应该是
error_log /var/log/nginx/error.log info;

```



## 补救
- 
编辑文件/etc/nginx/nginx.conf 示例：
```bash
error_log /var/log/nginx/error.log info;
```



## 影响


- 无




## 默认值


- 默认情况下，启用访问日志




## 参考文献


- 无



## CIS 控制


- 无


