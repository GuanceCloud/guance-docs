# 4506-nginx-pid-secured-确保NGINX进程ID(PID)文件是安全的
---

## 规则ID

- 4506-nginx-pid-secured


## 类别

- nginx


## 级别

- warn


## 兼容版本


- Linux




## 说明


- nginxPID文件存储nginx进程的主进程ID。此文件不能受未经授权的修改



## 扫描频率
- 0 */30 * * *

## 理论基础


- PID文件应该由根目录和组根目录所有。它也应该对每个人都可读，但只能由根目录写入（权限644）。这将防止未经授权的修改PID文件，这可能会导致拒绝服务。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
ls -l /var/run/nginx.pid
# 结果应当是
-rw-r--r--. 1 root root 6 Nov 12 01:06 /var/run/nginx.pid
```



## 补救
- 执行下面的命令：
```bash
#> chown root:root /var/run/nginx.pid
#> chown 644 /var/run/nginx.pid
```



## 影响


- 无




## 默认值


- 默认情况下，PID所属root用户




## 参考文献


- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS 控制


- 无


