# Changelog

---

## July 11, 2023

### Feature Optimization

* **APM Inspection**: Added a default detection threshold change entry. Now when starting an inspection, the trigger values for services to be detected can be modified simultaneously.

## July 4, 2023

### Feature Optimization

* **RUM Performance Inspection**: Optimized the root cause display logic in the page details module, making root cause identification more accurate.
- **Workspace Asset Inspection**: Added a default configuration (7 days). Now inspections can run without parameters.

## June 20, 2023

### New Inspections

* **AWS CloudTrail Anomaly Event Inspection**: AWS CloudTrail is a service that tracks, logs, and monitors activities in AWS accounts. It records operations performed within AWS accounts, including management console access, API calls, resource changes, etc. By monitoring CloudTrail error events, potential security issues can be identified promptly. For example, unauthorized API calls, denied resource access, abnormal authentication attempts, etc. This helps protect your AWS account and resources from unauthorized access and malicious activities; it also helps understand the types, frequency, and impact scope of system failures. This aids in quickly identifying issues and taking appropriate corrective measures to reduce downtime and business impact.

## June 6, 2023

### New Inspections

* **Workspace Asset Inspection**: Ensures services operate normally, detects faults or anomalies promptly to minimize business losses. Additionally, inspections help improve service availability and stability by identifying and resolving potential issues. They enhance operational efficiency, accelerate problem diagnosis and resolution, and optimize resource allocation to ensure business safety. Regular inspections of hosts, K8s, containers, etc., allow IT personnel to ensure these services support business efficiently and stably, providing a continuously reliable operating environment for enterprises.

## May 18, 2023

### New Inspections

* **Cloud Idle Resource Inspection**: As cloud computing rapidly develops as a new IT service model, it provides convenient, fast, and elastic IT infrastructure and application services for enterprises and individuals, bringing high efficiency and economy. However, with cloud resources becoming a major part of enterprise data centers, significant waste of cloud resources has become increasingly prominent. Especially within enterprises, due to demand fluctuations and departmental isolation, some cloud resources are not fully utilized, forming a large number of idle resources. This situation can lead to rising cloud service costs, decreased resource efficiency, and reduced security and performance levels. To better manage and optimize idle cloud resources and improve the utilization and efficiency of cloud computing, conducting idle resource inspections is essential. Through inspections, unnecessary resources in current cloud services can be discovered and handled promptly, avoiding unnecessary expenses, data leaks, poor performance, etc.

* **Host Reboot Inspection**: Host abnormal reboot monitoring is an important aspect of modern internet system operations. On one hand, the stability and reliability of computer systems are crucial for smooth business operations and user experience. When hosts experience abnormal reboots, risks such as system crashes, service interruptions, and data loss arise, affecting business operations and user satisfaction. On the other hand, with the increasing number and scale of hosts in cloud computing and virtualization environments, system complexity and the probability of issues increase. System administrators need to use relevant monitoring tools for real-time monitoring and timely discovery and resolution of abnormal reboots. Thus, properly implementing host abnormal reboot monitoring helps businesses diagnose problems quickly, reduce business risks, enhance operational efficiency, and improve user experience.

### Feature Optimization

* **Idle Host Inspection**: Added cost-related information for cloud host types.

## April 13, 2023

### Feature Optimization

* **Disk Usage Rate Inspection**: Optimized the trend judgment algorithm for disk usage rate inspections, providing users with more precise issue localization.
* **Smart Inspection**: Simplified the overall logic for enabling smart inspections, making it easier to start.

## March 30, 2023

### Feature Optimization

* **Memory Leak Inspection**: Optimized the trend judgment algorithm for memory leak inspections, providing users with more precise issue localization.
* **Cloud Account Billing Inspection**: Merged into instance-level billing inspections for cloud accounts.

## March 23, 2023

### New Inspections

* **Idle Host Inspection**: With business growth, resource usage increases, leading to larger data centers. The significant waste of idle hosts becomes more apparent. Within enterprises, due to demand fluctuations and departmental isolation, some hosts are underutilized, forming idle resources. This can lead to increased cloud service costs, decreased resource efficiency, and lower security and performance levels.

### Feature Optimization

* **APM Inspection**: Changed the P75 positioning of application access latency to P99 for more precise issue localization.

## March 2, 2023

### Feature Optimization

* **APM Inspection**: Enhanced sensitivity for detecting application performance errors, making them more immediately discoverable.

## February 16, 2023

### Feature Optimization

* **RUM Performance Inspection**: Added support for jumping to session IDs affected by users in inspection event reports, providing more professional optimization methods.

* **Instance-Level Billing Inspection for Cloud Accounts**: Added support for AWS account instance-level billing inspections.

## February 9, 2023

### New Inspections

* **RUM Performance Inspection**: Real User Monitoring (RUM) is a technology for evaluating website performance by simulating real user behavior while browsing websites. RUM aims to understand website performance from the user's perspective, including load times, page rendering effects, element loading conditions, and interaction responses. RUM performance inspections are primarily used for client-side websites like e-commerce, finance, and entertainment sites, which require presenting a fast and smooth user experience. Analyzing RUM performance results helps developers understand actual user experiences and quickly improve website performance.
* **Kubernetes Health Inspection**: Kubernetes has swept through the container ecosystem, acting as the brain for distributed container deployments. It manages service-oriented applications using containers distributed across host clusters. To ensure Kubernetes node health, intelligent inspections analyze current node resource status, APM, service fault logs, etc., accelerating incident investigation, reducing engineer stress, decreasing mean time to repair (MTTR), and improving end-user experience.

## December 29, 2022

### New Inspections

* **Instance-Level Billing Inspection for Cloud Accounts**: Helps users manage anomaly alerts for cloud service instances, predict costs, and provide high-growth, high-consumption instance alerts and bill visualization capabilities. Supports multi-dimensional visualizations of cloud service resource consumption.
* **Alibaba Cloud Spot Instance Survival Inspection**: Given the fluctuating market prices of spot instances, specifying a bidding mode is required during creation. When the real-time price of specified instance specifications is below the bid and inventory is sufficient, spot instances can be created successfully. Therefore, inspecting spot instances is crucial. When a spot instance is about to be released, it will prompt the latest prices for all available zones of the current specification and historical prices, along with appropriate handling suggestions.

## December 1, 2022

### New Inspections

* **Kubernetes Pod Abnormal Restart Inspection**: Kubernetes helps users automatically schedule and scale containerized applications, but modern Kubernetes environments are becoming increasingly complex. When platform and application engineers need to investigate events in dynamic, containerized environments, finding meaningful signals may involve many trial-and-error steps. Intelligent inspections filter anomalies based on current search context, accelerating incident investigation, reducing engineer stress, decreasing MTTR, and improving end-user experience.
* **MySQL Performance Inspection**: As application architectures become more complex, more customers adopt managed cloud databases. Therefore, MySQL performance inspections are critical. Regular intelligent inspections detect MySQL performance issues for anomaly alerts.
* **Server-Side Application Error Inspection**: When server-side errors occur, early detection and timely alerts are necessary to alert development and operations teams for troubleshooting. The content of reported incidents includes reminders about new errors in the past hour and specific error locations with associated diagnostic clues.
* **Memory Leak Inspection**: Based on memory anomaly analysis detectors, regular intelligent inspections identify hosts with memory anomalies, perform root cause analysis to determine process and pod information at corresponding anomaly timestamps, and analyze whether current workspace hosts have memory leak issues.
* **Disk Usage Rate Inspection**: Based on disk anomaly analysis detectors, regular intelligent inspections identify hosts with disk anomalies, perform root cause analysis to determine mount points and disk information at corresponding anomaly timestamps, and analyze whether current workspace hosts have disk usage issues.
* **APM Inspection**: Based on APM anomaly root cause analysis detectors, select `service`, `resource`, `project`, `env` information for regular intelligent inspections. Automatically analyze upstream and downstream information of application service metrics to confirm root cause anomalies.

### Feature Optimization

* **Frontend Application Log Error Inspection**: Added frontend user impact display in inspection event reports.

## November 3, 2022

### New Inspections

* **Cloud Account Billing Inspection**: Helps users manage budget alerts, anomaly alerts, and cost predictions for cloud services, providing visualization capabilities. Supports multi-dimensional visualizations of cloud service resource consumption.
* **Frontend Application Log Error Inspection**: Helps identify new error messages in frontend applications over the past hour (clustered Error Messages), assisting developers and operations teams in timely code fixes to avoid long-term damage to customer experience.
* **Alibaba Cloud Asset Inspection**: Provides additional data integration capabilities for <<< custom_key.brand_name >>>, allowing users to gain more insights into the performance status of cloud vendor products.

### Bug Fixes

* **Disk Usage Rate Inspection**: Fixed an issue with the event line chart display.