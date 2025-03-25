# Cloud Account Management

During the operation of an enterprise, it often needs to use multiple cloud service accounts to meet different business requirements. However, when these cloud services fail, a decentralized management approach may lead to inefficiency and increase the operational costs for the enterprise.

The <<< custom_key.brand_name >>> cloud account management feature consolidates all of the enterprise’s cloud service accounts for unified management, distinguishing them by the uniqueness of certain configurations under each account. By configuring integrated collectors, each cloud service under an account is managed independently, thereby achieving fine-grained control over business data.

This management method not only simplifies the enterprise's cloud service management process but also helps quickly locate and resolve service failures, significantly reducing management costs and improving fault response speed.

**Note**: This feature currently supports configuration only by **workspace owners and managers**.

## Add Authorization {#cloud-authorize}

Currently supports authorization for [AWS accounts](#aws) and [Alibaba Cloud accounts](#alibaba).

<img src="../img/cloud-account.png" width="50%" >

### AWS {#aws}

AWS account types have two authentication methods:

- [Access Keys](#ak)
- [Role Authorization](#ra)

#### Based on Access Keys {#ak}

<img src="../img/cloud-account-1.png" width="50%" >

1. Select region: Choose China or overseas as needed;
2. Enter the AWS main account ID;
3. Input the Access Key and Secret Key from AWS;
4. Enter the account alias; this will be used for display in <<< custom_key.brand_name >>>, and subsequent data collected from this account will automatically include this tag;
5. Click the **Test** button; after passing the test, creation can succeed.

#### Based on Role Authorization {#ra}

<img src="../img/cloud-account-2.png" width="50%" >

1. Select region: Choose China or overseas as needed;
2. Enter the AWS main account ID;
3. Input the Access Key and Secret Key from AWS;
4. Enter the role name under this account;
5. Input the account alias; this will be used for display in <<< custom_key.brand_name >>>, and subsequent data collected from this account will automatically include this tag;
6. Click save. You can also click the **Test** button to verify the current cloud account information.

### Alibaba Cloud {#alibaba}

#### Based on Access Keys {#alibaba_ak}

<img src="../img/cloud-account-5.png" width="50%" >

1. Select region: Choose China or overseas as needed;
2. Enter the Alibaba Cloud main account ID;
3. Input the Access Key and Secret Key from Alibaba Cloud;
4. Enter the account alias; this will be used for display in <<< custom_key.brand_name >>>, and subsequent data collected from this account will automatically include this tag;
5. Click the **Test** button; after passing the test, creation can succeed.

## Manage Authorization

Successfully created cloud accounts will be displayed here. You can perform the following operations:

- Quickly filter by **type** in the top-right corner;
- Directly input the cloud account alias in the search bar to locate it;
- Delete directly via the settings button;
- Click to enter a specific account information and edit again.


## Configure Integration

When a cloud account is successfully created, it means that the account has been authorized to <<< custom_key.brand_name >>>. Next, you can install integrations as needed under this cloud account and start collecting data.

**Note**: Different integrations require authorization for different resources. Please grant the appropriate permissions to the cloud account according to the integration documentation. Otherwise, there may be cases where the integration installation succeeds, but data collection fails.

**Prerequisite**: The [DataFlux Func (Automata)](../dataflux-func/automata.md) must be activated.


### Configuration in Cloud Account Information

Click into the cloud account information details page > Integrations, where you can view all related integrations under the current account.

![](img/cloud-inte.png)

Click the **Install** button on the right to enter the automatic installation page:

![](img/cloud-inte-1.png)

1. The cloud account is automatically filled in;
2. Select the applicable region type as needed;
3. The system will automatically identify the metrics included in the current integration script, which you can adjust as needed;
4. Filters currently support `=` and `in` operations;
5. Click Install. After successful installation, continue with the script installation.

![](img/cloud-inte-2.png)

### Direct Configuration on the Integration Side

**Prerequisites**:

- Activate DataFlux Func (Automata);
- [Cloud account authorization has been configured](#cloud-authorize) in the management section.

![](img/cloud-inte-4.png)


1. Go to **Integrations** and install directly. In a single integration installation page, you can configure multiple cloud accounts;
2. Click to add a cloud account;
3. Check other cloud accounts that need configuration and set up regions, metrics, and filters;
4. Click Install, and the cloud account will be updated to the latest configuration.

![](img/cloud-inte-3.png)


![](img/cloud-inte-5.png)


## Delete/Uninstall Integration

- On the cloud account management list page, click :octicons-gear-24:, to delete the cloud account. After deletion, no further collection of all configured integrations under this cloud account will occur, but previously collected data will not be affected.

- On the cloud account details page > Integrations, click Uninstall, and no further collection of this integration will occur, but previously collected data will not be affected.

- On the integration side, click Uninstall, and all AWS cloud accounts will stop collecting data for this integration. If you only want a particular cloud account to stop collecting, go to the cloud account configuration page and operate there.