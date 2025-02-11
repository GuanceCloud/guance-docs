# NFS Service Deployment

???+ warning "Note"

    NFS service is not deployed within the Kubernetes cluster and requires a separate machine for deployment.

## Introduction {#info}

NFS (Network File System) allows different machines and operating systems to share files over a network.

## Prerequisites

- Access to the public internet

## Basic Information and Compatibility

|     Name     |                   Description                   |
| :------------------: | :---------------------------------------------: |
|      Path      | /nfsdata （Ensure this directory has sufficient capacity and is on a data disk） |
|    Offline Installation Support    |                       No                        |
|       Supported Architectures       |                   amd64/arm64                   |
|      Deployment Machine IP      |                 192.168.100.105                 |

## Installation Steps

### 1. Preparations

#### 1.1 Disable Firewall Service

```shell
systemctl stop firewalld
systemctl disable firewalld
```

### 2. Installation

#### 2.1 Install NFS Service

Run the following commands to install the necessary packages for the NFS server and create the mount directory (please set up a data disk, here using `/nfsdata` as the data directory):

```shell
yum install -y rpcbind nfs-utils
mkdir /nfsdata
```

#### 2.2 Configure NFS Shared Path

Execute the command `vim /etc/exports` to create the exports file with the following content:

```shell
#/nfsdata *(insecure,rw,async,no_root_squash)
/nfsdata *(rw,no_root_squash,no_all_squash,insecure)
```

#### 2.3 Start NFS Service

Run the following commands to start the NFS service:

```shell
systemctl enable rpcbind
systemctl enable nfs-server
systemctl restart rpcbind
systemctl restart nfs-server
```

#### 2.4 Verify Configuration

Check if the configuration is effective:

```shell
exportfs
```

Query the NFS shared directories on the local machine:

```shell
showmount -e localhost
```

### 3. Verify Deployment

#### 3.1 Install Client

Run the following command to install the necessary packages for the NFS client:

```shell
yum install -y nfs-utils
```

#### 3.2 View Shared Directories

???+ warning "Note"

    192.168.100.105 is the test IP used in this article; you need to replace it with your NFS server's IP address.

Run the following command to check if the NFS server has configured any shared directories:

```shell 
# showmount -e $(NFS server IP)
showmount -e 192.168.100.105
# The output should look like this:
Export list for 192.168.100.105:
/nfsdata *
```

#### 3.3 Remote Mount Test

???+ warning "Note"

    192.168.100.105 is the test IP used in this article; you need to replace it with your NFS server's IP address.

Run the following command to mount the shared directory from the NFS server to the local path `/data`:

```sh
mkdir /data
# mount -t nfs $(NFS server IP):/nfsdata /data
mount -t nfs 192.168.100.105:/nfsdata /data
# Write a test file
echo "hello nfs server" > /data/test.txt
```

#### 3.4 Check Test Results

On the NFS server, run the following command to verify that the file was written successfully:

```sh
cat /nfsdata/test.txt
```

Successful test output:

```shell
hello nfs server
```