# Product Deployment Instructions 
---

Guance Deployment allows users to install Guance system software and run services on their own local infrastructure environment or private cloud environment. Including commercial deployment version and community version, which commercial deployment version is divided into subscription, license and pay-as-you-go version. 

## Product Framework
![](img/6.deployment_1.jpg)
## Community Version 

Guance Community Version provides a simple, easy-to-get and fully functional local deployment platform for community users such as teachers, students and cloud computing enthusiasts. Welcome to apply for free, download and try it out, build your own Guance platform and experience complete product functions. 

### Use Steps

#### Step1: Deploy Community Version

You can choose to deploy online or offline by referring to the doc [Cloud Deployment](cloud-deployment-manual.md) or [Offline Environment Deployment](offline-deployment-manual.md) or [Alibaba Cloud Computing Nest Deployment](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m).

#### Step2: Get Community License and AK/SK

##### Register a Community Account
Method 1: Open the Guance launcher, click the "License Activation and AK/SK Configuration" menu in the "Settings" in the upper right corner, scan the code and pay attention to the "Guance" service number, and get the community version registration address: 

![](img/6.deployment_2.png)

Method 2: Or directly open the community version registration address（[https://boss.guance.com/index.html#/signup?type=community](https://boss.guance.com/index.html#/signup?type=community)）and register the community version account according to the prompts. 

![](img/6.deployment_3.png)

After registration, enter the Guance Community Version Expense Center. 

![](img/6.deployment_4.png)

##### Get AK/SK

In the "AK Management" of the Guance Community Version Expense Center, click "Create AK", and the created AK and SK can be filled in the AK and SK of "Step4: Activate Community Version" after being copied. 

![](img/6.deployment_5.png)

##### Get License

In the "License Management" of the Guance Community Expense Center, click "Create License". When creating License, you need to agree to the community user license agreement and pass the mobile phone verification. After copying, the created License can be filled into the License text of "Step2: Activate the Community Version". 

![](img/6.deployment_6.png)

#### Step3: Deploy DataWay, a Data DataWay

In addition to obtaining AK, AS and License, it is necessary to fill in the address of the data gateway to receive the data of the availability monitoring service center of Guance to activate the community version. For how to deploy the data gateway, please refer to the doc [deploy DataWay](how-to-start.md).

#### Step4: Activate the Community Version

After obtaining License and AK/SK through the above steps, open the Guance Launcher and click the menu of "License Activation and AK/SK Configuration" in "Settings" in the upper right corner: 

![](img/6.deployment_7.png)

Fill in the License, AK/SK and data gateway address obtained earlier to complete the activation of the community version: 

![](img/6.deployment_8.png)

**Note:** In the configuration of "Data Gateway Address", fill in the section after the question mark **`?token={}`** as it is and do not change it. 

#### Step5: Start Using Guance

After the community version is activated, you can create a workspace and start using Guance. Refer to the doc [getting started](how-to-start.md) on how to Create Guance Community User and Workspace. 

![](img/6.deployment_9.png)

## Commercial Deployment Version 

Guance Community Version can be upgraded to Commercial Deployment Version by version upgrade. The commercial deployment version is to obtain the local installation package and license of the Guance platform by subscribing or purchasing licenses, so as to create your exclusive version of Guance. During the service period, Guance would continue to provide upgrade packages and online support services to ensure that your platform can be upgraded to the latest version. 

![](img/6.deployment_10.png)

### Pay-as-you-go Version

The end user obtains the authorization to use Guance software by subscription on a daily basis, and the authorization unit is the maximum number of online active access collectors counted on that day. During the subscription period, users can always get the latest version upgrade of Guance software and enjoy standard support services. 

Note: The pay-as-you-go version needs to report the usage data to the gateway of Guance in the public network in real time. 

### Subscription Version

End users are authorized to use Guance software by annual subscription, and the authorized unit is the number of collectors supporting access. During the subscription period, users can always get the latest version upgrade of Guance software and enjoy standard support services. 

Note: The minimum subscription period is 1 year. 

### License Version

End users can obtain the permanent use right of the designated version of License Version by paying a one-time fee, and the authorized unit is the number of collectors supporting access. Buy the default one-year maintenance service, and users can pay annual to renew the maintenance service. During the validity period of maintenance service, users can always get the latest version upgrade of License Version software and enjoy standard support services. 

## Version Comparison

| Version |  | Available Time | Upgrade Service | Technical Support | Installation Package Acquisition | License |
| --- | --- | --- | --- | --- | --- | --- |
| Commercial Deployment Version | Subscription | Starting from 1 year and renewed annually. | Subscription can be upgraded within the validity period. | Subscription period: 5*8 hours | Any supported access path | required |
|  | License Version | Permanent, give away one-year maintenance, and the maintenance would be renewed annually. | It can be upgraded within the validity period of maintenance. | Maintenance period: 5*8 hours | Any supported access path  | required |
|  | Pay-as-you-go Version | Starting from 1 day and renewing on a daily basis | Subscription can be upgraded within the validity period. | Subscription period: 5*8 hours | Any supported access path  | required |
| Community Version  |  | Each version can be used within 180 days from the release date. | Self-upgrading  | Community support | Any supported access path | required |

