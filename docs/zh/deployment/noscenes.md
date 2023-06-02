## 访问日志、链路等页面报“视图模板不存在”

### 能访问公网情况

1、进入`forethought-core Namespace` 下的 `inner` 容器中

```shell
kubectl exec -ti -n forethought-core <inner_pod_name> -- /bin/bash
```

2、查看 `/config/cloudcare-forethought-backend/sysconfig/staticFolder` 目录下是否含有 `dataflux-template` 以及 `dataflux-template-en` 目录。

3、如果没有的话可以手动执行同步本地命令

```shell
# 从公网 模板同步到本地和数据库
curl 'http://0.0.0.0:5000/api/v1/inner/upgrade/tasks/execute_task_func' \
-H 'Content-Type: application/json' \
--data-raw $'{"script_name": "timed_sync_integration", "func_name": "execute_update_integration
", "funcKwargs": {"dir_names": ["dataflux-template", "dataflux-template-en"], "need_sync_integration
": true}}' \
--compressed
```

### 不能访问公网的情况

1、进入`forethought-core Namespace` 下的 `inner` 容器中

2、查看 `/config/cloudcare-forethought-backend/sysconfig/staticFolder` 目录下是否含有 `dataflux-template` 以及 `dataflux-template-en` 目录。

3、执行以下同步命令，会将数据包中的 模版等数据复制到 工作目录下，然后自动发送更新任务（从工作目录同步到数据库中）

```shell
curl 'http://0.0.0.0:5000/api/v1/inner/system/init_data' \
-H 'Content-Type: application/json' \
--data-raw $'{}' \
--compressed
```

> 注意：以上命令有风险，如果目标目录已存在，则会先删除目录再复制目录

