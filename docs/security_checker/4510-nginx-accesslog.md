# 4510-nginx-accesslog-确保NGINX启用访问日志记录
---

## 规则ID

- 4510-nginx-accesslog


## 类别

- nginx


## 级别

- info


## 兼容版本


- Linux




## 说明


- 每个核心站点都应该有access_log指令。默认启用。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 访问日志记录允许事件响应人员和审计员在事件发生时调查对系统的访问权限






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep -ir access_log /etc/nginx
# 显示应该是
access_log /var/log/nginx/host.access.log main;
# 如果显示的是如下内容 建议关闭并添加日志路径
access_log off;

```



## 补救
- 
编辑文件/etc/nginx/nginx.conf 示例：
```bash
access_log /var/log/nginx/host.access.log main;
```



## 影响


- 无




## 默认值


- 默认情况下，启用访问日志




## 参考文献


- 无



## CIS 控制


- 无


