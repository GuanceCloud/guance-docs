# Change Log



---



## December 29, 2022

### New inspection

* **Cloud Account Billing Inspection Intelligent Integration**：Cloud (now only suport alibaba cloud) Account Billing Inspection helps subscribers manage budget alerts, abnormal cost alerts, forecast costs for cloud services and provides subscribers with the ability to visualize and support multi-dimensional visualization of consumption of cloud service resources.

* **Alibaba Cloud Preemptible Instance Survival Intelligent Inspection**：Since the market price of the preemptible instances fluctuates with the change of supply and demand, it is necessary to specify the bid mode when creating the preemptible instance, and only when the real-time market price of the specified instance specification is lower than the bid price and the inventory is sufficient can the preemptible instance be successfully created. Therefore, it is particularly important to inspect the preemptible instance of cloud assets. When the preemptible instance is found to be about to be released through inspection, the latest price of all available zones of the current specification of the preemptible instance and the historical price of the changed preemptible instance will be indicated and appropriate treatment advice will be given.



## December 1, 2022

### New inspection

* **Kubernetes Pod Abnormal Restart Intelligent Inspection**：Kubernetes helps users automatically schedule and expand containerized applications, but modern Kubernetes environments are becoming more and more complex. When platform and application engineers need to investigate events in dynamic and containerized environments, finding the most meaningful signals may involve many trial and error steps. Intelligent Inspection can filter exceptions according to the current search context, thus speeding up incident investigation, reducing the pressure on engineers, reducing the average repair time and improving the end-user experience.
* **MySQL Performance Inspection**：For increasingly complex application architectures, the current trend is for more and more customers to adopt maintenance-free cloud databases, so patrolling MySQL performance patrols are a top priority, and intelligent patrols are performed on MySQL on a regular basis to alert abnormalities by finding MySQL performance problems.
* **Server Application Error Intelligent Inspection**：When server-side operation errors occur, we need to find early and timely warning to allow development and operation maintenance to troubleshoot and confirm whether the error has a potential impact on the application in a timely manner. The content of the server-side application error patrol event report is to remind the development and operation of the maintenance in the past hour there is a new application error and locate the specific place of error will be associated with the diagnostic clues provided to the user.
* **Memory leak Intelligent Inspection**：「Memory leak Intelligent Inspection」is based on memory abnormality analysis detector, which performs intelligent inspection of hosts on a regular basis, conducts root cause analysis by the hosts with memory abnormalities, determines the process and pod information corresponding to the abnormal time point, and analyzes whether the current workspace hosts have memory leakage problems.
* **Disk utilization Intelligent Inspection**：「Disk utilization Intelligent Inspection」 is based on the disk exception analysis detector. It regularly performs intelligent patrols on the host disk. It analyzes the root cause of the host with disk exceptions, determines the disk mount point and disk information corresponding to the time point of the exception, and analyzes whether the current workspace host has disk usage problems.
* **APM Intelligent Inspection**：「APM Intelligent Inspection」is based on APM root cause analysis detector, select the `service` 、 `resource` 、 `project` 、 `env` information to be tested, and perform intelligent inspection of APM on a regular basis to automatically analyze the upstream and downstream information of the service through application service index exceptions, and confirm the root cause of the abnormal problem for the application.

### Functional optimization

* **RUM Log Error Intelligent Inspection**：Web error log inspection event report newly shows front-end user impact.



## November 3, 2022

### New inspection

* **Cloud Account Billing Intelligent Inspection**：Cloud ( Alibaba Cloud, Tecent Cloud, Huawei Cloud ) Account Billing Inspection helps subscribers manage budget alerts, abnormal cost alerts, forecast costs for cloud services and provides subscribers with the ability to visualize and support multi-dimensional visualization of consumption of cloud service resources.
* **RUM Log Error Intelligent Inspection**：RUM error log inspection will help discover new error messages (Error Message after clustering) of the front-end application in the past hour, helping development and operation and maintenance to fix the code in time to avoid continuous harm to customer experience with the accumulation of time.
* **Alibaba Cloud Asset Intelligent Inspection**：It provides additional data access capability for Guance, which is convenient for users to have a better understanding of the product performance status of cloud suppliers.

### Issue Fix

* **Disk utilization Intelligent Inspection**：The repair event line chart shows abnormal problems.
