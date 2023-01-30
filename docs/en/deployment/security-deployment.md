# Secure Deployment 
---

## Preface
For some customers who are very sensitive to finance, insurance and security, as well as customers who have self-control needs for the data provided by the Guance, we would provide solutions for deploying products to customers' own controllable environment. But in fact, if we can't upgrade and manage these Guance deployed to the customer side in time and quickly for a long time, this would cause customers to fail to upgrade in time and effectively or lead to a series of problems such as irreparable bugs in the product. Thus we need to be able to help customers upgrade and maintain the whole system under safe and controllable conditions in this deployment cooperation mode, so that these deployment customers can enjoy the service experience completely consistent with SaaS version under absolutely safe conditions. 

## Existing Problems
In fact, there are many doubts about our engineers deploying, installing, maintaining and upgrading Guance on customers' own servers. These concerns include the following: 

**Systematic Security Risks of Guance**

Customers worried about the possible security risks of the Guance itself, or the distrust of the engineers who operate the Guance after the deployment of Guance in the intranet of the enterprise, for example, making traditional attacks on the intranet, using the deployment cluster of the "Guance" as an attack springboard to attack the customer's intranet environment, or the operators using the authority in the deployment management process to attack the intranet. 

**Data Leakage Risk of Guance**

Customers worried about the data leakage of the Guance itself, including the data being stolen or destroyed by the operation upgrade personnel. 

Because of this series of concerns, customers refused our engineers to install, upgrade and maintain the software. Yet customers did not have the corresponding technical ability, and at the same time, they could not effectively deal with the system failure, which led to the extreme decline of the user experience. 

## Solutions
Guance itself is a comprehensive observable platform, **which is a data receiver, and does not need to access any monitored objects. All monitored objects are packaged by DataKit and then pushed to the center of Guance Cloud in a client way**. Therefore, if we build a safe deployment environment reasonably, we can eliminate the above-mentioned security risks, and let customers completely hand over the maintenance and management updates of products to us, so that customers can experience the SaaS-like use experience completely without paying attention to system deployment issues. 

#### Independent Cloud Account Method (recommended):
Open a special account for deploying Guance on an independent cloud platform to completely isolate from the customer's production or test environment, that is, physically (logically and physically) ensure that when our engineers maintain, manage and update Guance products, they cannot attack the customer's business network with the server related to Guance as a springboard machine. Due to the architectural characteristics of Guance, only the objects that need to be observed in the customer's intranet can transmit data to the DataWay of Guance through the DataKit, that is, the Datakit can be connected to the DataWay deployed in the center by one-way TCP. 

#### VPC Isolation Mode
Open an independent VPC on the same cloud platform account, deploy Guance under this independent VPC, and involve corresponding routing rules to ensure that Datakit of the core system can access DataWay deployed under the independent VPC in one direction. At the same time, an independent RAM account is opened, and all cloud resources under the independent VPC are authorized to the RAM account. 

#### Physical Network Isolation Mode
By means of iptable or security group of physical network, the cluster that controls the deployment of Guance cannot access other intranet servers, and only opens the port of DataWay in Guance to Datakit to realize one-way TCP connection. 

### Further Strengthen
The above three methods have been able to prevent hackers from invading Guance or bad engineers from attacking core business systems while maintaining Guance. However, if we need to protect the Guance platform and protect the data in the Guance platform, we still need to further strengthen the configuration. 

#### Open the Operation Audit Function of the Cloud Platform 
Turn on the audit function and record the audit log in an audit workspace of Guance, so as to know all the behaviors of logging in to the cloud console through RAM account, and ensure that any maintenance and management behaviors can be audited in the cloud console. 

#### Turn on the Bastion Machine 
All behaviors of Guance cluster management based on SSH login to related clusters are audited by bastion machines. 

#### Reasonably Control RAM Account Number and Home Base Machine Account Number
The internal engineer of the customer would control when we need to update the system management to open the corresponding RAM account and open the authority of the home base machine, and update the password or secret key regularly to avoid the intrusion caused by the leakage of the system password at ordinary times. 

## Conclusion
To sum up, if the deployment method is adopted reasonably, customers can safely hand over the deployment version of Guance to us for full maintenance without worrying about any danger, which would not happen. 

