# Data Report
---


Custom object data reporting needs to install and connect DataKit and DataFlux Func first, then report data to DataKit through DataFlux Func, and finally DataKit reports data to Guance workspace.

![](../img/object.png)

## Install DataKit

In the Guance workspace, click **Integration > DataKit** in turn, select the DataKit installation method, see the following information, and then copy the installation to execute on the host.

![](../img/1.datakit_install.png)

Open the command line terminal tool, log in to the host, and execute the copied installation command. After the installation is complete, it will prompt `Install Success`.

> See [Getting Started with DataKit](../../datakit/datakit-service-how-to.md).

## Install DataFlux Func

In the Guance workspace, click "Integration"-"Func" in turn, and install Func in the command line terminal tool according to the following steps.

![](../img/1.func_install.png)

I. Download the portable version.

![](../img/3.object_more_api_function_2.png)

II. Automatically deploy script installation.

![](../img/3.object_more_api_function_3.png)

III. After the installation is complete, enter `http://server IP address:8088` in the browser and save and initialize database to initialize.

![](../img/3.object_more_api_function_1.png)

> For more Func installations, see [Quick Start](../../dataflux-func/quick-start.md).

## Connect DataFlux Func and DataKit

Before using DataFlux Func to write data to a DataKit, ensure connectivity first. Therefore, after the DataKit installation is complete, you need to adjust the configuration to allow the DataFlux Func connection.

I. Open the datakit configuration: `sudo vim /usr/local/datakit/conf.d/datakit.conf`

II. Amend `http_listen = "localhost:9529"` to `http_listen = "0.0.0.0:9529"`

![](../img/21.lab_rum_3.png)

III. Restart DataKit: `sudo datakit --restart`

> For more details, see [Connect and Operate DataKit](../../dataflux-func/connect-to-datakit.md).

## Report Custom Data

After DataFlux Func and DataKit are connected, you can write functions in DataFlux Func to report custom object data.

> See [DataKit API](../../datakit/apis.md) for an interface description of the DataFlux Func function call.

## Example Description

The following example mainly uses Alibaba Cloud products as an example to show how to report custom object data through DataFlux Func.

**Preconditions**: DataKit and DataFlux Func are installed and connected.

I. Enter `http://server IP address:8088` in the browser, and enter the account number and password, which can be configured at initialization time. The default is `admin/admin`.

![](../img/3.object_more_api_function_4.png)

II. After you log in to DataFlux Func, you can add scripts in the Script Editor.

![](../img/3.object_more_api_function_5.png)

III. DataFlux Func supports scripting data through Python. Before you start adding scripts, you need to install Alibaba Cloud's Python SDK.

i. In DataFlux Func **Management > Experimental Features > Open PIP Tool Module**.

![](../img/3.object_more_api_function_6.png)

ii. In the PIP Tools module, click to open [Alibaba Cloud's Python SDK](https://help.aliyun.com/document_detail/53090.html?spm=a2c4g.11186623.6.556.3533694ccdcH5B) and copy `aliyun-python-sdk-core` for installation.

![](../img/3.object_more_api_function_8.png)

IV. After installing Alibaba Cloud's Python SDK, click to enter **Script Editor > Add Script Set**.

![](../img/3.object_more_api_function_9.png)

Obtain the reporting API interface and script for reporting data to DataFlux according to the [DataKit API](../../datakit/apis.md) document, and write the fields for obtaining basic information of Alibaba Cloud products according to the [Alibaba Cloud API](https://next.api.aliyun.com/product/Ecs) document.

After the script is written, you can click **Execute** in the upper right corner to see if you can execute the code normally.

![](../img/3.object_more_api_function_10.1.png)

Refer to the script code as follows, and you can replace the relevant contents according to the prompts in the above figure.

```
from aliyunsdkcore.request import CommonRequest
from aliyunsdkcore.client import AcsClient
import requests
import json
import time

#Push data to DF
def pushdata(data):
    params = (
        ('token', 'tokn_bW47smmgQpoZxxxxxxx'),
    )
    response = requests.post('http://服务器IP地址:9529/v1/write/custom_object', params=params, data=data)
    print(response.status_code, response.text)

#Principal function
@DFF.API('custom_object')
def main():
    # 1.Initialize the SDK
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

V. After the DataFlux Func script configuration is completed, the reported data can be viewed in **Infrastructure > Custom** of the Guance workspace.

![](../img/3.object_more_api_function_11.png)

VI. If you need to execute script tasks regularly, you can create timed report tasks in DataFlux Func **Management > Automatic Trigger Configuration**.

![](../img/3.object_more_api_function_12.png)
