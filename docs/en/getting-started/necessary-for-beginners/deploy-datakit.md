# Deploy the first DataKit
---

## Scene Description

You bought a Linux host some time ago and deployed a portal website based on Nginx. Recently, you found that the website opened slowly, and sometimes it even couldn't be opened, such as 404 error when opening a certain page. In order to solve this problem, you decided to monitor this cloud host through the observation cloud and analyze what went wrong.

## Preconditions

Before starting to use Guance to monitor the cloud host, you need to register a [Guance account](https://auth.guance.com/register?channel=帮助文档), log in to Guance workspace after registration, and then get the DataKit installation instructions and deploy your first DataKit.

DataKit is an official data collection application released by Guance, which supports the collection of hundreds of kinds of data, and can collect a variety of data such as host, process, container, log, application performance and user access in real time.

## Methods/Steps

### Step1: Get Installation Instructions

You can log in to Guance workspace, click "Integration"-"DataKit" in turn, and copy the DataKit installation instructions.

![](../img/datakit.png)

### Step2: Execute Installation Instructions on the Host

Open the command line terminal tool, log in to your host, execute the copied `Install Success`, and prompt Install Success after the installation is completed. You can view the installation status, manual and update record of DataKit through the link provided by DataKit installation result.

![](../img/a2.png)

### Step3: Start Using Guance

After the successful installation of DataKit, the host object collector `hostobject` has been turned on by default, so you can directly view the host that just installed DataKit under "Infrastructure"-"Host" in the Guance workspace, including host status, host name, operating system, CPU utilization, MEM utilization and CPU single core load. You can also click on the host to view more details of the host.

![](../img/a1.png)

After installing DataKit, we can begin to [configure the collector](configure-datakit.md) to collect more different data.