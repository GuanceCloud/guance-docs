# DataKit 配置 HTTPS

---

## 简介

HTTPS 是以安全为目标的 HTTP 通道，在 HTTP 的基础上通过传输加密和身份认证保证了传输过程的安全性。为了安全，在部署前端应用时常使用 https 协议。针对 https 协议的前端，在配置用户访问监测时，如果部署的 DataKit 还是使用 **IP + 端口**的 http 协议，浏览器会认为不安全，这时应用的 RUM 数据就无法上报到<<< custom_key.brand_name >>>。

本文将使用 **Nginx 的 SSL** 来开启服务器的 HTTPS。

## 前置条件

- 一台云主机 CentOS 7.9
- 阿里云域名，域名已经解析到云主机的 80 端口
- 云主机已 <[安装 DataKit](../../datakit/datakit-install.md)>

## 操作步骤

???+ warning

    **当前案例使用 DataKit 版本`1.4.20`（最新版本），Nginx 版本是 `1.22.1` 进行测试**
### 1 安装 Nginx

#### 1.1 安装 yum-utils 包

登录云主机，执行如下命令。

```
yum install yum-utils -y
```

#### 1.2 新建 nginx.repo

新建 `/etc/yum.repos.d/nginx.repo` 文件，内容如下。

```
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
```

#### 1.3 执行安装命令

```
yum install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl status nginx
```

当看到 running 时，表示 Nginx 安装成功。

![image.png](../images/datakit-https-1.png)

#### 1.4 检查 ssl 模块

输入 `nginx -V` ，输出带有 `--with-http_ssl_module` 表示 ssl 模块已安装。

![image.png](../images/datakit-https-2.png)

### 2 下载证书

#### 2.1 下载 SSL 证书

登录「阿里云」 - 「数字证书管理服务」 - 「SSL 证书」 创建 免费证书。<br/>
证书创建成功后，找到 Nginx，点击「下载」。

![image.png](../images/datakit-https-3.png)

#### 2.2 上传证书

解压 SSL 证书，把 `7279093\_www.zzdskj.cn.key` 和 `7279093\_www.zzdskj.cn.pem` 上传到云主机的 `/opt/key` 目录。

![image.png](../images/datakit-https-4.png)

#### 2.3 修改 Nginx 配置文件

编辑 `/etc/nginx/conf.d/default.conf` 文件，输入如下内容。<br/>
其中 443 端口会被重新定向到 DataKit 的 9529 端口。

```
server {
    listen       80;
    server_name  localhost;

    #access_log  /var/log/nginx/host.access.log  main;
    rewrite ^(.*)$ https://$host$1 permanent;
}

   server {
        listen       443 ssl http2;
        server_name  zzdskj.cn;
        ssl_certificate        /opt/key/7279093_www.zzdskj.cn.pem;
        ssl_certificate_key    /opt/key/7279093_www.zzdskj.cn.key;



        location / {
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header REMOTE-HOST $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://localhost:9529/;
        }


        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }


```

#### 2.4 重新加载配置

执行如下命令。

```
nginx -s reload
```

### 3 验证

浏览器输入 https 的域名，能看到如下界面，即表示配置成功。

![image.png](../images/datakit-https-5.png)
