# Security Deployment Solution
---

## Preface
For clients in finance, insurance, and other sectors that are highly sensitive to security, as well as those who require self-management of data provided by "Guance", we offer a solution to deploy the product into environments fully controlled by the client. However, if we cannot promptly upgrade and manage these deployed instances of "Guance" over the long term, it could lead to issues such as untimely upgrades or unresolved bugs. Therefore, in this Deployment Plan cooperation model, we need to assist clients in upgrading and maintaining the entire system under secure conditions, ensuring they enjoy the same service experience as the SaaS version while remaining absolutely secure.

## Existing Issues
In reality, there are many concerns regarding our engineers deploying, installing, maintaining, and upgrading the "Guance" product on servers owned by the client. These concerns include:

**Systemic Security Risks of the "Guance" Product**

There is concern that after deploying "Guance" within an enterprise intranet, potential security risks associated with "Guance" itself or mistrust of the engineers operating "Guance" could arise. For example, traditional attacks on the internal network using "Guance" deployment clusters as stepping stones to attack the client's internal network environment, or operators exploiting permissions during deployment management for internal network attacks.

**Data Leakage Risks of the "Guance" Product**

Concerns about data leakage from the "Guance" product, including theft or destruction of data by personnel performing upgrades.

Due to these concerns, clients may refuse our engineers to install, upgrade, or maintain the software, while lacking the necessary technical capabilities themselves. This leads to ineffective handling of system issues, severely degrading user experience.

## Solutions
"Guance" is a comprehensive observability platform that acts as a data receiver without needing to access any monitored objects directly. All monitoring objects send data via DataKit, which packages and pushes the data to the central "Guance". Therefore, by constructing a secure deployment environment, the aforementioned security risks can be eliminated, allowing clients to entrust us with the maintenance and updates of the product, thus providing a seamless SaaS-like user experience without worrying about system deployment.

#### Independent Cloud Account Method (Recommended):
Open a dedicated account on an independent cloud platform specifically for deploying "Guance", achieving complete isolation from the client's production or testing environments. This ensures that when our engineers maintain and update the "Guance" product, the related servers cannot be used as stepping stones to attack the client's business network. Due to the architecture of "Guance", only the observed objects within the client's intranet need to transmit data to the "Guance" DataWay via DataKit, ensuring a one-way TCP connection from DataKit to the centrally deployed DataWay.

#### VPC Isolation Method
Within the same cloud platform account, enable an independent VPC and deploy "Guance" under this VPC. Set up routing rules to ensure that core system Datakits can access the DataWay deployed in the independent VPC unidirectionally. Additionally, create an independent RAM account and authorize all cloud resources under the VPC to this RAM account.

#### Physical Network Isolation Method
Use iptables or security groups to control the "Guance" cluster so it cannot access other internal network servers, opening only the DataWay port in "Guance" for DataKit to establish a one-way TCP connection.

### Further Strengthening
The above three methods can prevent hackers or malicious engineers from attacking the core business system after gaining access to "Guance". To protect the "Guance" platform and its data, further enhancements are still required.

#### Enable Cloud Platform Operation Audit Function
Enable audit functions and log audit logs to an audit workspace in "Guance". This allows tracking all actions performed via the RAM account on the cloud console, ensuring all maintenance activities are auditable.

#### Enable Bastion Host
All SSH-based cluster management activities for the "Guance" cluster should be conducted through a bastion host for auditing purposes.

#### Proper Management of RAM Accounts and Bastion Host Accounts
Client internal engineers should control the release of RAM accounts and bastion host permissions only when we need to perform system updates. Regularly update passwords or keys to prevent unauthorized access due to password leaks.

## Conclusion
In summary, by adopting appropriate deployment methods, clients can confidently entrust the deployment of "Guance" to us for full maintenance, without any worries, ensuring absolute security.