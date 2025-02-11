# Cloud Account Management

During business operations, enterprises often need to use multiple cloud service accounts to meet different business needs. However, when these cloud services experience issues, decentralized management can lead to inefficiencies and increased operational costs.

Guance's cloud account management feature centralizes all of the enterprise's cloud service accounts for unified management, distinguishing them by the uniqueness of certain configurations under each account. By configuring integrated collectors, each account's cloud services are managed independently, thus achieving fine-grained control over business data.

This management approach not only simplifies the cloud service management process but also helps quickly locate and resolve service issues, significantly reducing management costs and improving fault response speed.

**Note**: This feature is currently only available to **workspace owners and administrators** for configuration.

## Adding Cloud Account Authorization {#cloud-authorize}

<font size=2>**Note**: Currently, only AWS cloud accounts are supported. Other cloud accounts will be available soon.</font>

AWS account types have two authentication methods: Access Keys and Role Authorization.

<img src="../img/cloud-account.png" width="60%" >

### Based on Access Keys {#ak}

<img src="../img/cloud-account-1.png" width="60%" >

1. Select Region: Choose China or overseas regions as needed;
2. Account ID: Must be 12 characters;
3. Enter the AWS Access Key and Secret Key;
4. Enter an account alias; this will be used for display in Guance, and subsequent data collected from this account will automatically include this label;
5. Click the **Test** button. Only after a successful test can the creation proceed.

### Based on Role Authorization {#ra}

<img src="../img/cloud-account-2.png" width="60%" >

1. Select Region: Choose China or overseas regions as needed;
2. Account ID: Must be 12 characters;
3. Enter the AWS Access Key and Secret Key;
4. Enter the role name under this account;
5. Enter an account alias; this will be used for display in Guance, and subsequent data collected from this account will automatically include this label;
6. Click Save. You can also click the **Test** button to validate the current cloud account information.

## Account List

Successfully created cloud accounts will be displayed here. You can perform the following actions:

- Use the quick filter in the top-right corner based on **type**;
- Directly enter the cloud account alias in the search bar to locate it;
- Delete the account directly via the settings button;

<img src="../img/cloud-account-3.png" width="60%" >

- Click into an account to edit it again.

<img src="../img/cloud-account-4.png" width="80%" >

## Configuration Integration

Once a cloud account is successfully created, it means that the account has been authorized to Guance. You can then install integrations as needed under this cloud account to start collecting data.

**Note**: Different integrations require different resource authorizations. Please grant the appropriate permissions to the cloud account according to the integration documentation. Otherwise, even if the integration installation is successful, data collection may fail.

???+ abstract "Prerequisites"

    [DataFlux Func (Automata)](../dataflux-func/automata.md) must be enabled.

    If DataFlux Func (Automata) is not enabled, please enable it first.

    ![](img/cloud-inte-3.png)

Click into the cloud account details page > Integrations to view all related integrations under the current account.

![](img/cloud-inte.png)

Click **Install** on the right to enter the automatic installation page:

![](img/cloud-inte-1.png)

1. The cloud account is automatically filled in;
2. Select the applicable region type as needed;
3. Guance will automatically identify the metrics included in the current integration script, which you can adjust as needed;
4. Filters currently support `=` and `in` operations.

Click Install. After a successful installation, continue with script installation.

![](img/cloud-inte-2.png)

### Direct Installation from Integration Side

???+ abstract "Prerequisites"

    ![](img/cloud-inte-4.png)

    1. Enable DataFlux Func (Automata);
    2. [Cloud account authorization has been configured](#cloud-authorize).

In addition to installing integrations via the **Management > Cloud Account Management** path, you can also go directly to **Integrations** for installation.

On a single integration installation page, you can configure multiple cloud accounts.

![](img/cloud-inte-3.png)

Click Add Cloud Account to select other cloud accounts that need configuration and set up regions, metrics, and filters.

![](img/cloud-inte-5.png)

Click Install to update the cloud account configuration to the latest settings.

## Deleting/Uninstalling Integrations

- On the cloud account management list page, click :octicons-gear-24:, and you can delete the cloud account. After deletion, no further data collection will occur for all configured integrations under this cloud account, but previously collected data will remain unaffected.

![](img/cloud-inte-7.png)

- In the cloud account details page > Integrations, clicking Uninstall will stop further data collection for this integration, but previously collected data will remain unaffected.

![](img/cloud-inte-8.png)

- On the integration side, clicking Uninstall will stop further data collection for all AWS cloud accounts. If you want to stop data collection for only one cloud account, you can do so in the cloud account configuration.

![](img/cloud-inte-6.png)