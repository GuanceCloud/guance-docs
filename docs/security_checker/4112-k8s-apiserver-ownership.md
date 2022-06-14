# 4112-k8s-apiserver-ownership-k8s-apiserver文件所有权没有设置为root:root
---

## 规则ID

- 4112-k8s-apiserver-ownership


## 类别

- nginx


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 如果在使用systemd管理服务的计算机上使用nginx，请验证nginx文件所有权和组所有权是否正确设置为root。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 将所有权设置为根组中的用户和根用户将减少对nginx配置文件进行未经授权修改的可能性。






## 风险项


- nginx安全



## 审计方法
- 执行以下命令以验证文件和组是否归root所有：

```bash
stat /etc/nginx
```



## 补救
- 执行下面的命令：
```bash
#> chown -R root:root /etc/nginx
```
这会将文件的所有权和组所有权设置为root。



## 影响


- 无




## 默认值


- nginx的默认所有权和组是根的




## 参考文献


- 无



## CIS 控制


- 无


