# How to Install and Use DataWay
---

## Introduction

DataWay is the data gateway of <<< custom_key.brand_name >>>. All data collected by collectors must be reported through the DataWay gateway before reaching <<< custom_key.brand_name >>>. The primary functions of the DataWay gateway are:

- To receive data sent by collectors and then report it to <<< custom_key.brand_name >>> for storage. This is commonly used in scenarios where data proxy reporting is required.
- To process the collected data before sending it to <<< custom_key.brand_name >>> for storage. This is commonly used in data cleaning scenarios.

**Note:** For the Deployment Plan version of DataWay, it must be installed on a local server before it can be used.

## Method/Steps

### Step 1: Create DataWay

In the <<< custom_key.brand_name >>> management backend under the "Data Gateway" page, click on "Create DataWay".

![](img/21.dataway_2.png)

Enter the "Name" and "Binding Address," then click "Create".

**Note:** The binding address, which is the DataWay gateway address, must be a complete HTTP address, such as http(s)://1.2.3.4:9528, including the protocol, host address, and port. The host address can generally be the IP address where DataWay is deployed, or you can specify a domain name that has been properly configured. Ensure that the collector can access this address; otherwise, data collection will not succeed.

![](img/21.dataway_3.png)

Upon successful creation, a new DataWay will be automatically created along with its installation script.
![](img/21.dataway_4.png)

### Step 2: Install DataWay

The newly created DataWay supports both Linux and Docker installation methods. Copy the installation script to the server where DataWay needs to be deployed and execute it. A successful installation will display the following information. At this point, DataWay will run automatically by default.

![](img/install_dataway_script2.png)

After installation, wait a moment and refresh the "Data Gateway" page. If you see a version number in the "Version Information" column for the newly added data gateway, it indicates that this DataWay has successfully connected to the <<< custom_key.brand_name >>> center, and users can start using it to ingest data.
![](img/21.dataway_2.1.png)

### Step 3: Use DataWay

Once DataWay has successfully connected to the <<< custom_key.brand_name >>> center, log in to the <<< custom_key.brand_name >>> console and go to the "Integration" - "DataKit" page. Here, you can view all DataWay addresses. Select the required DataWay gateway address, obtain the DataKit installation instructions, and execute them on the server to begin collecting data.

![](img/21.dataway_6.png)