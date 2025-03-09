# <<< custom_key.brand_name >>> Cluster Backup and Recovery

???+ warning "Precautions"

     This article introduces Velero's backup of Kubernetes configurations (YAML files), which does not include data from PVC volumes.

## Introduction {#intro}

Velero is an open-source tool that securely backs up and restores, performs disaster recovery, and migrates Kubernetes cluster resources and persistent volumes.

- **Disaster Recovery**
  Velero reduces recovery time in the event of infrastructure loss, data corruption, and/or service disruptions.

- **Data Migration**
  Velero achieves cluster portability by easily migrating Kubernetes resources from one cluster to another.

- **Data Protection**
  Provides critical data protection features such as scheduled backups, retention policies, and pre/post-backup hooks for custom operations.

- **Backup Cluster**
  Backs up entire clusters or parts of clusters using namespace resources or label selectors for Kubernetes resources and volumes.

- **Scheduled Backups**
  Set schedules to automatically initiate backups at regular intervals.

- **Backup Hooks**
  Configure pre- and post-backup hooks to execute custom operations before and after Velero backups.

## Basic Information and Compatibility {#information}

| Name          | Description                                          |
| :------------ | :--------------------------------------------------- |
| Velero Version | 1.13.0                                               |
| Offline Installation Support | Yes                                      |
| Supported Architectures | amd64/arm64                                    |

## Offline Inventory {#download-list}

| Name             | Download Address                                                                 |
| :--------------- | :------------------------------------------------------------------------------- |
| Velero-cli       | [Amd Download](https://<<< custom_key.static_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz)<br>[Arm Download](https://<<< custom_key.static_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz) |
| Velero Image     | [Amd Download](https://<<< custom_key.static_domain >>>/dataflux/package/velero-amd64.tar.gz)<br/>[Arm Download](https://<<< custom_key.static_domain >>>/dataflux/package/velero-arm64.tar.gz) |

### Image Import {#image-load}

=== "Docker Amd"
    
    ```shell
     gunzip -c velero-amd64.tar.gz | docker load
    ```

=== "Containerd Amd"

    ```shell
    gunzip velero-amd64.tar.gz
    ctr -n=k8s.io images import velero-amd64.tar
    ```
=== "Docker Arm"
    
    ```shell
     gunzip -c velero-arm64.tar.gz | docker load
    ```

=== "Containerd Arm"

    ```shell
    gunzip velero-arm64.tar.gz
    ctr -n=k8s.io images import velero-arm64.tar
    ```


## Prerequisites {#prerequisite}

- A deployed Kubernetes cluster; if not deployed, refer to [Kubernetes Deployment](infra-kubernetes.md), and ensure kubectl can control the cluster.

## Install Velero {#install}


### Object Storage Setup {#object-storage-settings}


=== "S3"
    
    #### Create S3 Bucket
    
    Velero requires an object storage bucket to store backups, preferably a unique bucket for each Kubernetes cluster (see [FAQ](https://velero.io/docs/faq/) for more details). Create an S3 bucket, replacing placeholders appropriately:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    aws s3api create-bucket \
        --bucket $BUCKET \
        --region $REGION \
        --create-bucket-configuration LocationConstraint=$REGION
    ```
    
    > us-east-1 does not support LocationConstraint. If your region is us-east-1, omit the bucket configuration:
    
    ```shell
    aws s3api create-bucket \
        --bucket $BUCKET \
        --region us-east-1
    ```
    
    #### Set Permissions for Velero
    
    The following method sets permissions via IAM user; other methods can be found in [Setting Permissions Using kube2iam](https://github.com/vmware-tanzu/velero-plugin-for-aws?tab=readme-ov-file#option-2-set-permissions-using-kube2iam).
    
    For more information, see [AWS Documentation on IAM Users](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).
    
    1. Create an IAM user:
    
    ```shell
    aws iam create-user --user-name velero
    ```
    > If you will use Velero to back up multiple S3 buckets across multiple clusters, it's best to create a unique username for each cluster rather than using the default Velero.
    
    2. Attach a policy to grant `velero` necessary permissions:
    
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
    
    3. Create an access key for the user:
    
    ```shell
    aws iam create-access-key --user-name velero
    ```
    
    Expected output:
    
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
    
    4. Create a Velero-specific credential file (`credentials-velero`) in a local directory:
    
    ```shell
    [default]
    aws_access_key_id=<AWS_ACCESS_KEY_ID>
    aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>
    ```

=== "OSS"
    
    #### Create OSS Bucket
    
    Velero requires an object storage bucket to store backups, preferably unique to each Kubernetes cluster. Create an OSS bucket, replacing placeholders appropriately:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    ossutil mb oss://$BUCKET \
            --storage-class Standard \
            --acl=private
    ```
     
    #### Create RAM User
    
    1. Create a user
    
    Refer to the [RAM User Guide](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user?spm=5176.28426678.J_HeJR_wZokYt378dwP-lLl.1.311651810ngbyx&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@93720.S_BB1@bl+RQW@ag0+BB2@ag0+os0.ID_93720-RL_%E5%88%9B%E5%BB%BARAM%E7%94%A8%E6%88%B7-LOC_search~UND~helpdoc~UND~item-OR_ser-V_3-P0_0) in Alibaba Cloud documentation.
       
    > If you will use Velero to back up multiple OSS buckets across multiple clusters, it's best to create a unique username for each cluster rather than using the default Velero.
    
    2. Attach a policy to grant `velero` necessary permissions:
    
    > Note: For security reasons, it's best to revoke delete permissions from Velero after completing backup or restore tasks.
    
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
    3. Create an access key for the user:
    
    Refer to the [Creating AK](https://help.aliyun.com/zh/ram/user-guide/create-an-accesskey-pair?spm=a2c4g.11186623.0.0.77714c5cX1UXZe) section in Alibaba Cloud documentation.


    4. Create a Velero-specific credential file (`credentials-velero`) in your installation directory:
    
    ```shell
    ALIBABA_CLOUD_ACCESS_KEY_ID=<ALIBABA_CLOUD_ACCESS_KEY_ID>
    ALIBABA_CLOUD_ACCESS_KEY_SECRET=<ALIBABA_CLOUD_ACCESS_KEY_SECRET>
    ```

### Install Velero CLI and Configuration {#install-config}

#### Install CLI {#install-cli}

=== "Amd"

    ```shell
    wget https://<<< custom_key.static_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz && tar -xvf velero-v1.13.0-linux-amd64.tar.gz && mv velero-v1.13.0-linux-amd64/velero /bin
    ```

=== "Arm"


    ```shell
    wget https://<<< custom_key.static_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz && tar -xvf velero-v1.13.0-linux-arm64.tar.gz && mv velero-v1.13.0-linux-arm64/velero /bin
    ```

#### Offline Installation (Optional) CLI {#install-download-cli}

=== "Amd"

    ```shell
    tar -xvf velero-v1.13.0-linux-amd64.tar.gz && mv velero-v1.13.0-linux-amd64/velero /bin
    ```

=== "Arm"


    ```shell
    tar -xvf velero-v1.13.0-linux-arm64.tar.gz && mv velero-v1.13.0-linux-arm64/velero /bin
    ```


#### Verify Installation {#check-cli}

```shell
velero -h
```

#### Start {#running}

=== "S3"

    Set some environment variables:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    BUCKETPATH=<YOUR_BUCKETPATH>
    ```
    
    Execute the initialization command:
    
    ```
    velero install \
        --provider aws \
        --image pubrepo.guance.com/googleimages/velero:v1.13.0 \    
        --plugins pubrepo.guance.com/googleimages/velero-plugin-for-aws:v1.9.0 \
        --bucket $BUCKET \
        --backup-location-config region=$REGION \
        --snapshot-location-config region=$REGION \
        --secret-file ./credentials-velero \
        --prefix $BUCKETPATH \    
        --backup-location-config s3ForcePathStyle="true",s3Url=https://s3.$REGION.amazonaws.com.cn     
    ```
    
    > If using an overseas node, modify s3Url to `https://s3.$REGION.amazonaws.com`

=== "OSS"

    Set some environment variables:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    BUCKETPATH=<YOUR_BUCKETPATH>
    ```
    
    Execute the initialization command:
    
    ```
    velero install \
      --provider alibabacloud \
      --image pubrepo.guance.com/googleimages/velero:v1.13.0 \
      --bucket $BUCKET \
      --secret-file ./credentials-velero \
      --use-volume-snapshots=false \
      --backup-location-config region=$REGION \
      --prefix $BUCKETPATH \
      --plugins pubrepo.guance.com/googleimages/velero-plugin-alibabacloud:v1.9.6-581f313-aliyun
    ```

#### Verification {#check-velero}

##### Create Test Service {#create-test}

```shell
kubectl create deployment demo --image=nginx
kubectl get pod
```

##### Backup {#create-backup}

Execute the backup command:

```shell
velero backup create demo
```

Check the backup command:

```shell
$ velero get backup
NAME   STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
demo   Completed   0        0          2024-03-04 18:31:28 +0800 CST   29d       default            <none>
```


##### Delete and Restore Test {#check-backup-restore}

Delete the service:

```shell
$ kubectl delete -n default deploy demo

deployment.apps "demo" deleted
```

Restore:

```shell
$ velero restore create --from-backup demo --include-namespaces default --selector app=demo

Restore request "demo-20240304184105" submitted successfully.
Run `velero restore describe demo-20240304184105` or `velero restore logs demo-20240304184105` for more details.
```

> velero restore create --from-backup {backup_name} --restore-volumes --include-namespaces {namespace_name} --selector app={app_label}

Check:

```shell
$ kubectl get pod
NAME                    READY   STATUS    RESTARTS   AGE
demo-68b4b4d5bf-qxr26   1/1     Running   0          46s
```

## Set Up Scheduled Backups {#create-schedule}

Back up every day at midnight (excluding PVC data), retain for 7 days

```shell
$ velero create schedule all-guance  --schedule="0 01 * * *"  --ttl 168h
$ velero get schedule

NAME         STATUS    CREATED                         SCHEDULE    BACKUP TTL   LAST BACKUP   SELECTOR   PAUSED
all-guance   Enabled   2024-03-04 18:44:55 +0800 CST   0 1 * * *   168h0m0s     n/a           <none>     false
```

## Uninstall {#uninstall}

```shell
rm -f /bin/velero

velero uninstall
```



## Others {#other}

### Related Commands {#related-command}

```shell
velero get backup   # View backups
velero get schedule # View scheduled backups
velero get restore  # View existing restores
velero get plugins  # View plugins
velero restore create --from-backup all-ns-backup  # Restore all cluster backups (existing services are not overwritten)
velero restore create --from-backup all-ns-backup --include-namespaces default,nginx-example # Restore only default and nginx-example namespaces

Velero can restore resources to a different namespace than their backup source. Use the --namespace-mappings flag for this:
velero restore create RESTORE_NAME --from-backup BACKUP_NAME --namespace-mappings old-ns-1:new-ns-1,old-ns-2:new-ns-2
For example, restoring test-velero namespace resources to test-velero-1:
velero restore create restore-for-test --from-backup everyday-1-20210203131802 --namespace-mappings test-velero:test-velero-1
# Scheduled backup 
velero create schedule prd-aws-df --schedule="0 1 * * *" --ttl 168h
```