# Solving Alibaba Cloud API Signature Issues to Achieve Billing Analysis

---

Compared with purchasing private hosts, buying multiple public cloud resources has a different awareness of costs. Purchasing private hosts is a one-time investment; whether you use them or not after purchase, and how well they are used, will not continuously impact your subsequent investments. However, purchasing public cloud resources requires constant reminders: although the initial investment is lower, each day that passes incurs daily charges. Therefore, we urgently need methods to clearly view detailed cost expenditures and billing analysis across multiple cloud resources.

## Collecting Alibaba Cloud Billing API

Firstly, taking Alibaba Cloud billing as an example, if we want to collect and analyze Alibaba Cloud's billing information, we need to be sufficiently familiar with the transaction and billing management API. When calling Alibaba Cloud APIs, the most challenging part is the signature (Signature) mechanism. Alibaba Cloud also has [specific documentation](https://help.aliyun.com/document_detail/87971.html) in its general documentation, but this only explains the signature mechanism, which can be quite challenging for less experienced developers. So, based on this incomplete documentation, how do we proceed with collecting billing data?

### API Request Principle

Simply put, calling Alibaba Cloud API is an HTTP request (mostly GET, this example also uses GET), followed by a series of parameters. For instance, a request to view snapshots looks like this:

```html
http://ecs.aliyuncs.com/?SignatureVersion=1.0&Format=JSON&Timestamp=2017-08-07T05%3A50%3A57Z&RegionId=cn-hongkong&AccessKeyId=xxxxxxxxx&SignatureMethod=HMAC-SHA1&Version=2017-12-14&Signature=%2FeGgFfxxxxxtZ2w1FLt8%3D&Action=DescribeSnapshots&SignatureNonce=b5046ef2-7b2b-11e7-a3c5-00163e001831&ZoneId=cn-hongkong-b
```

The common parameters required in the request (those needed for all API calls) are:

```html
SignatureVersion # Signature algorithm version, currently 1.0 
Format # Format of the returned message, JSON or XML with default being XML
Timestamp # Request timestamp, UTC time, e.g., 2021-12-16T12:00:00Z 
AccessKeyId # Account secret key ID
SignatureMethod # Signature method, currently HMAC-SHA1
Version # Version number, date format, e.g., 2017-12-14, varies by product
Signature # The most difficult to handle, the signature
SignatureNonce # Unique random number, prevents network attacks. Use different random numbers for different requests.
```

Except for `Signature`, other parameters are relatively easy to obtain, some even have fixed values. Refer to [Alibaba Cloud documentation](https://help.aliyun.com/document_detail/87969.html) for specifics. Besides common parameters, specific interface (`Action`) request parameters are also needed. Each `Action` interface parameter can be found in the corresponding product’s API documentation, such as [QuerySettleBill](https://help.aliyun.com/document_detail/173110.html). The `Signature` is based on both common and interface parameters, making it more complex.

### Constructing Canonicalized Request String

- Construct dict  
  In Python, parameters correspond one-to-one using a dictionary. Create a dictionary and add the request parameters.

```python
D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    # 'PageNum': '5',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': 'LTAI5tLumx55Vui4WJwZJneK',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    # 'NextToken': "", #?
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
    # 'SignatureNonce': str_seed
}
```

- Sorting  
  Since the signature requires uniqueness, including order, sort the parameters by name.

```python
sortedD = sorted(D.items(), key=lambda x: x[0])
```

- URL Encoding  
  Standard request strings require UTF-8 character sets. Encode non-compliant characters in parameter names and values according to these rules:

> Characters AZ, az, 0~9, and “-”, “_”, “.”, “~” are not encoded;<br /> Other characters are encoded into %XY format, where XY is the hexadecimal representation of the ASCII code of the character. For example, English double quotes (“”) are encoded as %22;<br /> Extended UTF-8 characters are encoded into %XY%ZA… format;<br /> Spaces should be encoded as %20, not plus (+).

> Note: Libraries that support URL encoding (such as Java’s java.net.URLEncoder) encode according to the MIME type "application/x-www-form-urlencoded". Implementations can directly use such methods, replacing plus (+) with %20, star (*) with %2A, and %7E with tilde (~) to get the encoded string as described above.

Using Python’s `urllib` library for encoding:

```python
def percentEncode(str):
    res = urllib.parse.quote(str.encode('utf8'), '')
    res = res.replace('+', '%20')
    res = res.replace('*', '%2A')
    res = res.replace('%7E', '~')
    return res
```

- Generating Canonicalized Request String

```python
canstring = ''
for k, v in sortedD:
    canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
```

### Constructing StringToSign

The rule is:

> StringToSign=<br />HTTPMethod + “&” +<br />percentEncode(“/”) + ”&” +<br />percentEncode(CanonicalizedQueryString)

In this example:

```python
stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
```

### Calculating HMAC Value

```python
access_key_secret = '<access_key_secret>'
h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
```

### Calculating Signature Value

```python
signature = base64.encodestring(h.digest()).strip()
```

Thus, the `signature` is generated.

### Adding Signature

```python
D['Signature'] = signature
```

So, in this example, the final request URL is:

```python
url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
http://business.aliyuncs.com/?BillingCycle=2021-12&Action=QuerySettleBill&Format=JSON&Version=2017-12-14&AccessKeyId=LTAI5tLumx55Vui4WJwZJneK&SignatureMethod=HMAC-SHA1&MaxResults=300&Timestamp=2021-12-16T12%3A27%3A58Z&SignatureVersion=1.0&SignatureNonce=0.30196531140307337&NextToken=&Signature=zFb4631sSGONvAeWD3xCIovMeoM%3D
```

You can directly access this URL in the browser to get the result:

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


# Common parameters required for API calls
D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    # 'PageNum': '5',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': '<AccessKeyId>',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    # 'NextToken': "", #?
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
    # 'SignatureNonce': str_seed
}
# Current time
now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

# Connect to local Datakit
datakit = DFF.SRC('datakit')

# Using Python's urllib library for encoding
def percentEncode(str):
    res = urllib.parse.quote(str.encode('utf8'), '')
    res = res.replace('+', '%20')
    res = res.replace('*', '%2A')
    res = res.replace('%7E', '~')
    return res


# Get bill
def getBill():
    # Bill current record position
    next_token = ""
    # Loop to get bills and write to DataKit
    for i in range(10000):
        random.seed()
        # Unique random number, used to prevent replay attacks. Different random values should be used for different requests.
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        # Sort parameters by name for uniqueness
        sortedD = sorted(D.items(), key=lambda x: x[0])
        # Generate canonicalized request string
        canstring = ''
        for k, v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        # Generate canonicalized request string
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        # Access key secret
        access_key_secret = '<access_key_secret>'
        # Calculate HMAC value
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        # Calculate signature value
        signature = base64.encodestring(h.digest()).strip()
        # Add signature
        D['Signature'] = signature
        # Final API call
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        # Request Alibaba Cloud billing fees
        print(url)
```

## Demonstrating Technical Route Selection

### Architecture Concept

![image.png](../images/aliyun-bill-2.png)

We plan to use Crontab to schedule Python scripts at regular intervals to fetch Alibaba Cloud billing data and store it in MySQL, then visualize the data via Grafana. We can simplify operations by using Grafana Dashboards templates. Below is a technical survey based on this architecture concept.

### Technical Survey

Among open-source visualization tools, Grafana is the most popular due to its extensive visual templates. Kibana is another excellent visualization platform suitable for ELK architecture. Given our requirements, Kibana is not as fitting as Grafana, which is an open-source visualization tool that can work with various data storage systems and offers rich features like Graphite-web. It helps us easily create and edit dashboards and includes a unique Graphite target parser for metric and feature editing. Users can create comprehensive charts with smart axis formats like lines and points. Additionally, Grafana comes with a built-in alert engine that allows attaching conditional rules to dashboard panels to trigger alerts sent to selected notification endpoints (e.g., email, Slack, PagerDuty, custom Webhooks). This perfectly meets the need for early warning of Alibaba Cloud expenses. However, Grafana is designed primarily for analyzing and visualizing system CPU, memory, disk, and I/O utilization metrics and does not support full-text data queries, which can make the user experience less friendly. After exploring the open-source community, we found “[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/)” which not only covers all the advantages of Grafana and Kibana but also offers many unique features, including Serverless online programming scheduling, solving the pain point of managing Python script scheduling for Alibaba Cloud billing data. As a commercial open-source product, it also has a visually appealing UI design and provides free quotas that meet our needs. Moreover, when encountering issues, users can receive official support.

### Technical Comparison

|  | Grafana | <<< custom_key.brand_name >>> |
| --- | --- | --- |
| Usage Complexity | Installation and configuration are relatively cumbersome, requiring additional storage engines | One command installation, ready to use in 30 minutes |
| Documentation Completeness | Comprehensive documentation on the Grafana website, but limited Chinese documentation | Very comprehensive Chinese documentation and numerous usage guides |
| Community Activity | Active community, strong development and maintenance teams, fast version upgrades | Commercial product with very active community, strong development and maintenance teams, quick issue resolution, fast version upgrades |
| Feature Completeness | Supports 54 data sources, 173+ Dashboards, rich dashboard plugins like heatmaps, line charts, tables, etc., simple alert support | Supports 200+ data source integrations, 200+ Dashboards, multiple OS support, standard unified DQL query for various data types, unified management of metric data, log data, APM layer data, infrastructure, containers, middleware, network performance, powerful anomaly detection, advanced permission functions, complex alert rule configuration support |
| Development Trend | Market share is increasing, rapidly developing and improving | As a mature commercial product and leader in observability, market share is increasing, rapidly developing and improving |
| Performance | Low resource consumption | Unified management, low resource consumption, binary files for high transmission efficiency and low bandwidth usage |
| Serverless Programming | None | Based on Python3.x sandbox environment |
| Cost | Free | Free |
| Service | Community assistance | Professional technical team support |

### Requirement Matching

Through the comparison, we find that using “<<< custom_key.brand_name >>>” can significantly reduce usage costs and greatly simplify installation, configuration, and management compared to Grafana, which only serves as a display platform and relies on external storage engines as data sources. “<<< custom_key.brand_name >>>” handles the collection and unified management of various data types such as metric data, log data, APM layer data, infrastructure, containers, middleware, and network performance, reducing the complexity of installing and maintaining storage engines. Grafana lacks comprehensive Chinese documentation, which can be challenging for those who are not proficient in English. On the other hand, “<<< custom_key.brand_name >>>” offers comprehensive Chinese documentation and numerous instructional videos, making it easier to use. Even when using it for free, users can receive professional technical support and benefit from a large community. Functionally, it supports powerful anomaly detection, advanced permission settings, and complex alert rule configurations, meeting needs beyond expense analysis. Additionally, “<<< custom_key.brand_name >>>” allows for unified management of components through a visual interface, with low resource consumption, efficient data transmission, and minimal bandwidth usage. For aesthetes, the product UI design of “<<< custom_key.brand_name >>>” stands out with its minimalist style. Therefore, for our requirements, choosing to build with “<<< custom_key.brand_name >>>” is the best option.

## <<< custom_key.brand_name >>> Implementation for Expense Management

### Deployment Instructions

Example Linux version: CentOS Linux release 7.8.2003 (Core)

Collecting all Alibaba Cloud billing data through a single server.

### Prerequisites

#### Install DataKit

Before starting to monitor hosts with “<<< custom_key.brand_name >>>”, install DataKit. DataKit is the official data collection application that supports over a hundred types of data collection. By configuring data sources, it can real-time collect data such as host, process, container, logs, APM, and user access.

Before installing DataKit, register for a [“<<< custom_key.brand_name >>>” account](https://<<< custom_key.brand_main_domain >>>/). After registration, log in to the “<<< custom_key.brand_name >>>” workspace to obtain the DataKit installation instructions and deploy the first DataKit.

##### Obtain Installation Instructions

Log in to the “<<< custom_key.brand_name >>>” workspace, click sequentially on 「Integration」-「DataKit」, choose the DataKit installation method, see the following information, then copy the 「Installation Instructions」and execute them on the host.

- Operating System: Linux

- System Type: X86 amd64

- DataWay Address: OpenWay

![image.png](../images/aliyun-bill-3.png)

##### Execute Installation Instructions on Host

Open the command-line terminal tool, log in to the server, and execute the copied 「Installation Instructions」. After installation, a prompt `Install Success` will appear. You can check the DataKit installation status, manual, and update records through the provided link.

![2.Install datakit.png](../images/aliyun-bill-4.png)

##### Start Using “<<< custom_key.brand_name >>>”

After successfully installing DataKit, the host object collector `hostobject` is already enabled by default. You can directly view the installed DataKit host under the “<<< custom_key.brand_name >>>” workspace’s 「Infrastructure」-「Host」, including host status, hostname, operating system, CPU usage rate, MEM usage rate, CPU single-core load, etc. Click the host to view more details.

![4.View host.png](../images/aliyun-bill-5.png)

#### Install Func Portable Edition

##### System and Environment Requirements

The host running DataFlux Func must meet the following conditions:

- CPU cores >= 2

- Memory capacity >= 4GB

- Disk space >= 20GB

- Network bandwidth >= 10 Mbps

- Operating system is Ubuntu 16.04 LTS/CentOS 7.2 or higher

- Clean system (after installing the operating system, no other operations except network configuration)

- Open port `8088` (the system defaults to using port `8088`; ensure firewall, security groups, etc., allow inbound access on port `8088`)

- If using external MySQL, the MySQL version must be 5.7 or higher

- If using external Redis, the Redis version must be 4.0 or higher

> _Note: DataFlux Func does not support MacOS or Windows. You can choose to install DataFlux Func in a virtual machine or cloud server._

> _Note: DataFlux Func does not support cluster Redis. Choose master-slave versions for high availability_

> _Note: If installing DataFlux Func on Alibaba Cloud ECS with AliCloud Shield plugin enabled, since the shield itself consumes many resources, the system configuration should be appropriately increased_

##### Portable Edition Download Command

```shell
/bin/bash -c "$(curl -fsSL https://t.guance.com/func-portable-download)"
```

> _Note: All shell commands mentioned in this article can be run directly under root user. Non-root users need to add sudo_
>
> _Note: This article only provides the most common operation steps. Detailed installation and deployment refer to the 「Maintenance Manual」_

##### Execute Automatic Installation Script

In the downloaded `dataflux-func-portable` directory,  
run the following command to automatically configure and start the entire DataFlux Func:

> _Note: Confirm system requirements and server configuration before installation_
>
> _Note: DataFlux Func does not support Mac, please copy and run it on a Linux system_

```shell
sudo /bin/bash run-portable.sh
```

Using the automatic installation script can achieve quick installation and operation within minutes. The automatic configuration includes:

- Running MySQL, Redis, DataFlux Func (including Server, Worker, Beat)

- Automatically saving all data under `/usr/local/dataflux-func/` (including MySQL data, Redis data, DataFlux Func configuration, log files, etc.)

- Randomly generating MySQL `root` user password, system Secret, and saving them in the DataFlux Func configuration file

- No password set for Redis

- MySQL, Redis do not provide external access

After execution, you can access the initialization interface via `http://{server IP address/domain}:8088`.

> _Note: If the runtime environment performance is poor, use the `docker ps` command to confirm all components have started successfully before accessing (see the following list)_

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

1. Create a new user: Personnel Management - Users - Create User
![image.png](../images/aliyun-bill-6.png)

1. Save or download the **AccessKeyID** and **AccessKey Secret** CSV file (used in configuration)

1. Authorize user (billing permissions)
![](../images/aliyun-bill-7.png)

### Configuration Implementation

#### Log in to DataFlux Function

Log in to Func at `http://ip:8088` (default admin/admin)

![](../images/aliyun-bill-8.png)

#### Create Script Set

Enter title/description information

![image.png](../images/aliyun-bill-9.png)

#### Edit Script

Write a script to write billing data to DataKit for report creation.

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


# Common parameters required for API calls
D = {
    'BillingCycle': str(time.strftime("%Y-%m", time.gmtime())),
    'Action': 'QuerySettleBill',
    # 'PageNum': '5',
    'Format': 'JSON',
    'Version': '2017-12-14',
    'AccessKeyId': '<AccessKeyId>',
    'SignatureMethod': 'HMAC-SHA1',
    'MaxResults': '300',
    # 'NextToken': "", #?
    'Timestamp': str(time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())),
    'SignatureVersion': '1.0'
    # 'SignatureNonce': str_seed
}
# Current time
now_time = str(time.strftime("%Y-%m-%d", time.gmtime()))

# Connect to local Datakit
datakit = DFF.SRC('datakit')

# Using Python’s urllib library for encoding
def percentEncode(str):
    res = urllib.parse.quote(str.encode('utf8'), '')
    res = res.replace('+', '%20')
    res = res.replace('*', '%2A')
    res = res.replace('%7E', '~')
    return res


# Get bill
@DFF.API('getBill')
def getBill():
    # Current record position of the bill
    next_token = ""
    # Loop to get bills and write to DataKit
    for i in range(10000):
        random.seed()
        # Unique random number, used to prevent replay attacks. Different random values should be used for different requests.
        D["SignatureNonce"] = str(random.random())
        D["NextToken"] = next_token
        # Sort parameters by name for uniqueness
        sortedD = sorted(D.items(), key=lambda x: x[0])
        canstring = ''
        for k, v in sortedD:
            canstring += '&' + percentEncode(k) + '=' + percentEncode(v)
        # Generate canonicalized request string
        stringToSign = 'GET&%2F&' + percentEncode(canstring[1:])
        # Access key secret
        access_key_secret = '<access_key_secret>'
        # Calculate HMAC value
        h = hmac.new((access_key_secret + "&").encode('utf8'), stringToSign.encode('utf8'), sha1)
        # Calculate signature value
        signature = base64.encodestring(h.digest()).strip()
        # Add signature
        D['Signature'] = signature
        # Final API call
        url = 'http://business.aliyuncs.com/?' + urllib.parse.urlencode(D)
        # Request Alibaba Cloud billing fees
        response = requests.get(url)
        billing_cycle = response.json()["Data"]["BillingCycle"]
        account_id = response.json()["Data"]["AccountID"]
        next_token = response.json()["Data"]["NextToken"]
        if next_token is not None:
            bill = response.json()["Data"]["Items"]["Item"]
            print(bill)
            # Write daily bill to <<< custom_key.brand_name >>>
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

Add an automatic trigger task, manage - automatic trigger configuration - create task. Since the bill is a daily bill, setting the collection frequency to once a day is sufficient.

![image.png](../images/aliyun-bill-11.png)

#### View Reported Data

Log preview

![image.png](../images/aliyun-bill-12.png)

#### Create Viewer

Import viewer

![image.png](../images/aliyun-bill-13.png)