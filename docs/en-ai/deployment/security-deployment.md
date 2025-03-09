# Security Deployment Solution
---

## Preface
For clients in finance, insurance, and other sectors with high sensitivity to security, as well as those who require self-management of data provided by "<<< custom_key.brand_name >>>", we will offer a solution to deploy the product in their own controlled environment. However, if we cannot promptly upgrade and manage these deployments on the client side, it could lead to issues such as untimely upgrades or unresolved bugs. Therefore, in this Deployment Plan cooperation model, we need to help clients securely maintain and upgrade the entire system, ensuring that these clients enjoy services identical to the SaaS version while maintaining absolute security.

## Existing Issues
In reality, our engineers deploying, installing, maintaining, and upgrading the "<<< custom_key.brand_name >>>" product on the client's own servers raises many concerns. These concerns include:

**Systemic Security Risks of "<<< custom_key.brand_name >>>"**

There are worries that after deploying "<<< custom_key.brand_name >>>" within the corporate intranet, potential security risks from "<<< custom_key.brand_name >>>" itself or distrust of the engineers operating it may arise. For example, traditional internal network attacks can be initiated using the "<<< custom_key.brand_name >>>" deployment cluster as a stepping stone to attack the client’s internal network, or operators could exploit permissions during deployment management to attack the internal network.

**Data Leakage Risks of "<<< custom_key.brand_name >>>"**

Concerns also exist regarding data leakage from "<<< custom_key.brand_name >>>", including theft or destruction of data by personnel performing upgrades.

Due to these concerns, clients may refuse our engineers from installing, upgrading, and maintaining the software, while lacking the necessary technical capabilities themselves. This results in an inability to effectively handle system failures, leading to a poor user experience.

## Solutions
"<<< custom_key.brand_name >>>" is a comprehensive observability platform. **It acts as a data receiver and does not need to access any monitored objects directly. All monitored objects send data via DataKit, which then pushes the data to the central "<<< custom_key.brand_name >>>" server.** Therefore, by properly constructing a secure deployment environment, the aforementioned security risks can be eliminated, allowing clients to fully entrust us with maintenance, management, and updates, providing them with a seamless SaaS-like experience without worrying about system deployment issues.

#### Independent Cloud Account Method (Recommended):
Open a dedicated account for deploying "<<< custom_key.brand_name >>>" on an independent cloud platform, ensuring complete isolation from the client's production or testing environments. This guarantees that when our engineers maintain and update the "<<< custom_key.brand_name >>>" product, they cannot use the related servers as stepping stones to attack the client’s business network. Due to the architecture of "<<< custom_key.brand_name >>>", only the observed objects within the client’s intranet need to transmit data to the "<<< custom_key.brand_name >>>" DataWay via DataKit, ensuring a one-way TCP connection from DataKit to the centrally deployed DataWay.

#### VPC Isolation Method
Enable an independent VPC on the same cloud platform account, deploy "<<< custom_key.brand_name >>>" under this isolated VPC, and configure routing rules to ensure that core system Datakits can access the DataWay deployed in the isolated VPC unidirectionally. Additionally, create an independent RAM account and authorize all cloud resources under the isolated VPC to this RAM account.

#### Physical Network Isolation Method
Use iptables or security groups to control the "<<< custom_key.brand_name >>>" cluster so that it cannot access other internal network servers, and only open the DataWay port of "<<< custom_key.brand_name >>>" to Datakit to achieve a one-way TCP connection.

### Further Enhancements
The above three methods can prevent hackers or malicious engineers from attacking core business systems after gaining access to "<<< custom_key.brand_name >>>". However, to protect the "<<< custom_key.brand_name >>>" platform and its data, additional enhancements are necessary.

#### Enable Operation Audit Functionality on the Cloud Platform
Activate auditing functionality and log audit logs into an audit workspace within "<<< custom_key.brand_name >>>". This allows tracking of all actions performed through the RAM account on the cloud console, ensuring all maintenance and management activities are auditable.

#### Enable Bastion Host
All SSH login-related cluster management activities for "<<< custom_key.brand_name >>>" should be audited through a bastion host.

#### Proper Management of RAM Accounts and Bastion Host Accounts
Client internal engineers should control the opening of RAM accounts and bastion host permissions only when we need to perform system updates and management, regularly updating passwords or keys to prevent unauthorized access due to password leaks.

## Conclusion
In summary, if the appropriate deployment methods are adopted, clients can confidently entrust the Deployment Plan of "<<< custom_key.brand_name >>>" to us for full maintenance, without any concerns, ensuring that potential risks do not occur.