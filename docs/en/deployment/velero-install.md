# <<< custom_key.brand_name >>> Cluster Backup and Restoration

???+ warning "Precautions"

     This article introduces the Velero backup of Kubernetes configurations (YAML files), which does not include data from PVC volumes.

## Introduction {#intro}

Velero is an open-source tool that can securely back up and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.

- Disaster Recovery
  Velero reduces recovery time in cases of infrastructure loss, data corruption, and/or service disruptions.

- Data Migration
  Velero achieves cluster portability by easily migrating Kubernetes resources from one cluster to another.

- Data Protection
  Provides critical data protection features such as scheduled backups, retention policies, and pre or post-backup hooks for custom operations.

- Backup Clusters
  Backs up entire clusters or parts of clusters using namespace resources or label selectors, including Kubernetes resources and volumes.

- Regular Backups
  Set schedules to automatically start backups at fixed intervals.

- Backup Hooks
  Configure pre and post-backup hooks to execute custom operations before and after Velero backups.

## Basic Information and Compatibility {#information}

|     Name     |                   Description                   |
| :------------------: | :---------------------------------------------: |
|     Velero Version     |                    1.13.0                |
|    Does it support offline installation    |                       Yes                        |
|       Supported Architecture       |                   amd64/arm64                   |


## Offline List {#download-list}

|     Name     |                   Download Address                   |
| :------------------: | :---------------------------------------------: |
|     Velero-cli  |                [Amd Download](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz)<br>[Arm Download](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz)                |
| Velero Image | [Amd Download](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-amd64.tar.gz)<br/>[Arm Download](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-arm64.tar.gz) |


### Image Import {#image-load}

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


## Prerequisites {#prerequisite}

- A deployed Kubernetes cluster is required; if not already deployed, refer to [Kubernetes Deployment](infra-kubernetes.md), and ensure kubectl can control the cluster.

## Installing Velero {#install}


### Object Storage Setup {#object-storage-settings}


=== "S3"
    
    #### Create S3 Bucket
    
    Velero requires an object storage bucket for storing backups, ideally a unique object storage bucket per Kubernetes cluster (see [FAQ](https://velero.io/docs/faq/) for more details). Create an S3 bucket, appropriately replacing placeholders:
    
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
    
    The following method sets permissions via IAM user. For other methods, refer to [Set Permissions Using kube2iam](https://github.com/vmware-tanzu/velero-plugin-for-aws?tab=readme-ov-file#option-2-set-permissions-using-kube2iam).
    
    For more information, see [AWS Documentation on IAM Users](http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).
    
    1. Create an IAM user:
    
    ```shell
    aws iam create-user --user-name velero
    ```
    > If you will use Velero to back up multiple clusters with multiple S3 buckets, it is best to create a unique username for each cluster rather than the default Velero.
    
    2. Attach policy to grant `velero` necessary permissions:
    
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
    
    4. Create a specific credentials file for velero (`credentials-velero`) in a local directory:
    
    ```shell
    [default]
    aws_access_key_id=<AWS_ACCESS_KEY_ID>
    aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>
    ```

=== "OSS"
    
    #### Create OSS Bucket
    
    Velero requires an object storage bucket for storing backups, ideally unique to a single Kubernetes cluster. Create an OSS bucket, appropriately replacing placeholders:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    ossutil mb oss://$BUCKET \
            --storage-class Standard \
            --acl=private
    ```
     
    #### Create RAM User
    
    1. Create user
    
    Refer to the [RAM User Guide](https://help.aliyun.com/zh/ram/user-guide/create-a-ram-user?spm=5176.28426678.J_HeJR_wZokYt378dwP-lLl.1.311651810ngbyx&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@93720.S_BB1@bl+RQW@ag0+BB2@ag0+os0.ID_93720-RL_%E5%88%9B%E5%BB%BARAM%E7%94%A8%E6%88%B7-LOC_search~UND~helpdoc~UND~item-OR_ser-V_3-P0_0) in Alibaba Cloud documentation.
       
    > If you will use Velero to back up multiple clusters with multiple OSS buckets, it is best to create a unique username for each cluster rather than the default Velero.
    
    2. Attach policy to grant velero necessary permissions:
    
    > Note that for security reasons, it is recommended to release velero's delete permission after completing backup or restore tasks.
    
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
    
    Refer to Alibaba Cloud documentation on [Creating AK](https://help.aliyun.com/zh/ram/user-guide/create-an-accesskey-pair?spm=a2c4g.11186623.0.0.77714c5cX1UXZe).

    4. Create a specific credentials file for velero (`credentials-velero`) in your installation directory:
    
    ```shell
    ALIBABA_CLOUD_ACCESS_KEY_ID=<ALIBABA_CLOUD_ACCESS_KEY_ID>
    ALIBABA_CLOUD_ACCESS_KEY_SECRET=<ALIBABA_CLOUD_ACCESS_KEY_SECRET>
    ```

### Install Velero CLI and Configuration {#install-config}

#### Install CLI {#install-cli}

=== "Amd"

    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-amd64.tar.gz && tar -xvf velero-v1.13.0-linux-amd64.tar.gz && mv velero-v1.13.0-linux-amd64/velero /bin
    ```

=== "Arm"


    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/velero-v1.13.0-linux-arm64.tar.gz && tar -xvf velero-v1.13.0-linux-arm64.tar.gz && mv velero-v1.13.0-linux-arm64/velero /bin
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
    
    Execute initialization command:
    
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
    
    > If using overseas nodes, modify s3Url to `https://s3.$BUCKET.amazonaws.com` 

=== "OSS"

    Set some environment variables:
    
    ```shell
    BUCKET=<YOUR_BUCKET>
    REGION=<YOUR_REGION>
    BUCKETPATH=<YOUR_BUCKETPATH>
    ```
    
    Execute initialization command:
    
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

#### Verify {#check-velero}

##### Create Test Service {#create-test}

```shell
kubectl create deployment demo --image=nginx
kubectl get pod
```

##### Backup {#create-backup}

Execute backup command:

```shell
velero backup create demo
```

Check backup command:

```shell
$ velero get backup
NAME   STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
demo   Completed   0        0          2024-03-04 18:31:28 +0800 CST   29d       default            <none>
```


##### Delete and Restore Test {#check-backup-restore}

Delete service:

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

Backup every day at midnight (without backing up PVC data), retain for 7 days

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
velero  get  backup   # Check backups
velero  get  schedule # Check scheduled backups
velero  get  restore  # Check existing restores
velero  get  plugins  # Check plugins
velero restore create --from-backup all-ns-backup  # Restore all cluster backups (will not overwrite existing services)
velero restore create --from-backup all-ns-backup --include-namespaces default,nginx-example # Restore only default nginx-example namespaces

Velero can restore resources into a different namespace than their original backup source. Use the --namespace-mappings flag for this.
velero restore create RESTORE_NAME --from-backup BACKUP_NAME --namespace-mappings old-ns-1:new-ns-1,old-ns-2:new-ns-2
For example, below restores test-velero namespace resources into test-velero-1
velero restore create restore-for-test --from-backup everyday-1-20210203131802 --namespace-mappings test-velero:test-velero-1
# Schedule backup 
velero create schedule prd-aws-df --schedule="0 1 * * *" --ttl 168h
```