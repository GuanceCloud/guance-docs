# Configure Deployment Plan Data Forwarding

## Introduction

This article will demonstrate how to configure <<< custom_key.brand_name >>> Deployment Plan data forwarding.

## Prerequisites
* <<< custom_key.brand_name >>> has been fully initialized.
* You have an account with the necessary permissions for configuring users and storage buckets on the corresponding cloud provider.

## Configuration Steps
### Step One: Configure Storage Bucket and Account

#### Huawei Cloud
* Create a storage user
![adduser-1](img/hw-adduser-1.jpg)
![adduser-2](img/hw-adduser-2.jpg)
* Save the AK and SK, which will be configured in the service later.
![adduser-3](img/hw-adduser-3.jpg) 
* Create a parallel file system
![createobs-1](img/hw-createobs-1.jpg)
* Configure file system access control
![createibs-2](img/hw-createobs-2.jpg)


#### Alibaba Cloud
* Create a storage user
![adduer-1](img/ali-adduser-1.jpg)
* Save the AK and SK, which will be configured in the service later.
![adduer-2](img/ali-adduser-2.jpg)
* Create an OSS bucket
![createoss-1](img/ali-createoss-1.jpg)
* Grant OSS bucket permissions to the created user
![createoss-2](img/ali-createoss-2.jpg)

#### AWS
* Create an S3 bucket
![creates3-1](img/aws-creates3-1.jpg)
* Create a user permission policy
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
* Create a storage user
![createuer-1](img/aws-createuser-1.jpg)
* Attach the policy to the newly created user
![createuer-2](img/aws-createuser-2.jpg)
* Create and save the AK and SK, which will be configured in the service later.
![createak-1](img/aws-createak-1.jpg)
![createak-2](img/aws-createak-2.jpg)

#### MinIO
* Create a storage bucket
![](img/minio-bucket-1.png)
![](img/minio-bucket-2.png)
* Create a policy
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
* Create a user and save the AK and SK, which will be configured in the service later.
![](img/minio-user-1.png)
![](img/minio-user-2.png)
![](img/minio-user-3.png)
![](img/minio-user-4.png)

### Step Two: Modify Service Configuration
Modify the configuration of services like kodo, kodo-x to enable the dump configuration.

* Modify the ConfigMap resources named kodo, kodo-x, and kodo-inner under the forethought-kodo namespace. Add the following content:

  Public cloud storage bucket configuration
```yaml
backup_log:
  ${store_type}:
    ak: "LTAI5tMxxxxxxxxFroj"
    sk: "6MpS1gxxxxxxxxxxxxxxxxUoH6"
    region: "cn-northwest-1"
    bucket: "guance-backuplog"
  guance:
    store_type: "obs" 

1. ${store_type} can be chosen from oss, s3, or obs, corresponding to Alibaba Cloud, AWS, and Huawei Cloud storage bucket services respectively.
2. guance.store_type determines which cloud provider's storage service is actually used, and this value should match ${store_type}.
3. When ${store_type} is s3, there is an additional configuration item: partition. For AWS China, this value is aws-cn; for international AWS, it is aws.
``` 
  Private cloud storage bucket configuration
```yaml
backup_log:
  ${store_type}:
    ak: "LTAI5tMxxxxxxxxFroj"
    sk: "6MpS1gxxxxxxxxxxxxxxxxUoH6"
    endpoint: "xx.xx.com"
    bucket: "guance-backuplog"
  guance:
    store_type: "obs"

1. ${store_type} can be chosen from oss, s3, obs, or minio, corresponding to Alibaba Cloud, AWS, Huawei Cloud storage bucket services, and MinIO storage service respectively.
2. guance.store_type determines which cloud provider's storage service is actually used, and this value should match ${store_type}.
3. **endpoint**: In private cloud storage or dedicated cloud scenarios, an endpoint configuration needs to be added, with the value being the endpoint information for the storage bucket service. Do not include http:// or https://.
```

* After making changes, restart the kodo, kodo-x, kodo-inner, and kodo-x-backuplog services.
???+ warning "Note"
     The kodo-x-backuplog service is of StatefulSet type in the cluster. This service requires data persistence, and each pod uses an independent PVC. Compare with the configurations shown in the following images.
![statefulset-1](img/backuplog-statefulset-1.jpg)
![pvc-1](img/backuplog-pvc-1.jpg)

### Step Three: Data Forwarding Configuration
After completing the above steps, log in to <<< custom_key.brand_name >>> to configure data forwarding. Once the configuration is complete, you can refer to [Data Forwarding](../management/backup/index.md) for verification.
![config-1](img/config-1.jpg)