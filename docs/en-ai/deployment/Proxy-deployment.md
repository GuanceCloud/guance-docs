# Guance Agent Deployment

## Prerequisites

Download docker-nginx.tar.gz 

Resource package download address [Download](https://static.guance.com/dataflux/package/docker-nginx.tar.gz)

## Install Docker

### 1. Extract the installation package

```shell
tar -xvf docker-nginx.tar.gz
```

### 2. Installation

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

### 3. Check Status

```shell
systemctl status docker
```

### 4. Import Nginx Image

```shell
docker load -i nginx.tar
```

## Configure Nginx

Modify the following configuration and save it to the `/data/nginx/conf.d` directory, named **`dataflux.conf`**
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

## Run Nginx Service

```shell
docker run -d --name -p 80:80 -v /data/nginx/conf.d:/etc/nginx/conf.d nginx
```

## Verify Deployment

Execute the verification command (on the host machine):
???+ success ""
    ```shell
    curl -H 'Host:dataflux.dataflux.cn' http://127.0.0.1
    ```