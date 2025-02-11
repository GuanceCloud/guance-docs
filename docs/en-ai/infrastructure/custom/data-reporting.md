# Resource Catalog Data Reporting
---

Resource catalog data reporting requires first installing and connecting DataKit and DataFlux Func, then reporting data to DataKit via DataFlux Func, and finally DataKit reports the data to the Guance workspace.

![](../img/object.png)

## Installing DataKit

In the Guance workspace, click **Integration > DataKit** sequentially, choose the DataKit installation method as shown below, then copy the **installation command** and execute it on the host.

![](../img/1.datakit_install.png)

Open a command-line terminal tool, log in to the host, and execute the copied **installation command**. After installation is complete, you will see `Install Success`.

> [Learn more about getting started with DataKit](../../datakit/datakit-service-how-to.md).

## Installing DataFlux Func

In the Guance workspace, click **Integration > Extensions**, and follow the steps below to install Func in the command-line terminal tool.

![](../img/1.func_install.png)

1. Download the portable version;

   ![](../img/3.object_more_api_function_2.png)

2. Automatic deployment script installation;

   ![](../img/3.object_more_api_function_3.png)

3. After installation is complete, enter `http://server_IP_address:8088` in your browser, and click **Save and Initialize Database** to initialize.

   ![](../img/3.object_more_api_function_1.png)

> For more information on Func installation, refer to [Quick Start](https://func.guance.com/doc/quick-start/).

## Connecting DataFlux Func and DataKit

Before using DataFlux Func to write data to DataKit, ensure connectivity. Therefore, after DataKit installation is complete, adjust the configuration to allow DataFlux Func to connect.

1. Open the DataKit configuration: `sudo vim /usr/local/datakit/conf.d/datakit.conf`;

2. Change `http_listen = "localhost:9529"` to `http_listen = "0.0.0.0:9529"`;

3. Restart DataKit.
   ```bash
   sudo datakit --restart
   ```

![](../img/21.lab_rum_3.png)

> For more details, refer to [Connecting and Operating DataKit](https://func.guance.com/doc/practice-connect-to-datakit/).

## Reporting Resource Catalog Data

After connecting DataFlux Func and DataKit, you can write functions in DataFlux Func to report resource catalog data.

> For API documentation on DataFlux Func function calls, refer to [DataKit API](../../datakit/apis.md);  
>
> For instructions on how DataFlux Func writes data to DataKit, refer to [Writing Data via DataKit](https://func.guance.com/doc/practice-write-data-via-datakit/).

## Example Description

The following example primarily uses Alibaba Cloud products to illustrate how to report resource catalog data through DataFlux Func.

**Prerequisites**: DataKit and DataFlux Func have been installed and connected.

1. Enter `http://server_IP_address:8088` in your browser, input the account and password (default is `admin/admin` during initialization).

   ![](../img/3.object_more_api_function_4.png)

2. After logging into DataFlux Func, you can add scripts in the **Script Editor**.

   ![](../img/3.object_more_api_function_5.png)

3. DataFlux Func supports writing scripts in Python to report data. Before adding scripts, install Alibaba Cloud's Python SDK.

   1) In DataFlux Func **Management > Experimental Features > Enable PIP Tool Module**.

      ![](../img/3.object_more_api_function_6.png)

   2) In the **PIP Tool** module, click to open the [Alibaba Cloud Python SDK](https://help.aliyun.com/document_detail/53090.html?spm=a2c4g.11186623.6.556.3533694ccdcH5B) URL, copy `aliyun-python-sdk-core` for installation.

      ![](../img/3.object_more_api_function_8.png)

4. After installing Alibaba Cloud's Python SDK, click into **Script Editor > Add Script Set**.

   ![](../img/3.object_more_api_function_9.png)

Based on the [DataKit API](../../datakit/apis.md) documentation, obtain the reporting API interface and write the script to report data to DataFlux. Based on the [Alibaba Cloud API](https://next.api.aliyun.com/product/Ecs) documentation, write the fields to retrieve basic information about Alibaba Cloud products.

After writing the script, you can click the **Execute** button in the top-right corner to check if the code runs correctly.

![](../img/3.object_more_api_function_10.1.png)

Refer to the following script code, which can be modified according to the prompts in the image.

```python
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
    response = requests.post('http://server_IP_address:9529/v1/write/custom_object', params=params, data=data)
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

5. After configuring and executing the DataFlux Func script, you can view the reported data in the Guance workspace under **Infrastructure > Custom**.

   ![](../img/3.object_more_api_function_11.png)

6. If you need to schedule script execution, create a scheduled reporting task in **DataFlux Func > Management > Automatic Trigger Configuration**.

   ![](../img/3.object_more_api_function_12.png)