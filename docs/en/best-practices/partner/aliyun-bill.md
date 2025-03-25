# Solving Alibaba Cloud API Signature Issues for Billing Analysis

---

The awareness of costs when purchasing multiple public cloud resources compared to buying private hosts is vastly different. Purchasing private hosts represents a one-time investment; whether you use them or not after purchase, how well you use them has no continuous impact on your subsequent investment. On the other hand, purchasing public cloud resources requires constant reminders: although the initial investment may be small, every day that passes incurs daily costs. Therefore, we urgently need methods to clearly view detailed cost expenditures and billing analyses across multiple cloud resources.
## Collecting Alibaba Cloud Cost API

First, taking Alibaba Cloud billing as an example, if we want to collect and analyze Alibaba Cloud's cost bill information, we need sufficient knowledge of the transaction and billing management APIs. The most challenging part when calling Alibaba Cloud APIs is the API signature (Signature) mechanism. Alibaba Cloud also provides [specialized documentation](https://help.aliyun.com/document_detail/87971.html) in its general documentation, but having only the signature mechanism documentation can be very challenging for developers with less experience. So, based on this incomplete documentation, how do we proceed with collecting billing costs?

### API Request Principle

Simply put, calling the Alibaba Cloud API is an HTTP request (most are GET requests, and this is also based on GET requests), just requiring a series of parameters afterward. For example, a request to view snapshots looks like this:

```html
http://ecs.aliyuncs.com/?SignatureVersion=1.0&Format=JSON&Timestamp=2017-08-07T05%3A50%3A57Z&RegionId=cn-hongkong&AccessKeyId=xxxxxxxxx&SignatureMethod=HMAC-SHA1&Version=2017-12-14&Signature=%2FeGgFfxxxxxtZ2w1FLt8%3D&Action=DescribeSnapshots&SignatureNonce=b5046ef2-7b2b-11e7-a3c5-00163e001831&ZoneId=cn-hongkong-b
```

The required common parameters (parameters needed for all API calls) are:

```html
SignatureVersion # Signature algorithm version, currently 1.0 
Format # Format of the returned message, JSON or XML, default is XML
Timestamp # Request timestamp, UTC time, e.g.: 2021-12-16T12:00:00Z 
AccessKeyId # Account key ID
SignatureMethod # Signature method, currently HMAC-SHA1
Version # Version number, date format, e.g.: 2017-12-14 varies by product
Signature # The hardest part to handle is the signature
SignatureNonce # A unique random number, preventing network attacks. Different requests should use different random numbers.
```

Apart from `Signature`, the other parameters are relatively easy to obtain, some even have fixed values. Refer to the [Alibaba Cloud documentation](https://help.aliyun.com/document_detail/87969.html) for more details. Besides common parameters, specific interface (Action) request parameters are also needed. Each `Action` interface parameter can be referenced from the corresponding product's interface documentation, such as [QuerySettleBill](https://help.aliyun.com/document_detail/173110.html). The `Signature` is based on both common parameters and interface parameters, so it is more complex.

### Constructing Standardized Request Strings 

- Construct dict<br />In Python, parameters correspond one-to-one using a dict. Create a dict and insert the request parameters.

```python
D = {
    'BillingCycle':str(time.strftime("%Y-%m", time.gmtime())),
    'Action':'QuerySettleBill',
    # 'PageNum':'5',
    'Format':'JSON',
    'Version':'2017-12-14',
    'AccessKeyId':'LTAI5tLumx55Vui4WJwZJneK',
    'SignatureMethod':'HMAC-SHA1',
    'MaxResults' : '300',
    # 'NextToken':"", #?
    'Timestamp':str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion':'1.0'
    # 'SignatureNonce':str_seed
}
```

- Sorting<br />Since signatures require uniqueness, including order, the parameters must be sorted by name.

```python
  # Since signatures require uniqueness, including order, the parameters must be sorted by name
        sortedD = sorted(D.items(),key=lambda x: x[0])
```

- URL Encoding<br />Since standard request strings require UTF-8 character sets, certain non-conforming characters in parameter names and values must be URL-encoded. Specific rules are:

> Characters AZ, az, 0~9, as well as “-”, “_”, “.”, “~” are not encoded;<br />Other characters are encoded in %XY format, where XY is the hexadecimal representation of the ASCII code of the character. For example, English double quotes (“) are encoded as %22;<br />For extended UTF-8 characters, they are encoded in %XY%ZA… format;<br />English spaces ( ) are encoded as %20, not plus signs (+).

> Note: Generally, libraries that support URL encoding (like java.net.URLEncoder in Java) encode according to the MIME type "application/x-www-form-urlencoded". During implementation, these methods can be used directly, replacing plus signs (+) in the encoded string with %20, asterisks (*) with %2A, and restoring %7E to tilde (~) to get the encoded string described above.

Here, the `urllib` library in Python is used for encoding:

```python
# Use urllib in Python for encoding
def percentEncode(str):
	res = urllib.parse.quote(str.encode('utf8'), '')
	res = res.replace('+', '%20')
	res = res.replace('*', '%2A')
	res = res.replace('%7E', '~')
	return res
```

- Generating Standardized Request Strings

```python
# Generate standardized request strings
canstring = ''
for k,v in sortedD:
    canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
```

### Constructing the StringToSign

The rule is:

> StringToSign=<br />HTTPMethod + “&” +<br />percentEncode(“/”) + ”&” +<br />percentEncode(CanonicalizedQueryString)

So in this instance:

```python
        # Generate standardized request string
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
```
### Calculating HMAC Value

```python
# access_key_secret
access_key_secret = '<access_key_secret>'
# Calculate HMAC value
h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
```

### Calculating the Signature Value

```python
# Calculate the signature value to generate the signature
signature = base64.encodestring(h.digest()).strip()
```
At this point, the `signature` has been generated.

### Adding the Signature

```python
# Add the signature
D['Signature'] = signature
```

So in this instance, the final request URL is:

```python
# Final API call
url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
http://business.aliyuncs.com/?BillingCycle=2021-12&Action=QuerySettleBill&Format=JSON&Version=2017-12-14&AccessKeyId=LTAI5tLumx55Vui4WJwZJneK&SignatureMethod=HMAC-SHA1&MaxResults=300&Timestamp=2021-12-16T12%3A27%3A58Z&SignatureVersion=1.0&SignatureNonce=0.30196531140307337&NextToken=&Signature=zFb4631sSGONvAeWD3xCIovMeoM%3D
```

Just open the browser and visit the link directly to get the results:

![image.png](../images/aliyun-bill-1.png)

### Complete Example

```python
import sys, datetime
import time
import json
import urllib
import hmac
from hashlib import sha1
import base64
import random
import requests


# Common parameters required in the request (parameters needed for all API calls)
D = {
    'BillingCycle':str(time.strftime("%Y-%m", time.gmtime())),
    'Action':'QuerySettleBill',
    # 'PageNum':'5',
    'Format':'JSON',
    'Version':'2017-12-14',
    'AccessKeyId':'<AccessKeyId>',
    'SignatureMethod':'HMAC-SHA1',
    'MaxResults' : '300',
    # 'NextToken':"", #?
    'Timestamp':str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion':'1.0'
    # 'SignatureNonce':str_seed
}
# Current time
now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

# Link local Datakit
datakit = DFF.SRC('datakit')

# Use the urllib library in Python for encoding
def percentEncode(str):
        res = urllib.parse.quote(str.encode('utf8'), '')
        res = res.replace('+', '%20')
        res = res.replace('*', '%2A')
        res = res.replace('%7E', '~')
        return res


# Get the bill
def getBill():
    # Current record position of the bill
    next_token = ""
    # Loop to get bills and write into DataKit
    for i in range(10000):
        random.seed()
        # Unique random number, used to prevent network replay attacks. Users should use different random values between different requests.
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        # Since signatures require uniqueness, including order, the parameters must be sorted by name
        sortedD = sorted(D.items(),key=lambda x: x[0])
        # Generate standardized request strings
        canstring = ''
        for k,v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        # Generate standardized request strings
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        # access_key_secret
        access_key_secret = '<access_key_secret>'
        # Calculate HMAC value
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        # Calculate the signature value to generate the signature
        signature = base64.encodestring(h.digest()).strip()
        # Add the signature
        D['Signature'] = signature
        # Final API call
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        # Request Alibaba Cloud billing costs
        print(url)
```

## Displaying Technical Route Selection

### Architectural Concept

![image.png](../images/aliyun-bill-2.png)

Adopting Crontab to schedule Python scripts periodically to acquire Alibaba Cloud billing data and store it in the MySQL storage engine, displaying the billing analysis data through Grafana. You can simplify operations by obtaining corresponding Bills templates via Grafana Dashboards. Below, we expand our technical research based on this architectural concept.

### Technical Research

In the current open-source visualization field, Grafana is the most popular with the most visualization templates. Kibana is also a good visualization platform. Compared to Grafana, Kibana is better suited for ELK architecture. Based on our needs, using Kibana would not be as suitable. Grafana is an open-source visualization tool that can be used with various data storages. It is a rich replacement for Graphite-web, helping us easily create and edit dashboards. It includes a unique Graphite target parser that makes it easy to edit metrics and functions. Users can create comprehensive charts using smart axis formats (such as lines and points). Additionally, Grafana comes with a built-in alerting engine, allowing users to attach conditional rules to dashboard panels that will trigger alerts sent to selected notification endpoints (such as email, Slack, PagerDuty, custom Webhooks, etc.), which perfectly meets the early warning needs for Alibaba Cloud fees. However, Grafana is designed to analyze and visualize system CPU, memory, disk, and I/O utilization metrics. Grafana does not allow full-text data queries, making the user experience less friendly. After some searching in the open-source community, we found the product "[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/)". This product not only covers all the advantages of Grafana and Kibana but also has many unique features. Moreover, it has Serverless online programming scheduling capabilities, solving the pain point of being unable to manage the scheduling of Python scripts to obtain Alibaba Cloud billing data. Additionally, as an open-source commercial product, its UI beauty surpasses Grafana by leaps and bounds. The free quota it provides can meet our needs, and we can also get official product support when there are usage issues.

### Technical Comparison

|  |  Grafana | <<< custom_key.brand_name >>> |
| --- | --- | --- |
| Usage Complexity | Installation and configuration are relatively cumbersome and require additional storage engines | Installed with one command, ready to use within 30 minutes |
| Documentation Completeness | Grafana's website has complete documentation, but there are fewer Chinese documents, which can be a headache for those who aren't proficient in English. | Has very complete Chinese documentation and a large number of use case guidance courses. |
| Community Activity | Active community, strong development and maintenance teams, fast version upgrades and iterations. | Commercial product, very active community, strong development and maintenance teams, quick problem-solving, fast version upgrades and iterations. |
| Function Completeness | Has 54 data sources, 173+ Dashboards, rich dashboard plugins such as heatmaps, line charts, charts, etc., supports simple alerts, etc. | Has over 200 data source integrations, 200+ Dashboards, multiple operating system supports, provides a unified standard DQL query for various data types, unifies management of metric data, log data, APM layer data, infrastructure, containers, middleware, network performance, supports powerful anomaly detection and advanced permission functions, supports complex alert rule configurations, etc. |
| Development Trend | Market share is on an upward trend, and it continues to rapidly develop and improve. | As a mature commercial product and a leader in the observability domain, market share is on an upward trend, and it continues to rapidly develop and improve. |
| Performance | Low resource consumption | Unified management, low resource consumption, binary files for efficient transmission, low bandwidth usage. |
| Serverless Programming | None | Based on Python3.x sandbox environment |
| Cost | Free | Free |
| Service | Community assistance | Professional technical team support |

### Requirements Matching

Through the comparison above, we find that using "<<< custom_key.brand_name >>>" can significantly reduce usage costs. Installation, configuration, and management are extremely convenient. In contrast to Grafana, which only serves as a display platform and still depends on external storage engines as data sources, "<<< custom_key.brand_name >>>" collects and manages metric data, log data, APM layer data, infrastructure, containers, middleware, network performance uniformly, making it much more convenient. This reduces the hassle of installing and maintaining storage engines. Also, Grafana lacks complete Chinese documentation, which might be problematic for users not fluent in English. Conversely, "<<< custom_key.brand_name >>>" offers complete Chinese documentation and numerous instructional videos, making it easier to get started with the product and focus on actual requirements. As a commercial product, even when using it for free, "<<< custom_key.brand_name >>>" provides professional technical support and has a large community to exchange insights about product usage. Functionally, it exceeds Grafana with powerful anomaly detection, advanced permission functions, and support for complex alert rule configurations, meeting needs beyond fee analysis effectively. Furthermore, "<<< custom_key.brand_name >>>" allows unified component management through a visual interface, consuming low resources, with binary file data for high-efficiency transmission and low bandwidth usage. Additionally, for aesthetically inclined users, "<<< custom_key.brand_name >>>" offers a minimalist style design that stands out, making it the preferred choice for our needs.

## Implementing Cost Management with <<< custom_key.brand_name >>>

### Deployment Instructions

Example Linux version: CentOS Linux release 7.8.2003 (Core)

Collect all Alibaba Cloud billing cost data through a single server.

### Prerequisites

#### Install DataKit

Before starting to monitor hosts with "<<< custom_key.brand_name >>>", you need to install DataKit first. DataKit is the officially released data collection application, supporting the collection of hundreds of types of data. By configuring data sources, real-time data can be collected, including host, process, container, log, application performance, user visits, and more.

Before installing DataKit, you need to register a ["<<< custom_key.brand_name >>>" account](https://<<< custom_key.brand_main_domain >>>/) first. After registration, log in to the "<<< custom_key.brand_name >>>" workspace to obtain the DataKit installation instructions and deploy the first DataKit.

##### Obtain Installation Instructions

You can log in to the "<<< custom_key.brand_name >>>" workspace, click sequentially on 「Integration」 - 「DataKit」, choose the DataKit installation method as shown below, then copy the 「Installation Instruction」 and execute it on the host.

- Installation System: Linux

- System Type: X86 amd64

- DataWay Address: OpenWay

![image.png](../images/aliyun-bill-3.png)

##### Execute Installation Instructions on Host

Open the command-line terminal tool, log in to the server, and execute the copied 「Installation Instruction」. After successful installation, it will prompt `Install Success`, and you can view the installation status, manual, and update records of DataKit via the provided link.

![2. Install datakit.png](../images/aliyun-bill-4.png)

##### Start Using "<<< custom_key.brand_name >>>"

After successfully installing DataKit, the host object collector `hostobject` is already enabled by default. You can directly view the host installed with DataKit under the 「Infrastructure」 - 「Host」 section of the "<<< custom_key.brand_name >>>" workspace, including host status, hostname, operating system, CPU usage rate, MEM usage rate, CPU single-core load, etc. You can also click on the host to view more detailed information about the host.

![4. View host.png](../images/aliyun-bill-5.png)

#### Install Func Portable Edition

##### System and Environment Requirements

The host running DataFlux Func must meet the following conditions:

- CPU core count >= 2

- Memory capacity >= 4GB

- Disk space >= 20GB

- Network bandwidth >= 10 Mbps

- Operating system Ubuntu 16.04 LTS/CentOS 7.2 or higher

- Clean system (after installing the operating system, except for network configuration, no other operations have been performed)

- Open `8088` port (the system defaults to using `8088` port, please ensure firewall, security groups, etc., allow `8088` inbound access)

- When using external MySQL, the MySQL version must be 5.7 or higher

- When using external Redis, the Redis version must be 4.0 or higher

> _Note: DataFlux Func does not support MacOS, Windows, you can choose to install DataFlux Func in a virtual machine, cloud host_

> _Note: DataFlux Func does not support cluster Redis, for high availability, please choose master-slave_

> _Note: If installing DataFlux Func on Alibaba Cloud ECS and the Alibaba Cloud Shield plugin is enabled, since the cloud shield itself consumes a lot of resources, the system configuration should be appropriately increased_

##### Download Command for Portable Edition

```shell
/bin/bash -c "$(curl -fsSL https://t.<<< custom_key.brand_main_domain >>>/func-portable-download)"
```

> _Note: All shell commands mentioned in this article can be run directly under the root user, and non-root users need to add sudo_
>
> _Note: This article only provides the most common operation steps, detailed installation deployment please refer to 「Maintenance Manual」_

##### Execute Automatic Installation Script

In the already downloaded `dataflux-func-portable` directory,<br />run the following command to automatically configure and finally start the entire DataFlux Func:

> _Note: Please confirm system requirements and server configurations before installation_
>
> _Note: DataFlux Func does not support Mac, please copy it to a Linux system and run the installation_

```shell
sudo /bin/bash run-portable.sh
```

Using the automatic installation script can achieve quick installation and operation within minutes, with the following automatic configurations:

- Running MySQL, Redis, DataFlux Func (including Server, Worker, Beat)

- Automatically creating and saving all data under `/usr/local/dataflux-func/` directory (including MySQL data, Redis data, DataFlux Func configuration, log files, etc.)

- Randomly generating MySQL `root` user password, system Secret, and saving them in the DataFlux Func configuration file

- No password set for Redis

- No external access provided for MySQL, Redis

After completion, you can use a browser to access `http://{server IP address/domain}:8088` for initialization operations.

> _Note: If the running environment performance is poor, please confirm all components are successfully started using the `docker ps` command before accessing (see the following list)_

1. `dataflux-func_mysql`

1. `dataflux-func_redis`

1. `dataflux-func_server`

1. `dataflux-func_worker-0`

1. `dataflux-func_worker-1-6`

1. `dataflux-func_worker-7`

1. `dataflux-func_worker-8-9`

1. `dataflux-func_beat`

#### Obtain RAM Access Control

1. Log in to the RAM console [https://ram.console.aliyun.com/users](https://ram.console.aliyun.com/users)

1. Create a new user: Personnel Management - User - Create User
![image.png](../images/aliyun-bill-6.png)

1. Save or download the **AccessKeyID** and **AccessKey Secret** CSV file (configuration file will use it)

1. User authorization (billing permissions)
![](../images/aliyun-bill-7.png)

### Configuration Implementation

#### Log in to DataFlux Function

Log in to Func at `http://ip:8088` (default admin/admin)

![](../images/aliyun-bill-8.png)

#### Create Script Sets

Enter title/description information

![image.png](../images/aliyun-bill-9.png)

#### Edit Script

Write the script to write billing data into DataKit for report creation preparation.

Complete script as follows:

```python
import sys, datetime
import time
import json
import urllib
import hmac
from hashlib import sha1
import base64
import random
import requests


# Common parameters required in the request (parameters needed for all API calls)
D = {
    'BillingCycle':str(time.strftime("%Y-%m", time.gmtime())),
    'Action':'QuerySettleBill',
    # 'PageNum':'5',
    'Format':'JSON',
    'Version':'2017-12-14',
    'AccessKeyId':'<AccessKeyId>',
    'SignatureMethod':'HMAC-SHA1',
    'MaxResults' : '300',
    # 'NextToken':"", #?
    'Timestamp':str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion':'1.0'
    # 'SignatureNonce':str_seed
}
# Current time
now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

# Link local Datakit
datakit = DFF.SRC('datakit')

# Use urllib in Python for encoding
def percentEncode(str):
        res = urllib.parse.quote(str.encode('utf8'), '')
        res = res.replace('+', '%20')
        res = res.replace('*', '%2A')
        res = res.replace('%7E', '~')
        return res


# Get billing
@DFF.API('getBill')
def getBill():
    # Current record position of the bill
    next_token = ""
    # Loop to get bills and write into DataKit
    for i in range(10000):
        random.seed()
        # Unique random number, used to prevent network replay attacks. Users should use different random values between different requests.
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        # Since signatures require uniqueness, including order, the parameters must be sorted by name
        sortedD = sorted(D.items(),key=lambda x: x[0])
        canstring = ''
        for k,v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        # Generate standardized request strings
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        # access_key_secret
        access_key_secret = '<access_key_secret>'
        # Calculate HMAC value
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        # Calculate the signature value to generate the signature
        signature = base64.encodestring(h.digest()).strip()
        # Add the signature
        D['Signature'] = signature
        # Final API call
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        # Request Alibaba Cloud billing costs
        response = requests.get(url)
        billing_cycle = response.json()["Data"]["BillingCycle"]
        account_id = response.json()["Data"]["AccountID"]
        next_token = response.json()["Data"]["NextToken"]
        if next_token is not None:
            bill = response.json()["Data"]["Items"]["Item"]
            print(bill)
            # Write the daily bill into <<< custom_key.brand_name >>>
            for i in bill:
                print(i["UsageEndTime"])
                time = i["UsageEndTime"].split(" ")[0]
                print(time, now_time)
                if time == now_time:
                    measurement = "aliyunSettleBill"
                    tags = {
                        "BillingCycle": billing_cycle,
                        "AccountID": account_id
                    }
                    fields = {
                        "ProductName":i["ProductName"],
                        "SubOrderId":i["SubOrderId"],
                        "BillAccountID":i["BillAccountID"],
                        "DeductedByCashCoupons":i["DeductedByCashCoupons"],
                        "PaymentTime":i["PaymentTime"],
                        "PaymentAmount":i["PaymentAmount"],
                        "DeductedByPrepaidCard":i["DeductedByPrepaidCard"],
                        "InvoiceDiscount":i["InvoiceDiscount"],
                        "UsageEndTime":i["UsageEndTime"],
                        "Item":i["Item"],
                        "SubscriptionType":i["SubscriptionType"],
                        "PretaxGrossAmount":i["PretaxGrossAmount"],
                        "Currency":i["Currency"],
                        "CommodityCode":i["CommodityCode"],
                        "UsageStartTime":i["UsageStartTime"],
                        "AdjustAmount":i["AdjustAmount"],
                        "Status":i["Status"],
                        "DeductedByCoupons":i["DeductedByCoupons"],
                        "RoundDownDiscount":i["RoundDownDiscount"],
                        "ProductDetail":i["ProductDetail"],
                        "ProductCode":i["ProductCode"],
                        "ProductType":i["ProductType"],
                        "OutstandingAmount":i["OutstandingAmount"],
                        "BizType":i["BizType"], 
                        "PipCode":i["PipCode"],
                        "PretaxAmount":i["PretaxAmount"],
                        "OwnerID":i["OwnerID"],
                        "BillAccountName":i["BillAccountName"],
                        "RecordID":i["RecordID"],
                        "CashAmount":i["CashAmount"],
                    }
                    try:
                        status_code, result = datakit.write_logging(measurement=measurement, tags=tags, fields=fields)
                        print(status_code,result)
                    except:
                        print("Insert failed!")
                else:
                    break
            else:
                continue
            break
        else:
            break


```

#### Publish Script

**Save** configuration and **Publish**

![image.png](../images/aliyun-bill-10.png)

#### Create Scheduled Task

Add an auto-trigger task, Management - Auto Trigger Configuration - New Task. Since the bill is a daily bill, the collection frequency can be set once a day.

![image.png](../images/aliyun-bill-11.png)

#### View Reported Data

Log preview

![image.png](../images/aliyun-bill-12.png)

#### Create Explorer

Import Explorer

![image.png](../images/aliyun-bill-13.png)