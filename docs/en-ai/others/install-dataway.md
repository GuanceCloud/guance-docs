# How to Install and Use DataWay
---

## Introduction

DataWay is the data gateway of Guance, through which collectors report data. The main functions of the DataWay gateway are:

- Receiving data sent by collectors and then reporting it to Guance for storage; this is commonly used in scenarios where data proxy reporting is required.
- Processing collected data before sending it to Guance for storage; this is commonly used in data cleansing scenarios.

**Note:** For the Deployment Plan DataWay of Guance, local server installation is required before it can be used.

## Method/Steps

### Step1: Create a New DataWay

In the Guance management backend under the "Data Gateway" page, click "Create DataWay".

![](img/21.dataway_2.png)

Enter the "Name" and "Binding Address", then click "Create".

**Note:** The binding address, i.e., the DataWay gateway address, must include the complete HTTP address, such as http(s)://1.2.3.4:9528, including protocol, host address, and port. The host address can generally use the IP address where DataWay is deployed or a specified domain name that needs proper DNS resolution. Ensure that the collector can access this address; otherwise, data collection will fail.

![](img/21.dataway_3.png)

Upon successful creation, a new DataWay will be automatically created along with its installation script.
![](img/21.dataway_4.png)

### Step2: Install DataWay

The newly created DataWay supports both Linux and Docker installation methods. Copy the installation script to the server where you need to deploy DataWay and execute it. A successful installation will display information similar to the following image. At this point, DataWay will run automatically by default.

![](img/install_dataway_script2.png)

After installation, wait a moment and refresh the "Data Gateway" page. If you see the version number in the "Version Information" column of the newly added data gateway, it indicates that this DataWay has successfully connected to the Guance center, and users can start integrating data through it.
![](img/21.dataway_2.1.png)

### Step3: Use DataWay 

Once DataWay has successfully connected to the Guance center, log in to the Guance console and go to the "Integration" - "DataKit" page to view all DataWay addresses. Select the required DataWay gateway address, obtain the DataKit installation command, and execute it on the server to start collecting data.

![](img/21.dataway_6.png)