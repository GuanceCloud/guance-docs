---
icon: material/key-link
---
# SSH

---

## 视图预览

SSH 性能指标展示，包括 SSH 服务状态、SFTP 服务状态、SFTP 服务响应时间等。

![image](../imgs/input-ssh-1.png)

## 版本支持

操作系统：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>

## 安装配置

说明：示例 Linux 版本为：CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

### 指标采集 (必选)

1、 开启 ssh 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/ssh
cp ssh.conf.sample ssh.conf
```

2、 修改 `ssh.conf` 配置文件

主要参数说明

- interval：采集频率
- host：远程主机
- username：用户名
- password：密码
- sftpCheck：是否开启 sftp 检测 (默认为 false)
- privateKeyFile：私钥文件路径 (默认为空)

```
[[inputs.ssh]]
  interval = "60s"
  host     = "127.0.0.1:22"
  username = "username"
  password = "password"
  sftpCheck      = false
  privateKeyFile = ""
```

3、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

4、 指标预览

![image](../imgs/input-ssh-3.png)

### 插件标签 (非必选）

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 SSH 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
# 示例
[inputs.ssh.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - SSH 监控视图>

## [指标详解](../../../datakit/ssh#measurements)


## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>
