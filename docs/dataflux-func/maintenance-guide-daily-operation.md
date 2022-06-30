# 维护手册 - 日常维护
---


本文主要介绍 DataFlux Func 在日常使用中的维护操作。

默认情况下，安装目录为`/usr/local/dataflux-func`

## 1. 升级系统

*注意：如果最初安装时指定了不同安装目录，升级时也需要指定完全相同的目录才行*

*注意：千万不要随便删除以前的目录，有任何更改，请务必保存好之前的所有配置文件*

需要升级时，请按照以下步骤进行：

1. 使用`docker stack rm dataflux-func`命令，移除正在运行的服务（此步骤可能需要一定时间）
2. 使用`docker ps`确认所有容器都已经退出
3. 按照全新安装步骤，指定`--install-dir`参数安装到相同目录即可（脚本会自动继承以前的数据，不会删除原来的数据）

## 2. 重启系统

需要重新启动时，请按照以下步骤进行：

1. 使用`docker stack rm dataflux-func`命令，移除正在运行的服务（此步骤可能需要一定时间）
2. 使用`docker ps`确认所有容器都已经退出
3. 使用`docker stack deploy dataflux-func -c {安装目录}/docker-stack.yaml --resolve-image never`重启所有服务

> 提示：由于「携带版」本身已经将镜像导入本地，加上`--resolve-image never`参数可以避免 Docker 在启动容器时进行无意义的镜像检查

## 3. 查看 Docker Stack 配置

默认情况下，Docker Stack 配置文件保存位置如下：

| 环境     | 文件位置                       |
| -------- | ------------------------------ |
| 宿主机内 | `{安装目录}/docker-stack.yaml` |

## 4. 查看 DataFlux Func 配置

默认情况下，配置文件保存位置如下：

| 环境     | 文件位置                           |
| -------- | ---------------------------------- |
| 容器内   | `/data/user-config.yaml`           |
| 宿主机内 | `{安装目录}/data/user-config.yaml` |

## 5. 查看资源文件目录

默认情况下，资源文件目录保存位置如下：

| 环境     | 目录位置                     |
| -------- | ---------------------------- |
| 容器内   | `/data/resources/`           |
| 宿主机内 | `{安装目录}/data/resources/` |

资源文件目录可能包含以下内容：

| 宿主机目录位置                                    | 说明                                                 |
| ------------------------------------------------- | ---------------------------------------------------- |
| `{安装目录}/data/resources/extra-python-packages` | 通过 UI 界面「PIP 工具」安装的额外 Python 包存放位置 |
| `{安装目录}/data/resources/uploads`               | 通过接口上传文件的临时存放目录（会自动回卷清理）     |

开发者/用户也可以自行将所需的其他资源文件存放在`{安装目录}/data/resources`下，
以便在脚本中读取使用。

*以上目录程序会自动创建*

## 6. 查看日志

默认情况下，日志文件保存位置如下：

| 环境     | 文件位置                                 |
| -------- | ---------------------------------------- |
| 容器内   | `/data/logs/dataflux-func.log`           |
| 宿主机内 | `{安装目录}/data/logs/dataflux-func.log` |

默认情况下，日志文件会根据 logrotate 配置自动回卷并压缩保存
（logrotate 配置文件位置为`/etc/logrotate.d/dataflux-func`）

## 7. 数据库自动备份

*注意：本功能通过`mysqldump`备份数据库，连接数据库的 MySQL 用户需要足够的权限才能正常备份（包括`SELECT`, `RELOAD`, `LOCK TABLES`, `REPLICATION CLIENT`, `SHOW VIEW`, `PROCESS`）*

DataFlux Func 会定期自动备份完整的数据库为 sql 文件

默认情况下，数据库备份文件保存位置如下：

| 环境     | 文件位置                                                            |
| -------- | ------------------------------------------------------------------- |
| 容器内   | `/data/sqldump/dataflux-func-sqldump-YYYYMMDD-hhmmss.sql`           |
| 宿主机内 | `{安装目录}/data/sqldump/dataflux-func-sqldump-YYYYMMDD-hhmmss.sql` |

> 提示：旧版本的备份文件命名可能为`dataflux-sqldump-YYYYMMDD-hhmmss.sql`

默认情况下，数据库备份文件每小时整点备份一次，最多保留 7 天（共 168 份）

## 8. 卸载

*注意：卸载前，请使用脚本集导出功能导出相关数据*

需要卸载时，可以使用以下命令进行卸载：

```shell
# 移除正在运行的 DataFlux Func
sudo docker stack rm dataflux-func

# 删除 DataFlux Func 数据目录
sudo rm -rf {安装目录}
```

## 9. 参数调整

默认的参数主要应对最常见的情况，一些比较特殊的场景可以调整部分参数来优化系统：

| 参数                          | 默认值    | 说明                                                                                                        |
| ----------------------------- | --------- | ----------------------------------------------------------------------------------------------------------- |
| `LOG_LEVEL`                   | `WARNING` | 日志等级。<br>可以改为`ERROR`减少日志输出量。<br>或直接改为`NONE`禁用日志                                   |
| `_WORKER_CONCURRENCY`         | `5`       | 工作单元进程数量。<br>如存在大量慢 IO 任务（耗时大于 1 秒），可改为`20`提高并发量，但不要过大，防止内存耗尽 |
| `_WORKER_PREFETCH_MULTIPLIER` | `10`      | 工作单元任务预获取数量。<br>如存在大量慢速任务（耗时大于 1 秒），建议改为`1`                                |

## 10. 迁移数据库

如系统安装后通过了最初的单机验证阶段，
需要将数据库切换至外部数据库（如：阿里云 RDS、Redis），
可根据以下步骤进行操作：

*注意：当使用外部数据库时，应确保 MySQL 版本为 5.7，Redis 版本为 4.0 以上*

*注意：DataFlux Func 不支持集群部署的 Redis*

1. 在外部数据库实例中创建数据库，且确保如下配置项：
    - `innodb-large-prefix=on`
    - `character-set-server=utf8mb4`
    - `collation-server=utf8mb4_unicode_ci`
2. 根据上文「数据库自动备份」找到最近的 MySQL 数据库备份文件，将其导入外部数据库
3. 根据上文「查看 DataFlux Func 配置」找到配置文件，并根据实际情况修改以下字段内容：
    - `MYSQL_HOST`
    - `MYSQL_PORT`
    - `MYSQL_USER`
    - `MYSQL_PASSWORD`
    - `MYSQL_DATABASE`
    - `REDIS_HOST`
    - `REDIS_PORT`
    - `REDIS_DATABASE`
    - `REDIS_PASSWORD`
4. 根据上文「查看 Docker Stack 配置」找到 Docker Stack 文件，删除其中的 MySQL 和 Redis 相关部分（注释掉即可）
5. 根据上文「重启系统」重启即可

## 11. 高可用部署

DataFlux Func 支持多份部署以满足高可用要求。

以阿里云为例，可使用「SLB + ECS x 2 + RDS(MySQL) + RDS(Redis)」方式进行部署。

如果开发涉及到服务器端文件处理（如上传文件，文件服务等）、额外安装 Python 包，
则需要额外配置 NFS/NAS 作为文件共享存储。
并将共享挂载到 ECS 的`{安装目录}/data/resources`目录。

![](maintenance-guide/high-availability-arch.png)

参考部署步骤：

1. 在 ECS-1 正常安装 DataFlux Func，并配置连接外部 RDS 和 Redis
2. 在 ECS-2 正常安装 DataFlux Func，复制 ECS-1 的配置文件并覆盖 ECS-2 的配置文件，并去除`beat`服务，重启 ECS-2 的服务

*注意：全局范围内`beat`服务有且只能存在 1 个，高可用部署时注意只能在某一台 ECS 上开启`beat`服务*

*注意：选择 Redis 的高可用方案时，请勿使用「集群版 Redis」，可以使用「主从版 Redis」*

*注意：如之前已经使用单机方式安装过 DataFlux Func，在切换为高可用部署时，请参考上文「5.8 迁移数据库」进行迁移*

*注意：本方案为最简单的多份部署方案，由于 ECS-1 与 ECS-2 之间并不通讯，因此涉及到安装额外 Python 包、上传文件等处理时，需要使用共享文件存储*

## 12. 导出/导入 MySQL 数据

除了 DataFlux Func 自带的定期数据库备份，
也可以直接使用`mysqldump`导出和导入数据。

导出操作的具体命令如下：

```shell
sudo docker exec {MySQL 容器 ID} sh -c 'exec mysqldump --user=root --password="$MYSQL_ROOT_PASSWORD" --hex-blob --default-character-set=utf8mb4 --skip-extended-insert --databases dataflux_func' > {宿主机上的备份文件}
```

导入操作的具体命令如下：

```shell
sudo docker exec -i {MySQL 容器 ID} sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < {宿主机上的备份文件}
```

## 13. 进入 Redis 终端

如需要直接操作 Redis，可以直接进入 Redis 终端进行操作。

具体命令如下：

```shell
sudo docker exec -it {Redis 容器 ID} sh -c 'exec redis-cli -n 5'
```

> 提示：DataFlux Func 默认使用 Redis 的 5 号数据库

### 13.1 清理工作队列

DataFlux Func 中工作队列命名规则为`DataFluxFunc-worker#workerQueue@{0~9 序号}`。

> 如：`DataFluxFunc-worker#workerQueue@1`

如需要直接清理工作队列，可以参考以下命令

- 如，查看 1 号队列的长度：

```shell
LLEN "DataFluxFunc-worker#workerQueue@1"
```

- 如，清空 1 号队列：

```shell
LTRIM "DataFluxFunc-worker#workerQueue@1" -1 0
```

## 14. 管理员工具

DataFlux Func 也提供了管理员工具，方便进行一些应急维护工作。

管理员工具附带在容器中，需要使用 Docker exec 方式运行：

```shell
sudo docker exec {任意 DataFlux Func 容器 ID} sh -c 'exec python admin-tool.py --help'
```

### 14.1 重置管理员密码

普通用户的密码可以由系统管理员直接重新设置，
但系统管理员本身的密码如果忘记，需要使用 DataFlux Func 附带的管理员工具进行重置。

具体命令如下：

- 容器外

```shell
sudo docker exec -it {任意 DataFlux Func 容器 ID} sh -c 'exec python admin-tool.py reset_admin'
```

- 容器内

```shell
cd /usr/src/app; python admin-tool.py reset_admin
```

修改示例：

```
Enter new Admin username: admin               # 指定管理员用户名（这里是 admin）
New password:                                 # 指定管理员新密码
Confirm new password:                         # 重复管理员新密码
Are you sure you want to do this? (yes/no):   # 输入 yes 表示确认修改
```

### 14.2 重置数据库更新序号

DataFlux Func 在安装/升级时，会自动更新数据库结构，并记录当前数据库结构版本序号。

在某些情况下，这个序号如果不正确，会导致系统无法正常启动，此时需要使用管理员工具修正。

具体命令如下：

- 容器外

```shell
sudo docker exec -it {任意 DataFlux Func 容器 ID} sh -c 'exec python admin-tool.py reset_db_upgrade_seq'
```

- 容器内

```shell
cd /usr/src/app; python admin-tool.py reset_db_upgrade_seq
```

*注意：如果您不知道这是什么，请咨询官方后再进行操作*

### 14.3 清空 Redis

在某些情况下（如：队列堵塞需要立即恢复，脚本不合理的逻辑导致缓存过大等），
可以使用以下命令，清空 Redis 数据库。

具体命令如下：

- 容器外

```shell
sudo docker exec -it {任意 DataFlux Func 容器 ID} sh -c 'exec python admin-tool.py clear_redis'
```

- 或容器内

```shell
cd /usr/src/app; python admin-tool.py clear_redis
```

*注意：清空 Redis 不会对 DataFlux Func 本身运行带来问题。但运行中的业务代码可能会依赖 Redis 中的数据，请务必确认后进行操作*

## 15. 在容器内绑定 hosts

某些情况下，一些域名没有 DNS 解析，需要修改 hosts 后访问，
那么可以在`docker-stack.yaml`中，`worker-xxx`的服务添加`extra_hosts`内容实现，如：

```yaml
...
services:
  ...
  worker-1-6:
    ...
    extra_hosts:
      - "somehost:1.2.3.4"
      - "otherhost:5.6.7.8"
```

添加上述配置后那么，等同于在`/etc/hosts`中配置了如下内容：

```
somehost    1.2.3.4
otherhost   5.6.7.8
```

- [参考文档：Docker Compose 文件中的 extra_hosts 选项](https://docs.docker.com/compose/compose-file/compose-file-v3/#extra_hosts)
