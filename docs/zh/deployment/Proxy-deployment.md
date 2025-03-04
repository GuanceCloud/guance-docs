# <<< custom_key.brand_name >>>代理部署

## 安装前提

下载 docker-nginx.tar.gz 

资源包下载地址[Download]( https://<<< custom_key.static_domain >>>/dataflux/package/docker-nginx.tar.gz)
## 安装 docker

### 1. 解压安装包

```shell
tar -xvf docker-nginx.tar.gz
```

### 2. 安装

```shell
cp -rf docker/* /usr/bin
cat <<EOF> /usr/lib/systemd/system/docker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service containerd.service
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP \$MAINPID
TimeoutSec=0
RestartSec=2
Restart=always
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
mkdir /etc/docker
cat <<EOF> /etc/docker/daemon.json
{
  "registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl enable docker
systemctl start docker
```

### 3. 查看状态

```shell
systemctl status docker
```

### 4. 导入 nginx 镜像

```shell
docker load -i nginx.tar
```



## 配置 nignx

修改以下配置，并保存到 `/data/nginx/conf.d` 目录下，名称为 **`dataflux.conf`**
???+ example ""
    ```shell
    upstream httpbakend {
    server 192.168.100.101:32280;
    server 192.168.100.102:32280;
    server 192.168.100.103:32280;
    }

    server {
      listen 80;
      server_name *.dataflux.cn;
      location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://httpbakend;
      }
    }
    ```

## 运行 nginx 服务

```shell
docker run -d --name -p 80:80 -v /data/nginx/conf.d:/etc/nginx/conf.d nginx
```

## 验证部署

执行验证命令(宿主机)：
???+ success ""
    ```shell
    curl -H 'Host:dataflux.dataflux.cn' http://127.0.0.1
    ```

