# Solving Alibaba Cloud API Signature Issues to Achieve Billing Analysis

---

Purchasing multiple public cloud resources versus buying private hosts differs significantly in terms of cost awareness. Buying private hosts is a one-time investment; whether you use them or not, how well they are used does not continuously affect future investments. In contrast, purchasing public cloud resources requires constant reminders: although the initial investment is lower, each day incurs daily charges. Therefore, we urgently need methods that can help us clearly view detailed cost expenditures and billing analysis across multiple cloud resources.

## Collecting Alibaba Cloud Cost API

First, using Alibaba Cloud billing as an example, if we want to collect Alibaba Cloud's billing information for analysis, we need to be familiar with the transaction and billing management APIs. When calling Alibaba Cloud APIs, the most challenging part is the signature (Signature) mechanism. Alibaba Cloud also provides [specific instructions](https://help.aliyun.com/document_detail/87971.html) in its general documentation. However, having only the signature mechanism documentation can be daunting for less experienced developers. Based on this incomplete documentation, how should we proceed with collecting billing costs?

### API Request Principles

Simply put, calling Alibaba Cloud APIs is an HTTP request (most are GET, and this example uses GET requests), but it includes many parameters. For instance, a snapshot query request looks like this:

```html
http://ecs.aliyuncs.com/?SignatureVersion=1.0&Format=JSON&Timestamp=2017-08-07T05%3A50%3A57Z&RegionId=cn-hongkong&AccessKeyId=xxxxxxxxx&SignatureMethod=HMAC-SHA1&Version=2017-12-14&Signature=%2FeGgFfxxxxxtZ2w1FLt8%3D&Action=DescribeSnapshots&SignatureNonce=b5046ef2-7b2b-11e7-a3c5-00163e001831&ZoneId=cn-hongkong-b
```

The required common parameters (parameters needed for all API calls) are:

```html
SignatureVersion # Signature algorithm version, currently 1.0 
Format # Response message formatting, JSON or XML, default is XML
Timestamp # Request timestamp, UTC time, e.g., 2021-12-16T12:00:00Z 
AccessKeyId # Account key ID
SignatureMethod # Signature method, currently HMAC-SHA1
Version # Version number, in date format, e.g., 2017-12-14, varies by product
Signature # The most difficult to handle signature
SignatureNonce # Unique random number, prevents network attacks. Different requests use different random numbers.
```

Except for `Signature`, other parameters are relatively easy to obtain, some of which are fixed values. Refer to the [Alibaba Cloud documentation](https://help.aliyun.com/document_detail/87969.html). Besides common parameters, specific interface (Action) request parameters are needed. Each `Action` interface parameter can be found in the corresponding product’s API documentation, such as [QuerySettleBill](https://help.aliyun.com/document_detail/173110.html). The `Signature` is based on both common and interface parameters, making it more complex.

### Constructing a Canonicalized Request String

- Construct dict<br />In Python, parameters are represented as a dict. Create a dict and fill in the request parameters.

```python
D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': 'LTAI5tLumx55Vui4WJwZJneK',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
}
```

- Sorting<br />Since the signature requires uniqueness, including order, sort the parameters by name.

```python
sortedD = sorted(D.items(), key=lambda x: x[0])
```

- URL Encoding<br />Standard request strings require UTF-8 encoding for parameter names and values that do not conform to standards. Specific rules are:

> Characters AZ, az, 0~9, and characters “-”, “_”, “.”, “~” are not encoded;<br />Other characters are encoded into %XY format, where XY is the hexadecimal representation of the ASCII code. For example, English double quotes (“”) are encoded as %22;<br />For extended UTF-8 characters, encode into %XY%ZA… format;<br />English spaces ( ) are encoded as %20, not plus (+).

> Note: Libraries that support URL encoding (like Java’s java.net.URLEncoder) generally encode according to the MIME type “application/x-www-form-urlencoded”. During implementation, directly use these libraries, replacing plus (+) with %20, star (*) with %2A, and %7E with tilde (~) to get the encoded string.

Here, we use Python’s `urllib` library for encoding:

```python
def percentEncode(str):
	res = urllib.parse.quote(str.encode('utf8'), '')
	res = res.replace('+', '%20')
	res = res.replace('*', '%2A')
	res = res.replace('%7E', '~')
	return res
```

- Generate Canonicalized Request String

```python
canstring = ''
for k, v in sortedD:
    canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
```

### Constructing the StringToSign

The rule is:

> StringToSign=<br />HTTPMethod + “&” +<br />percentEncode(“/”) + ”&” +<br />percentEncode(CanonicalizedQueryString)

So in this example:

```python
stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
```

### Calculating the HMAC Value

```python
access_key_secret = '<access_key_secret>'
h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
```

### Calculating the Signature Value

```python
signature = base64.encodestring(h.digest()).strip()
```

At this point, the `signature` is generated.

### Adding the Signature

```python
D['Signature'] = signature
```

So in this example, the final request URL is:

```python
url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
http://business.aliyuncs.com/?BillingCycle=2021-12&Action=QuerySettleBill&Format=JSON&Version=2017-12-14&AccessKeyId=LTAI5tLumx55Vui4WJwZJneK&SignatureMethod=HMAC-SHA1&MaxResults=300&Timestamp=2021-12-16T12%3A27%3A58Z&SignatureVersion=1.0&SignatureNonce=0.30196531140307337&NextToken=&Signature=zFb4631sSGONvAeWD3xCIovMeoM%3D
```

You can directly access this URL in your browser to get the result:

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


D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': '<AccessKeyId>',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
}

now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

datakit = DFF.SRC('datakit')

def percentEncode(str):
        res = urllib.parse.quote(str.encode('utf8'), '')
        res = res.replace('+', '%20')
        res = res.replace('*', '%2A')
        res = res.replace('%7E', '~')
        return res

def getBill():
    next_token = ""
    for i in range(10000):
        random.seed()
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        sortedD = sorted(D.items(), key=lambda x: x[0])
        canstring = ''
        for k, v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        access_key_secret = '<access_key_secret>'
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        signature = base64.encodestring(h.digest()).strip()
        D['Signature'] = signature
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        print(url)


```

## Demonstrating Technology Selection

### Architecture Design

![image.png](../images/aliyun-bill-2.png)

Using Crontab to schedule Python scripts periodically to retrieve Alibaba Cloud billing data and store it in the MySQL storage engine, then display the billing analysis data via Grafana. You can simplify operations by using Grafana Dashboards templates. Below is a technical survey based on this architecture design.

### Technical Research

In the current open-source visualization field, Grafana is the most popular with a wide variety of visualization templates. Kibana is another good visualization platform, but compared to Grafana, Kibana is better suited for the ELK stack. Given our requirements, using Kibana would not be as suitable. Grafana is an open-source visualization tool that can be used with various data stores and is a feature-rich alternative to Graphite-web, helping us easily create and edit dashboards. It includes a unique Graphite target parser that simplifies metrics and function editing. Users can create comprehensive charts using smart axis formats (such as lines and points). Additionally, Grafana comes with a built-in alerting engine, allowing conditional rules to be attached to dashboard panels to trigger alerts sent to chosen notification endpoints (e.g., email, Slack, PagerDuty, custom webhooks), meeting the need for early warning of Alibaba Cloud expenses. However, Grafana is designed to analyze and visualize system CPU, memory, disk, and I/O utilization metrics. It does not support full-text data queries, which can make the user experience less friendly. After searching through open-source communities, I found “[Guance](https://www.guance.com/)” which perfectly meets our needs, combining all the advantages of Grafana and Kibana with additional unique features. It also offers Serverless online programming scheduling, solving the pain point of managing Python script scheduling. As a commercial open-source product, Guance has a much more aesthetically pleasing UI compared to Grafana, and the free quota can meet our needs. Moreover, when encountering issues, we can receive official product support.

### Technical Comparison

|  |  Grafana | Guance |
| --- | --- | --- |
| Complexity of Use | Installation and configuration are cumbersome, requiring additional storage engines | Installed with one command, ready-to-use within 30 minutes |
| Documentation Completeness | Comprehensive documentation on the Grafana website, but limited Chinese documentation, which can be challenging for non-English speakers | Extensive Chinese documentation and numerous usage guides and tutorials |
| Community Activity | Active community, strong development and maintenance teams, rapid version upgrades | Commercial product with very active community, strong development and maintenance teams, quick problem resolution, rapid version upgrades |
| Feature Completeness | Supports 54 data sources, 173+ Dashboards, rich dashboard plugins such as heatmaps, line charts, graphs, etc., simple alert support | Supports over 200 data sources, 200+ Dashboards, multiple operating systems, standard unified DQL query for various data types, unifying management of metrics data, log data, APM layer data, infrastructure, containers, middleware, network performance, powerful anomaly detection, advanced permission features, complex alert rule configuration support |
| Development Trend | Market share is increasing rapidly, and the product is developing and improving rapidly | As a mature commercial product, leading in observability, market share is increasing rapidly, and the product is developing and improving rapidly |
| Performance | Low resource consumption | Unified management, low resource consumption, binary file transmission, high efficiency, low bandwidth consumption |
| Serverless Programming | No | Based on Python3.x sandbox environment |
| Cost | Free | Free |
| Service | Community support | Professional technical team support |

### Requirement Matching

Through the above comparison, we find that using “Guance” can significantly reduce usage costs, and installation and configuration management are very convenient. Compared to Grafana, which only serves as a display platform and still relies on external storage engines as data sources, “Guance” handles metric data, log data, APM layer data, infrastructure, containers, middleware, network performance—all collected and managed uniformly—making it much more convenient. This eliminates the need for installing and maintaining storage engines. Grafana lacks comprehensive Chinese documentation, which can be a headache for users not proficient in English. In contrast, Guance offers extensive Chinese documentation and numerous usage guides and tutorial videos, making it easier to get started with the product and focus on actual needs. As a commercial product, even when using it for free, you can receive professional technical support and benefit from a large community to exchange experiences. Functionally, Guance offers powerful anomaly detection, advanced permission features, and support for complex alert rule configurations, meeting needs beyond just expense analysis. Additionally, Guance allows unified management of components through a visual interface, with low resource consumption, binary file transmission, high efficiency, and low bandwidth consumption. For those who value aesthetics, Guance’s minimalist UI design stands out, so choosing to build with “Guance” is definitely the best option for our needs.

## Implementing Cost Management with Guance

### Deployment Instructions

Example Linux version: CentOS Linux release 7.8.2003 (Core)

Collecting all Alibaba Cloud billing data using one server

### Prerequisites

#### Installing DataKit

Before using “Guance” to monitor hosts, you need to install DataKit. DataKit is the official data collection application that supports collecting hundreds of types of data. By configuring data sources, you can collect real-time data such as host, process, container, logs, application performance, user access, etc.

Before installing DataKit, you need to register a [“Guance” account](https://www.guance.com/). After registration, log in to the “Guance” workspace to obtain DataKit installation instructions and deploy the first DataKit.

##### Obtaining Installation Instructions

Log in to the “Guance” workspace, click sequentially on 「Integration」-「DataKit」, choose the DataKit installation method, see the following information, and copy the 「Installation Instruction」 to execute on the host.

- Operating System: Linux

- System Type: X86 amd64

- DataWay Address: OpenWay

![image.png](../images/aliyun-bill-3.png)

##### Executing Installation Instructions on Host

Open the command-line terminal tool, log in to the server, and execute the copied 「Installation Instruction」. After successful installation, it will prompt `Install Success`. You can then check the installation status, manual, and update records provided by DataKit.

![2.Install datakit.png](../images/aliyun-bill-4.png)

##### Starting to Use “Guance”

After successfully installing DataKit, the host object collector `hostobject` is already enabled by default. You can directly view the installed DataKit host in the “Guance” workspace under 「Infrastructure」-「Host」, including host status, hostname, operating system, CPU usage rate, MEM usage rate, single-core CPU load, etc. You can also click on the host to view more details.

![4.View host.png](../images/aliyun-bill-5.png)

#### Installing Portable Func

##### System and Environment Requirements

The host running DataFlux Func must meet the following conditions:

- CPU cores >= 2

- Memory capacity >= 4GB

- Disk space >= 20GB

- Network bandwidth >= 10 Mbps

- Operating system is Ubuntu 16.04 LTS/CentOS 7.2 or later

- Clean system (after installing the operating system, no other operations except configuring the network)

- Port `8088` must be open (this system defaults to using port `8088`, ensure firewall and security group configurations allow inbound access on `8088`)

- If using external MySQL, MySQL version must be 5.7 or higher

- If using external Redis, Redis version must be 4.0 or higher

> _Note: DataFlux Func does not support MacOS or Windows. You can install DataFlux Func in virtual machines or cloud hosts._

> _Note: DataFlux Func does not support cluster Redis. Choose master-slave versions for high availability._

> _Note: If installing DataFlux Func on Alibaba Cloud ECS and enabling Alibaba Cloud Shield plugin, due to high resource consumption by Cloud Shield, system configuration should be appropriately increased._

##### Download Command for Portable Version

```shell
/bin/bash -c "$(curl -fsSL https://t.guance.com/func-portable-download)"
```

> _Note: All shell commands mentioned in this article can be run directly by root users. Non-root users need to add sudo._
>
> _Note: This article only provides the most common operation steps. Detailed installation and deployment please refer to the 「Maintenance Manual」_

##### Using Automatic Installation Script to Execute Installation

In the downloaded `dataflux-func-portable` directory, run the following command to automatically configure and start the entire DataFlux Func:

> _Note: Before installation, confirm system requirements and server configuration_
>
> _Note: DataFlux Func does not support Mac. Please copy it to a Linux system before running the installation_

```shell
sudo /bin/bash run-portable.sh
```

Using the automatic installation script can achieve quick installation and operation within minutes. The automatic configuration includes:

- Running MySQL, Redis, DataFlux Func (including Server, Worker, Beat)

- Automatically creating and saving all data under `/usr/local/dataflux-func/` directory (including MySQL data, Redis data, DataFlux Func configuration, log files, etc.)

- Randomly generating MySQL `root` user password, system Secret, and saving them in the DataFlux Func configuration file

- Redis does not set a password

- MySQL and Redis do not provide external access

After execution, you can access the initialization interface via `http://{server IP address/domain}:8088` in a browser.

> _Note: If the runtime environment performance is poor, use the `docker ps` command to confirm all components have started successfully before accessing (see the list below)_

1. `dataflux-func_mysql`

1. `dataflux-func_redis`

1. `dataflux-func_server`

1. `dataflux-func_worker-0`

1. `dataflux-func_worker-1-6`

1. `dataflux-func_worker-7`

1. `dataflux-func_worker-8-9`

1. `dataflux-func_beat`

#### Obtaining RAM Access Control

1. Log in to the RAM console [https://ram.console.aliyun.com/users](https://ram.console.aliyun.com/users)

1. Create a new user: Personnel Management - User - Create User
![image.png](../images/aliyun-bill-6.png)

1. Save or download the **AccessKeyID** and **AccessKey Secret** CSV file (used in configuration)

1. Authorize the user (billing permissions)
![](../images/aliyun-bill-7.png)

### Configuration Implementation

#### Logging into DataFlux Function

Log in to Func at `http://ip:8088` (default admin/admin)

![](../images/aliyun-bill-8.png)

#### Creating a Script Set

Enter title/description information

![image.png](../images/aliyun-bill-9.png)

#### Editing Scripts

Write scripts to write billing data to DataKit to prepare for report creation.

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

D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': '<AccessKeyId>',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
}

now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

datakit = DFF.SRC('datakit')

def percentEncode(str):
        res = urllib.parse.quote(str.encode('utf8'), '')
        res = res.replace('+', '%20')
        res = res.replace('*', '%2A')
        res = res.replace('%7E', '~')
        return res

@DFF.API('getBill')
def getBill():
    next_token = ""
    for i in range(10000):
        random.seed()
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        sortedD = sorted(D.items(), key=lambda x: x[0])
        canstring = ''
        for k, v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        access_key_secret = '<access_key_secret>'
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        signature = base64.encodestring(h.digest()).strip()
        D['Signature'] = signature
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        response = requests.get(url)
        billing_cycle = response.json()["Data"]["BillingCycle"]
        account_id = response.json()["Data"]["AccountID"]
        next_token = response.json()["Data"]["NextToken"]
        if next_token is not None:
            bill = response.json()["Data"]["Items"]["Item"]
            print(bill)
            for i in bill:
                time = i["UsageEndTime"].split(" ")[0]
                if time == now_time:
                    measurement = "aliyunSettleBill"
                    tags = {
                        "BillingCycle": billing_cycle,
                        "AccountID": account_id
                    }
                    fields = {
                        "ProductName": i["ProductName"],
                        "SubOrderId": i["SubOrderId"],
                        "BillAccountID": i["BillAccountID"],
                        "DeductedByCashCoupons": i["DeductedByCashCoupons"],
                        "PaymentTime": i["PaymentTime"],
                        "PaymentAmount": i["PaymentAmount"],
                        "DeductedByPrepaidCard": i["DeductedByPrepaidCard"],
                        "InvoiceDiscount": i["InvoiceDiscount"],
                        "UsageEndTime": i["UsageEndTime"],
                        "Item": i["Item"],
                        "SubscriptionType": i["SubscriptionType"],
                        "PretaxGrossAmount": i["PretaxGrossAmount"],
                        "Currency": i["Currency"],
                        "CommodityCode": i["CommodityCode"],
                        "UsageStartTime": i["UsageStartTime"],
                        "AdjustAmount": i["AdjustAmount"],
                        "Status": i["Status"],
                        "DeductedByCoupons": i["DeductedByCoupons"],
                        "RoundDownDiscount": i["RoundDownDiscount"],
                        "ProductDetail": i["ProductDetail"],
                        "ProductCode": i["ProductCode"],
                        "ProductType": i["ProductType"],
                        "OutstandingAmount": i["OutstandingAmount"],
                        "BizType": i["BizType"], 
                        "PipCode": i["PipCode"],
                        "PretaxAmount": i["PretaxAmount"],
                        "OwnerID": i["OwnerID"],
                        "BillAccountName": i["BillAccountName"],
                        "RecordID": i["RecordID"],
                        "CashAmount": i["CashAmount"],
                    }
                    try:
                        status_code, result = datakit.write_logging(measurement=measurement, tags=tags, fields=fields)
                        print(status_code, result)
                    except:
                        print("Insertion failed!")
                else:
                    break
            else:
                continue
            break
        else:
            break
```

#### Publishing Script

**Save** configuration and **Publish**

![image.png](../images/aliyun-bill-10.png)

#### Creating Scheduled Task

Add an automatic trigger task, Management - Automatic Trigger Configuration - New Task. Since the bill is a daily bill, setting the collection frequency once a day is sufficient.

![image.png](../images/aliyun-bill-11.png)

#### Viewing Reported Data

Log preview

![image.png](../images/aliyun-bill-12.png)

#### Creating Explorer

Import Explorer

![image.png](../images/aliyun-bill-13.png)