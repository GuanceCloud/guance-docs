# Resource Catalog Data Reporting
---


To report resource catalog data, you must first install and connect DataKit and DataFlux Func, then report the data through DataFlux Func to DataKit, and finally DataKit will report the data to the <<< custom_key.brand_name >>> workspace.

![](../img/object.png)

## Installing DataKit

In the <<< custom_key.brand_name >>> workspace, click sequentially on **Integration > DataKit**, choose the DataKit installation method as shown in the following information, then copy the **installation command** and execute it on the host.

![](../img/1.datakit_install.png)

Open a command-line terminal tool, log into the host, and execute the copied **installation command**. After the installation is complete, it will prompt `Install Success`.

> [Learn more about DataKit Getting Started](../../datakit/datakit-service-how-to.md).

## Installing DataFlux Func

In the <<< custom_key.brand_name >>> workspace, click sequentially on **Integration > Extensions**, and follow the steps below to install Func in the command-line terminal tool.

![](../img/1.func_install.png)

1. Download the portable version;

![](../img/3.object_more_api_function_2.png)

2. Automatic deployment script installation;

![](../img/3.object_more_api_function_3.png)

3. After installation, enter `http://Server IP Address:8088` in the browser, and click **Save and Initialize Database** to initialize.

![](../img/3.object_more_api_function_1.png)

> For more Func installation instructions, refer to [Quick Start](https://<<< custom_key.func_domain >>>/doc/quick-start/).

## Connecting DataFlux Func and DataKit

Before using DataFlux Func to write data to DataKit, ensure connectivity first. Therefore, after installing DataKit, adjust the configuration to allow DataFlux Func to connect.

1. Open the DataKit configuration: `sudo vim /usr/local/datakit/conf.d/datakit.conf`;

2. Change `http_listen = "localhost:9529"` to `http_listen = "0.0.0.0:9529"`;

3. Restart DataKit.

```
sudo datakit --restart
```

![](../img/21.lab_rum_3.png)

> For more details, refer to [Connect and Operate DataKit](https://<<< custom_key.func_domain >>>/doc/practice-connect-to-datakit/).

## Reporting Resource Catalog Data

After connecting DataFlux Func and DataKit, you can write functions in DataFlux Func to complete the reporting of resource catalog data.

> For API documentation regarding DataFlux Func function calls, refer to [DataKit API](../../datakit/apis.md);
>
> For documentation on how DataFlux Func writes data to DataKit, refer to [Write Data via DataKit](https://<<< custom_key.func_domain >>>/doc/practice-write-data-via-datakit/).

## Example Description

The example below mainly uses Alibaba Cloud products to illustrate how to report resource catalog data through DataFlux Func.

**Prerequisites**: Completion of DataKit and DataFlux Func installation and connectivity.

1. Enter `http://Server IP Address:8088` in the browser, input the account and password (which can be configured during initialization, default is `admin/admin`).

![](../img/3.object_more_api_function_4.png)

2. After logging into DataFlux Func, you can add scripts in the **Script Editor**.

![](../img/3.object_more_api_function_5.png)

3. DataFlux Func supports writing scripts in Python for reporting data. Before adding scripts, you need to install the Alibaba Cloud Python SDK first.

1) In DataFlux Func **Management > Experimental Features > Enable PIP Tool Module**.

![](../img/3.object_more_api_function_6.png)

2) In the **PIP Tool** module, open the [Alibaba Cloud Python SDK](https://help.aliyun.com/document_detail/53090.html?spm=a2c4g.11186623.6.556.3533694ccdcH5B) website, copy `aliyun-python-sdk-core` and install it.

![](../img/3.object_more_api_function_8.png)

4. After installing the Alibaba Cloud Python SDK, click to enter **Script Editor > Add Script Set**.

![](../img/3.object_more_api_function_9.png)

Based on the [DataKit API](../../datakit/apis.md) documentation, obtain the reporting API interface and write the script for reporting data to DataFlux. Based on the [Alibaba Cloud API](https://next.api.aliyun.com/product/Ecs) documentation, write the fields to get basic information about Alibaba Cloud products.

After finishing the script, you can click **Execute** in the top-right corner to check if the code runs normally.

![](../img/3.object_more_api_function_10.1.png)

The reference script code is as follows, and you can replace relevant content according to the prompts in the image above.

```
from aliyunsdkcore.request import CommonRequest
from aliyunsdkcore.client import AcsClient
import requests
import json
import time

# Push data to DF
def pushdata(data):
    params = (
        ('token', 'tokn_bW47smmgQpoZxxxxxxx'),
    )
    response = requests.post('http://Server IP Address:9529/v1/write/custom_object', params=params, data=data)
    print(response.status_code, response.text)

# Main function
@DFF.API('custom_object')
def main():
    # 1. Initialize SDK
    client = AcsClient(
        'LTAI5t6d3sRh3xxxxxxxx',  # your-access-key-id
        'CHdrce2XtMyDAnYJxxxxxxxxxxxxxx',  # your-access-key-secret
        'cn-qingdao',  # your-region-id
    )
    request = CommonRequest()
    request.set_accept_format('json')
    request.set_domain('ecs.aliyuncs.com')
    request.set_method('POST')
    request.set_version('2014-05-26')
    request.set_action_name('DescribeInstances')
    request.add_query_param('RegionId', 'cn-qingdao')
    response = json.loads(client.do_action_with_exception(request))
    for i in response["Instances"]["Instance"]:
        data = ''' aliyun_ecs,name=%s,host=%s instanceid="%s",os="%s",status="%s",creat_time="%s",publicip="%s",regionid="%s",privateip="%s",cpu=%s,memory=%s %s''' %(
            i['HostName'], 
            i['InstanceId'], 
            i['InstanceId'], 
            i['OSType'],
            i['Status'], 
            i['CreationTime'], 
            i['PublicIpAddress']['IpAddress'],
            i['RegionId'], 
            i['NetworkInterfaces']['NetworkInterface'][0]['PrivateIpSets']['PrivateIpSet'][0]['PrivateIpAddress'],
            i['Cpu'],
            i['Memory'], 
            int(time.time()))
        print(data)
        pushdata(data)
```

5. After configuring and executing the DataFlux Func script, you can view the reported data in the <<< custom_key.brand_name >>> workspace under **Infrastructure > Custom**.

![](../img/3.object_more_api_function_11.png)

6. If you need to schedule the execution of the script tasks, you can create scheduled reporting tasks in **DataFlux Func > Management > Auto Trigger Configuration**.

![](../img/3.object_more_api_function_12.png)