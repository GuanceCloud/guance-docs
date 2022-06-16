# 4502-nginx-serverlocked-请确保NGINX服务帐户已被锁定
---

## 规则ID

- 4502-nginx-serverlocked


## 类别

- nginx


## 级别

- warn


## 兼容版本


- Linux




## 说明


- nginx用户帐户应该有一个有效的密码，但该帐户应该被锁定



## 扫描频率
- 0 */30 * * *

## 理论基础


- 作为一种深入的防御措施，nginx用户帐户应该被锁定，以防止登录，并防止有人使用密码将用户切换到nginx。一般来说，任何人都不需要su作为nginx，当需要时，应该使用sudo代替，这将不需要nginx帐户密码






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证文件和组是否归nginx所有：

```bash
passwd -S nginx
## 应该与以下结果中的一种相似
# nginx LK 2010-01-28 0 99999 7 -1 (Password locked.)
# or
# nginx L 07/02/2012 -1 -1 -1 -1
```



## 补救
- 执行下面的命令锁定用户：
```bash
#> passwd -l nginx
```



## 影响


- 这确保了nginx用户帐户可能不会被人类用户使用




## 默认值


- 默认情况下，nginx用户默认会被锁定




## 参考文献


- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS 控制


- 无


