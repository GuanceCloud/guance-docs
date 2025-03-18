# Scheck Connection to Alibaba Cloud Log Service Solution

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Prerequisites

- Have Alibaba Cloud RAM management permissions
- Scheck version greater than v1.0.1


## Obtain Alibaba Cloud Log Service Key
[Alibaba Cloud Official Documentation](https://help.aliyun.com/document_detail/29009.html?spm=a2c4g.11186623.6.1468.672b693bQhatOa)

- Create a User

  Log in to RAM Access Control - left sidebar [Identity Management - Users] - create user

  Create a user, set the login name to scheck, select *Open API Call Access*

  Make sure to **save** the AccessKey ID and AccessKey Secret.

- Authorization

  Log in to RAM Access Control - left sidebar [Permission Management - Authorization] - add authorization

  Grant AliyunLogFullAccess to the scheck account.

## Configuration Steps

### Modify Configuration

- For Linux hosts, modify `/usr/local/scheck/scheck.conf`; for Windows hosts, modify `C:\\Program Files\\scheck\scheck.conf`

  ```sh
    [scoutput.alisls]
      enable = true # Enable configuration
      endpoint = "cn-hangzhou.log.aliyuncs.com" # Set Alibaba Cloud endpoint
      access_key_id = "LTAI5tHb2vMLV4axxxxxx"  # Obtained from previous step
      access_key_secret = "FNUkk52gWsZHKauXPg24jxxxx" # Obtained from previous step
      project_name = "zhuyun-scheck" # Customizable
      log_store_name = "scheck"      # Customizable
  ```

- Parameter Description
  
  | Parameter Name            | Example Value                         | Required | Description                                          |
  | :------------------ | :----------------------------- | :------: | :-------------------------------------------- |
  | `enable`            | `true`                         | Yes | Configuration switch                                      |
  | `endpoint`          | `cn-hangzhou.log.aliyuncs.com` | Yes | Alibaba Cloud region                                    |
  | `access_key_id`     | `LTAI5tHb2vMLV4axxxxxx`        | Yes | Alibaba Cloud AccessKey ID (AliyunLogFullAccess permission) |
  | `access_key_secret` | `FNUkk52gWsZHKauXPg24jxxxx`    | Yes | Alibaba Cloud AccessKey Secret                        |
  | `project_name`      | `zhuyun-scheck`                | No | Alibaba Cloud Log Service project name                      |
  | `log_store_name`    | `scheck`                       | No | Log store name                                    |

### Restart and Verify

- Restart scheck
  
  ```sh
    $systemctl restart scheck
  ```
  
- Add a new user to test if the configuration is successful

  ```sh
  $ useradd test
  ```

- Check on the [Alibaba Cloud Console](https://sls.console.aliyun.com/lognext/profile), under the zhuyun-scheck project

  ![sls.png](https://security-checker-prod.oss-cn-hangzhou.aliyuncs.com/img/sls.png)

## Grafana Integration with Alibaba Cloud Log Service

[Official Documentation](https://help.aliyun.com/document_detail/60952.html?spm=5176.21213303.J_6028563670.7.65713edaY7xSV2&scm=20140722)

| Software Name                             | Version                                                         | Description           |
| ------------------------------------ | ------------------------------------------------------------ | -------------- |
| grafana                              | 8.0.6                                                        | Open-source visualization software   |
| aliyun-log-grafana-datasource-plugin | [2.8](https://github.com/aliyun/aliyun-log-grafana-datasource-plugin/releases/tag/2.8?spm=a2c4g.11186623.2.13.7a703e0anzkNTh&file=2.8) | Alibaba Cloud Log Service plugin |

### Install Grafana

#### 1. Install Grafana via Docker

```sh
docker run \
	--name=grafana \
	--volume=~/grafana/data/:/var/lib/grafana \
	-p 3000:3000 \
	grafana/grafana:8.0.6
```

#### 2. Install and Configure aliyun-log-grafana-datasource-plugin

~/grafana/data/ as the persistent path

```sh
$wget -o aliyun-log-grafana-datasource-plugin-master.zip  https://github.com/aliyun/aliyun-log-grafana-datasource-plugin/releases/tag/2.8?spm=a2c4g.11186623.2.13.7a703e0anzkNTh&file=2.8
$unzip 2.8.zip
$mv aliyun-log-grafana-datasource-plugin-2.8 ~/grafana/data/plugins/aliyun-log-grafana-datasource-plugin
# Modify configuration
$docker exec -i grafana  sed -i '/;allow_loading_unsigned_plugins/i\allow_loading_unsigned_plugins \= aliyun-log-service-datasource,grafana-log-service-datasource
' /etc/grafana/grafana.ini
# Restart container
$docker restart grafana
```

#### 3. Configure Data Source

- Log in to http://127.0.0.1:3000 with username: admin and password: admin
- Visit http://127.0.0.1:3000/datasources, add a data source and choose log-service-datasource, set Name to sc, and fill in the information below.

#### 4. Import scheck Template

- [Download Template](https://security-checker-prod.oss-cn-hangzhou.aliyuncs.com/img/grafana/zhuyun-scheck-1629358061303.json)

- Visit http://127.0.0.1:3000/dashboard/import and upload the JSON template

![](img/scheck-grafana.png)