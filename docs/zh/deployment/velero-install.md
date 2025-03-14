# <<< custom_key.brand_name >>>集群备份和恢复

???+ warning "注意事项"

     本文介绍的 Velero 备份的是 Kubernetes 配置（YAML 文件），不包含 PVC 卷的数据。

## 简介 {#intro}

Velero 是一个开源工具，可以安全地备份和还原，执行灾难恢复以及迁移 Kubernetes 集群资源和持久卷。

- 灾难恢复
  Velero 可以在基础架构丢失，数据损坏和/或服务中断的情况下，减少恢复时间。

- 数据迁移
  Velero 通过轻松地将 Kubernetes 资源从一个集群迁移到另一个集群来实现集群可移植性

- 数据保护
  提供关键数据保护功能，例如定时计划的备份，保留计划以及自定义操作的备份前或备份后钩子。

- 备份集群
  使用 namespace resources 或 label selector 备份整个集群或部分集群的 Kubernetes 资源和卷。

- 定期备份
  设置计划以定期间隔自动启动备份。

- 备份钩子
  配置备份前和备份后钩子，以在 Velero 备份之前和之后执行自定义操作。

## 基础信息及兼容 {#information}

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|     Velero 版本     |                    1.13.0                |
|    是否支离线安装    |                       是                        |
|       支持架构       |                   amd64/arm64                   |


## 离线清单 {#download-list}

|     名称     |                   下载地址                   |
| :------------------: | :---------------------------------------------: |
|     Velero-cli  |                [Amd 下载](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz)<br>[Arm 下载](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz)                |
| Velero 镜像 | [Amd 下载](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-amd64.tar.gz)<br/>[Arm 下载](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-arm64.tar.gz) |


### 镜像导入 {#image-load}

=== "Docker Amd"
    
    ```shell
     gunzip -c velero-amd64.tar.gz | docker load
    ```

=== "Containterd Amd"

    ```shell
    gunzip velero-amd64.tar.gz
    ctr -n=k8s.io images import velero-amd64.tar
    ```
=== "Docker Arm"
    
    ```shell
     gunzip -c velero-arm64.tar.gz | docker load
    ```

=== "Containterd Arm"

    ```shell
    gunzip velero-arm64.tar.gz
    ctr -n=k8s.io images import velero-arm64.tar
    ```


## 先决条件 {#prerequisite}

- 已部署 Kubernetes 集群，未部署可参考 [Kubernetes 部署](infra-kubernetes.md)，并且可以使用 kubectl 控制集群。

## 安装 Velero {#install}


### 对象存储设置 {#object-storage-settings}


=== "S3"
    
    #### 创建 S3 桶
    
    Velero 需要一个对象存储桶来存储备份，最好是单个 Kubernetes 集群唯一的对象存储桶(参见[FAQ](https://velero.io/docs/faq/)了解更多细节)。创建一个S3桶，适当替换占位符:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    aws s3api create-bucket \
        --bucket $BUCKET \
        --region $REGION \
        --create-bucket-configuration LocationConstraint=$REGION
    ```
    
    > us-east-1 不支持 LocationConstraint。如果您的区域是us-east-1，则省略bucket配置:
    
    ```shell
    aws s3api create-bucket \
        --bucket $BUCKET \
        --region us-east-1
    ```
    
    #### 为 Velero 设置权限
    
    以下方法为通过 IAM 用户设置权限，其他方式请参考[使用kube2iam设置权限](https://github.com/vmware-tanzu/velero-plugin-for-aws?tab=readme-ov-file#option-2-set-permissions-using-kube2iam)。
    
    有关更多信息，请参阅[AWS关于IAM用户的文档](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)。
    
    1.创建 IAM 用户:
    
    ```shell
    aws iam create-user --user-name velero
    ```
    > 如果您将使用Velero备份具有多个S3桶的多个集群，那么最好为每个集群创建唯一的用户名，而不是默认的Velero。
    
    2.附加策略以赋予 `velero` 必要的权限:
    
    ```shell
    cat > velero-policy.json <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:DescribeVolumes",
                    "ec2:DescribeSnapshots",
                    "ec2:CreateTags",
                    "ec2:CreateVolume",
                    "ec2:CreateSnapshot",
                    "ec2:DeleteSnapshot"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:GetObject",
                    "s3:DeleteObject",
                    "s3:PutObject",
                    "s3:AbortMultipartUpload",
                    "s3:ListMultipartUploadParts"
                ],
                "Resource": [
                    "arn:aws:s3:::${BUCKET}/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListBucket"
                ],
                "Resource": [
                    "arn:aws:s3:::${BUCKET}"
                ]
            }
        ]
    }
    EOF
    ```
    
    ```shell
    aws iam put-user-policy \
      --user-name velero \
      --policy-name velero \
      --policy-document file://velero-policy.json
    ```
    
    3.为用户创建一个 access key:
    
    ```shell
    aws iam create-access-key --user-name velero
    ```
    
    期望预期：
    
    ```shell
    {
      "AccessKey": {
            "UserName": "velero",
            "Status": "Active",
            "CreateDate": "2017-07-31T22:24:41.576Z",
            "SecretAccessKey": <AWS_SECRET_ACCESS_KEY>,
            "AccessKeyId": <AWS_ACCESS_KEY_ID>
      }
    }
    ```
    
    4.在本地目录中创建一个 velero 特定的凭据文件(`credentials-velero`):
    
    ```shell
    [default]
    aws_access_key_id=<AWS_ACCESS_KEY_ID>
    aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>
    ```

=== "OSS"
    
    #### 创建 OSS 桶
    
    Velero 需要一个对象存储桶来存储备份，最好是单个 Kubernetes 集群唯一的。创建一个 OSS 桶，适当替换占位符:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    ossutil mb oss://$BUCKET \
            --storage-class Standard \
            --acl=private
    ```
     
    #### 创建 RAM 用户
    
    1.创建用户
    
    请参阅阿里云文档中的[RAM用户指南](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user?spm=5176.28426678.J_HeJR_wZokYt378dwP-lLl.1.311651810ngbyx&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@93720.S_BB1@bl+RQW@ag0+BB2@ag0+os0.ID_93720-RL_%E5%88%9B%E5%BB%BARAM%E7%94%A8%E6%88%B7-LOC_search~UND~helpdoc~UND~item-OR_ser-V_3-P0_0)。
       
    > 如果您将使用Velero备份具有多个 OSS bucket 的多个集群，那么最好为每个集群创建一个唯一的用户名，而不是默认的 Velero。
    
    2.附加策略以赋予 velero 必要的权限:
    
    > 注意，出于安全原因，您最好在完成备份或恢复任务后释放 velero 的删除权限。
    
    ```shell
    {
        "Version": "1",
        "Statement": [
            {
                "Action": [
                    "ecs:DescribeSnapshots",
                    "ecs:CreateSnapshot",
                    "ecs:DeleteSnapshot",
                    "ecs:DescribeDisks",
                    "ecs:CreateDisk",
                    "ecs:Addtags",
                    "oss:PutObject",
                    "oss:GetObject",
                    "oss:DeleteObject",
                    "oss:GetBucket",
                    "oss:ListObjects",
                    "oss:ListBuckets"
                ],
                "Resource": [
                    "*"
                ],
                "Effect": "Allow"
            }
        ]
    }
    ```
    3.为用户创建一个访问键:
    
    请参阅阿里云文档中的[创建AK](https://help.aliyun.com/zh/ram/user-guide/create-an-accesskey-pair?spm=a2c4g.11186623.0.0.77714c5cX1UXZe)。


    4.在您的安装目录中创建一个 velero 特定的凭据文件(`credentials-velero`):
    
    ```shell
    ALIBABA_CLOUD_ACCESS_KEY_ID=<ALIBABA_CLOUD_ACCESS_KEY_ID>
    ALIBABA_CLOUD_ACCESS_KEY_SECRET=<ALIBABA_CLOUD_ACCESS_KEY_SECRET>
    ```

### 安装 Velero CLI 并 配置 {#install-config}

#### 安装 CLI {#install-cli}

=== "Amd"

    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz && tar -xvf velero-v1.13.0-linux-amd64.tar.gz && mv velero-v1.13.0-linux-amd64/velero /bin
    ```

=== "Arm"


    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz && tar -xvf velero-v1.13.0-linux-arm64.tar.gz && mv velero-v1.13.0-linux-arm64/velero /bin
    ```

#### 离线安装（可选） CLI {#install-download-cli}

=== "Amd"

    ```shell
    tar -xvf velero-v1.13.0-linux-amd64.tar.gz && mv velero-v1.13.0-linux-amd64/velero /bin
    ```

=== "Arm"


    ```shell
    tar -xvf velero-v1.13.0-linux-arm64.tar.gz && mv velero-v1.13.0-linux-arm64/velero /bin
    ```


#### 验证安装 {#check-cli}

```shell

velero -h

```


#### 启动 {#running}

=== "S3"

    设置一些环境变量：
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    BUCKETPATH=<YOUR_BUCKETPATH>
    ```
    
    执行初始化命令：
    
    ```
    velero install \
        --provider aws \
        --image pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/velero:v1.13.0 \    
        --plugins pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/velero-plugin-for-aws:v1.9.0 \
        --bucket $BUCKET \
        --backup-location-config region=$REGION \
        --snapshot-location-config region=$REGION \
        --secret-file ./credentials-velero \
        --prefix $BUCKETPATH \    
        --backup-location-config s3ForcePathStyle="true",s3Url=https://s3.$BUCKET.amazonaws.com.cn     
    ```
    
    > 如果海外节点，请修改 s3Url 为 `https://s3.$BUCKET.amazonaws.com` 

=== "OSS"

    设置一些环境变量：
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    BUCKETPATH=<YOUR_BUCKETPATH>
    ```
    
    执行初始化命令：
    
    ```
    velero install \
      --provider alibabacloud \
      --image pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/velero:v1.13.0 \
      --bucket $BUCKET \
      --secret-file ./credentials-velero \
      --use-volume-snapshots=false \
      --backup-location-config region=$REGION \
      --prefix $BUCKETPATH \
      --plugins pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/velero-plugin-alibabacloud:v1.9.6-581f313-aliyun
    ```

#### 验证 {#check-velero}

##### 创建测试服务 {#create-test}

```shell
kubectl create deployment demo --image=nginx
kubectl get pod
```

##### 备份 {#create-backup}

执行备份命令：

```shell
velero backup create demo
```

查看备份命令：

```shell
$ velero get backup
NAME   STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
demo   Completed   0        0          2024-03-04 18:31:28 +0800 CST   29d       default            <none>
```


##### 删除并恢复测试 {#check-backup-restore}

删除服务：

```shell
$ kubectl delete -n default deploy demo

deployment.apps "demo" deleted
```

恢复：

```shell
$ velero restore create --from-backup demo --include-namespaces default --selector app=demo

Restore request "demo-20240304184105" submitted successfully.
Run `velero restore describe demo-20240304184105` or `velero restore logs demo-20240304184105` for more details.
```

> velero restore create --from-backup {{backup_name}} --restore-volumes --include-namespaces {{namespace_name}} --selector app={{app_label}}

查看：

```shell
$ kubectl get pod
NAME                    READY   STATUS    RESTARTS   AGE
demo-68b4b4d5bf-qxr26   1/1     Running   0          46s
```

## 设置定时备份 {#create-schedule}

每天凌晨备份（不备份 PVC 数据），保留 7 天

```shell
$ velero create schedule all-guance  --schedule="0 01 * * *"  --ttl 168h
$ velero get schedule

NAME         STATUS    CREATED                         SCHEDULE    BACKUP TTL   LAST BACKUP   SELECTOR   PAUSED
all-guance   Enabled   2024-03-04 18:44:55 +0800 CST   0 1 * * *   168h0m0s     n/a           <none>     false
```

## 卸载 {#uninstall}


```shell

rm -f /bin/velero

velero uninstall

```



## 其他 {#other}


### 相关命令 {#related-command}

```shell
velero  get  backup   #备份查看
velero  get  schedule #查看定时备份
velero  get  restore  #查看已有的恢复
velero  get  plugins  #查看插件
velero restore create --from-backup all-ns-backup  #恢复集群所有备份，（对已经存在的服务不会覆盖）
velero restore create --from-backup all-ns-backup --include-namespaces default,nginx-example #仅恢复 default nginx-example namespace

Velero可以将资源还原到与其备份来源不同的命名空间中。为此，请使用--namespace-mappings标志
velero restore create RESTORE_NAME --from-backup BACKUP_NAME --namespace-mappings old-ns-1:new-ns-1,old-ns-2:new-ns-2
例如下面将test-velero 命名空间资源恢复到test-velero-1下面
velero restore create restore-for-test --from-backup everyday-1-20210203131802 --namespace-mappings test-velero:test-velero-1
#定时备份 
velero create schedule prd-aws-df --schedule="0 1 * * *" --ttl 168h
```

