# 4503-nginx-nologin-请确保NGINX服务帐户的shell无效
---

## 规则ID

- 4503-nginx-nologin


## 类别

- nginx


## 级别

- warn


## 兼容版本


- Linux




## 说明


- nginx帐户不应该能够登录，因此应该为该帐户设置/sbin/nologin



## 扫描频率
- 0 */30 * * *

## 理论基础


- 用于nginx的帐户应该只用于nginx服务，并且不需要有登录的能力。这可以防止攻击者使用帐户登录






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证：

```bash
grep nginx /etc/passwd
```



## 补救
- 执行下面的命令：
```bash
#> chsh -s /sbin/nologin nginx
```



## 影响


- 这确保了nginx用户帐户可能不会被人类用户使用




## 默认值


- 默认情况下，nginx用户的shell为/sbin/nologin




## 参考文献


- [nginx-user](http://nginx.org/en/docs/ngx_core_module.html#user)



## CIS 控制


- 无


