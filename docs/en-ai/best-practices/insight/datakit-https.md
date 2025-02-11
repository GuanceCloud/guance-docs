# DataKit Configure HTTPS

---

## Introduction

HTTPS is an HTTP channel aimed at security, which ensures the security of the transmission process through transport encryption and identity authentication based on HTTP. For security reasons, HTTPS protocol is often used when deploying front-end applications. For front-end applications targeting HTTPS, if the deployed DataKit still uses the **IP + port** HTTP protocol, the browser will consider it insecure, and in this case, the RUM data of the application cannot be reported to Guance.

This article will use **Nginx's SSL** to enable the server's HTTPS.

## Prerequisites

- A cloud host with CentOS 7.9
- An Alibaba Cloud domain name that has been resolved to the cloud host's port 80
- The cloud host has already <[installed DataKit](../../datakit/datakit-install.md)>

## Procedure

???+ warning

    **The current example uses DataKit version `1.4.20` (latest version), Nginx version is `1.22.1` for testing**

### 1 Install Nginx

#### 1.1 Install yum-utils Package

Log in to the cloud host and execute the following command.

```
yum install yum-utils -y
```

#### 1.2 Create nginx.repo

Create a `/etc/yum.repos.d/nginx.repo` file with the following content.

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

#### 1.3 Execute Installation Command

```
yum install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl status nginx
```

When you see "running," it indicates that Nginx has been successfully installed.

![image.png](../images/datakit-https-1.png)

#### 1.4 Check SSL Module

Enter `nginx -V`, and if the output contains `--with-http_ssl_module`, it means the SSL module is installed.

![image.png](../images/datakit-https-2.png)

### 2 Download Certificate

#### 2.1 Download SSL Certificate

Log in to "Alibaba Cloud" - "Digital Certificate Management Service" - "SSL Certificate" to create a free certificate.<br/>
After the certificate creation is successful, find Nginx and click "Download."

![image.png](../images/datakit-https-3.png)

#### 2.2 Upload Certificate

Unzip the SSL certificate and upload `7279093_www.zzdskj.cn.key` and `7279093_www.zzdskj.cn.pem` to the `/opt/key` directory of the cloud host.

![image.png](../images/datakit-https-4.png)

#### 2.3 Modify Nginx Configuration File

Edit the `/etc/nginx/conf.d/default.conf` file and input the following content.<br/>
Port 443 will be redirected to DataKit's port 9529.

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

#### 2.4 Reload Configuration

Execute the following command.

```
nginx -s reload
```

### 3 Verification

Enter the domain name with HTTPS in the browser, and if you see the following interface, it indicates that the configuration is successful.

![image.png](../images/datakit-https-5.png)