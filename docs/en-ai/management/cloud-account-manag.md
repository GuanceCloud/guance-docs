# Cloud Account Management

During the operation of a business, it often requires multiple cloud service accounts to meet various business needs. However, when these cloud services experience issues, decentralized management can lead to inefficiencies and increase operational costs.

<<< custom_key.brand_name >>>'s cloud account management feature consolidates all of the company's cloud service accounts for unified management, distinguishing them by the uniqueness of certain configurations under each account. By configuring integrated collectors, each cloud service under an account is managed independently, thereby achieving fine-grained control over business data.

This management approach not only simplifies the cloud service management process but also helps in quickly identifying and resolving service issues, significantly reducing management costs and improving fault response speed.

**Note**: This feature is currently available only to **workspace owners and administrators** for configuration.

## Add Cloud Account Authorization {#cloud-authorize}

<font size=2>**Note**: Currently, only AWS cloud accounts are supported. Support for other cloud accounts will be available soon.</font>

AWS account types have two authentication methods: Access Keys and Role Authorization.

<img src="../img/cloud-account.png" width="60%" >

### Based on Access Keys {#ak}

<img src="../img/cloud-account-1.png" width="60%" >

1. Select Region: Choose between China and overseas regions as needed;
2. Account ID: Must be 12 characters;
3. Enter the AWS Access Key and Secret Key;
4. Enter the account alias; this will be used for display in <<< custom_key.brand_name >>>, and subsequent data collected from this account will automatically include this tag;
5. Click the **Test** button; creation will succeed only after passing the test.

### Based on Role Authorization {#ra}

<img src="../img/cloud-account-2.png" width="60%" >

1. Select Region: Choose between China and overseas regions as needed;
2. Account ID: Must be 12 characters;
3. Enter the AWS Access Key and Secret Key;
4. Enter the role name under this account;
5. Input the account alias; this will be used for display in <<< custom_key.brand_name >>>, and subsequent data collected from this account will automatically include this tag;
6. Click Save. You can also click the **Test** button to validate the current cloud account information.

## Account List

Successfully created cloud accounts will be displayed here. You can perform the following operations:

- Quickly filter by **type** using the options in the top-right corner;
- Search for a cloud account alias directly in the search bar to locate it;
- Delete the account directly via the settings button;

<img src="../img/cloud-account-3.png" width="60%" >

- Click into a specific account to edit it again.

<img src="../img/cloud-account-4.png" width="80%" >

## Configuration Integration

Once a cloud account is successfully created, it means that the account has been authorized to <<< custom_key.brand_name >>>. You can then install integrations as needed under this cloud account to start collecting data.

**Note**: Different integrations require different resource authorizations. Please grant the necessary permissions to the cloud account according to the integration documentation requirements. Otherwise, even if the integration installation succeeds, data collection may fail.

???+ abstract "Prerequisites"

    [DataFlux Func (Automata)](../dataflux-func/automata.md) must be enabled.

    If DataFlux Func (Automata) is not enabled, please enable it first.

    ![](img/cloud-inte-3.png)

Click into the cloud account details page > Integrations, where you can view all related integrations under the current account.

![](img/cloud-inte.png)

Click **Install** on the right side to enter the automatic installation page:

![](img/cloud-inte-1.png)

1. The cloud account is automatically filled in;
2. Select the applicable region type as needed;
3. <<< custom_key.brand_name >>> will automatically identify the metrics included in the current integration script, which you can modify as needed;
4. Filters currently support `=` and `in` operations.

Click Install. After successful installation, continue with script installation.

![](img/cloud-inte-2.png)

### Direct Installation from Integration Side

???+ abstract "Prerequisites"

    ![](img/cloud-inte-4.png)

    1. Enable DataFlux Func (Automata);
    2. [Cloud account authorization has been configured](#cloud-authorize) in management.

In addition to installing integrations via the **Management > Cloud Account Management** path, you can also go directly to **Integrations** to install.

On the single integration installation page, you can configure multiple cloud accounts.

![](img/cloud-inte-3.png)

Click Add Cloud Account, select other cloud accounts that need configuration, and configure regions, metrics, and filters.

![](img/cloud-inte-5.png)

Click Install, and the cloud account configuration will be updated to the latest settings.

## Deleting/Uninstalling Integrations

- On the cloud account management list page, click :octicons-gear-24:, to delete the cloud account. After deletion, no further data will be collected from any integrations configured under this cloud account, but previously collected data will remain unaffected.

![](img/cloud-inte-7.png)

- In the cloud account details page > Integrations, clicking Uninstall will stop further data collection from this integration, but previously collected data will remain unaffected.

![](img/cloud-inte-8.png)

- On the integration side, clicking Uninstall will stop further data collection from all AWS cloud accounts. If you only want to stop data collection from a specific cloud account, you can do so in the cloud account configuration.

![](img/cloud-inte-6.png)