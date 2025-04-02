# DingTalk Robot 

To adapt to the latest DingTalk robot model, you need to first create an internal enterprise application robot on the DingTalk development platform.

> For more details, refer to [Creating and Installing Internal Enterprise Application Robots](https://open.dingtalk.com/document/orgapp/overview-of-development-process).

???- warning "Differences between old and new DingTalk robots"

    - DingTalk Platform: Creating a robot has changed from being directly created under **Group Management** to creating an application on the **Development Platform**;   
    - <<< custom_key.brand_name >>>: The latest DingTalk robot secret key configuration is no longer a mandatory field.

## Create an Internal Enterprise Application Robot

First, apply for **Developer Permissions** on the DingTalk development platform for your organization.

### Create an Application
 
1. Select **Application Development > DingTalk Application > Create Application**, and click to create the application;   
2. After the application is created, click **Application Details** on the right side, and go to the robot configuration page to fill in relevant configurations;
3. In the target group, click **Add Robot**, and select the newly created application robot from the enterprise robot list;   
4. Obtain the robot Webhook address. In the robot management section, find the newly created application robot, click to view details, and copy the Webhook address.

<img src="../img/notify_001.png" width="60%" >

<img src="../img/notify_002.png" width="60%" >

???+ warning "Note"

    Here, the robot is used only for receiving information, there is no interaction. The message reception mode configuration can be chosen arbitrarily, and under HTTP mode, the address can be left blank.

## Return to the DingTalk Robot Configuration Page

1. After successfully adding the robot to the DingTalk group, you can query the robot’s **Signature** secret key and **Webhook** address in the robot configuration details.

2. Enter the configuration information, including a custom notification target name, secret key, and Webhook address.

<img src="../img/10_inform_03.png" width="60%" >


## Configure on the <<< custom_key.brand_name >>> Side

1. Return to the page where the DingTalk robot is configured as a notification target;
2. Fill in the secret key and **Webhook** address obtained in the previous steps.