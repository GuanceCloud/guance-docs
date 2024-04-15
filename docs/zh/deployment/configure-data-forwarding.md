# 配置部署版数据转发

## 简介

本文将展示如何配置观测云部署版配置数据转发。


## 前置条件
* 已完全初始化观测云
* 拥有对应云厂商可配置用户、存储桶权限的账号

## 配置步骤
### 步骤一：配置存储桶与账号

#### 华为云
* 创建存储用户
![adduser-1](img/hw-adduser-1.jpg)
![adduser-2](img/hw-adduser-2.jpg)
* 保存ak、sk，后续配置到服务中
![adduser-3](img/hw-adduser-3.jpg) 
* 创建并行文件系统
![createobs-1](img/hw-createobs-1.jpg)
* 配置文件系统访问权限控制
![createibs-2](img/hw-createobs-2.jpg)


#### 阿里云
* 创建存储用户
![adduer-1](img/ali-adduser-1.jpg)
* 保存ak、sk，后续配置到服务中
![adduer-2](img/ali-adduser-2.jpg)
* 创建oss存储桶
![createoss-1](img/ali-createoss-1.jpg)
* 为创建的用户授予oss桶权限
![createoss-2](img/ali-createoss-2.jpg)

#### AWS
* 创建s3存储桶
![creates3-1](img/aws-creates3-1.jpg)
* 创建用户权限策略
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::bucket-name",
                "arn:aws:s3:::bucket-name/*"
            ]
        }
    ]
}

```
![createpolicy-1](img/aws-createpolicy-1.jpg)
* 创建存储用户
![createuer-1](img/aws-createuser-1.jpg)
* 给新创建的用户绑定策略
![createuer-2](img/aws-createuser-2.jpg)
* 创建并保存ak、sk，后续配置到服务中
![createak-1](img/aws-createak-1.jpg)
![createak-2](img/aws-createak-2.jpg)

#### MinIO
* 创建存储桶
![](img/minio-bucket-1.png)
![](img/minio-bucket-2.png)
* 创建策略
![](img/minio-policy-1.png)
![](img/minio-policy-2.png)
```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::bucketname",
                "arn:aws:s3:::bucketname/*"
            ]
        }
    ]
}
```
* 创建用户并保存用户ak、sk，后续配置到服务中
![](img/minio-user-1.png)
![](img/minio-user-2.png)
![](img/minio-user-3.png)
![](img/minio-user-4.png)
### 步骤二：修改服务配置
需要修改kodo、kodo-x等应用服务的配置让转储配置生效

* 修改forethought-kodo命名空间下名称为kodo、kodo-x、kodo-inner的configmap资源。添加以下内容

  公有云存储桶配置
```yaml
backup_log:
  ${store_type}:
    ak: "LTAI5tMxxxxxxxxFroj"
    sk: "6MpS1gxxxxxxxxxxxxxxxxUoH6"
    region: "cn-northwest-1"
    bucket: "guance-backuplog"
  guance:
    store_type: "obs" 

1. ${store_type} 在 oss、s3、obs 中选择一项，分别对应阿里云、AWS、华为云存储桶服务
2. guance.store_type 决定实际使用哪个厂商的存储服务，该值应与${store_type}相同
3. 当${store_type}为 s3 时，多一个配置项：partition。如果是 AWS 国内，该值为aws-cn，国外 AWS 则为 aws
``` 
  私有云存储桶配置
```yaml
backup_log:
  ${store_type}:
    ak: "LTAI5tMxxxxxxxxFroj"
    sk: "6MpS1gxxxxxxxxxxxxxxxxUoH6"
    endpoint: "xxxxx"
    bucket: "guance-backuplog"
  guance:
    store_type: "obs"

1. ${store_type} 在 oss、s3、obs、minio 中选择一项,分别对应阿里云、AWS、华为云存储桶以及 minio 存储服务
2. guance.store_type 决定实际使用哪个厂商的存储服务，该值应与${store_type}相同
3. 私有存储服务多了一个配置项：endpoint，值为提供存储桶服务的 endpoint 信息
```

* 修改完成后，重启kodo、kodo-x、kodo-inner、kodo-x-backuplog服务
???+ warning "注意"
     kodo-x-backuplog服务在集群里为Statefulset类型，该服务需要开启数据持久化，并且每个pod都使用独立的PVC，可以与下图中的配置进行对比
![statefulset-1](img/backuplog-statefulset-1.jpg)
![pvc-1](img/backuplog-pvc-1.jpg)


### 步骤三：数据转发配置
当上述步骤都完成后需要登录到观测云中，进行数据转发的配置，配置完成后，可以参考 [数据转发](../management/backup.md) 进行验证
![config-1](img/config-1.jpg)



