# Changelog

---

## July 11, 2023

### Function Optimization

* **APM Incident**: Added a default threshold modification entry. Now when starting an incident, the trigger values for services can be modified simultaneously.

## July 4, 2023

### Function Optimization

* **RUM Incident**: Optimized the root cause display logic in the page details module, making root cause identification more accurate.
- **Workspace Asset Inspection**: Added default configuration (7 days). Now inspection can run without parameters.

## June 20, 2023

### New Inspection

* **AWS Cloudtrail Anomaly Event Inspection**: AWS CloudTrail is a service that tracks, logs, and monitors activities within AWS accounts. It records operations performed in AWS accounts, including management console access, API calls, resource changes, etc. By monitoring CloudTrail error events, potential security issues can be identified promptly. For example, unauthorized API calls, denied resource access, and abnormal authentication attempts. This helps protect your AWS account and resources from unauthorized access and malicious activities; it also helps understand the types, frequency, and impact scope of system failures. This aids in quickly identifying problems and taking appropriate corrective actions to reduce downtime and business impact.

## June 6, 2023

### New Inspection

* **Workspace Asset Inspection**: Ensures services operate normally, detects faults or anomalies early to minimize business losses. Additionally, inspections help improve service availability and stability by identifying and resolving potential issues. Inspections enhance operational efficiency, accelerate problem diagnosis and resolution, and optimize resource allocation. By regularly inspecting hosts, K8s, containers, etc., operations personnel ensure these services support business efficiently and stably, providing a continuously reliable operating environment for enterprises.

## May 18, 2023

### New Inspection

* **Cloud Idle Resource Inspection**: As cloud computing rapidly develops, it provides convenient, fast, and elastic IT infrastructure and application services, bringing high efficiency and economic benefits. However, as cloud resources become a major part of enterprise data centers, significant waste of cloud resources has emerged. Especially within enterprises, demand fluctuations and departmental isolation lead to underutilization of some cloud resources, resulting in substantial idle resources. This increases cloud service costs, reduces resource efficiency, and may lower security and performance levels. To better manage and optimize idle cloud resources and improve cloud usage benefits and resource utilization, conducting cloud idle resource inspections is necessary. Through inspections, unnecessary resources in current cloud services can be identified and handled promptly, avoiding long-term unnecessary resource usage and associated costs, data leaks, and performance issues.
* **Host Reboot Inspection**: Host reboot monitoring is crucial in modern internet system operations. On one hand, system stability and reliability are vital for smooth business operations and user experience. When hosts experience abnormal reboots, risks such as system crashes, service interruptions, and data loss arise, impacting business operations and user satisfaction. On the other hand, with increasing host numbers and complexity in cloud and virtualized environments, the probability of issues rises. System administrators need real-time monitoring tools to detect and resolve abnormal reboots promptly. Properly implementing host reboot monitoring helps businesses diagnose problems quickly, reduce business risks, and enhance operational efficiency and user experience.

### Function Optimization

* **Idle Host Inspection**: Added cost-related information for cloud host types.

## April 13, 2023

### Function Optimization

* **Disk Usage Rate Inspection**: Optimized the trend judgment algorithm for disk usage rate inspections, providing users with more precise problem localization.
* **Smart Inspection**: Simplified the overall enabling logic for smart inspections, making it easier to start.

## March 30, 2023

### Function Optimization

* **Memory Leak Inspection**: Optimized the trend judgment algorithm for memory leak inspections, providing users with more precise problem localization.
* **Cloud Account Bill Inspection**: Merged into cloud account instance-level bill inspection.

## March 23, 2023

### New Inspection

* **Idle Host Inspection**: As business grows, resource usage increases, leading to larger data centers. The issue of idle hosts becomes more significant. Especially within enterprises, due to demand fluctuations and departmental isolation, some hosts remain underutilized, forming large amounts of idle resources. This increases cloud service costs, reduces resource efficiency, and may lower security and performance levels.

### Function Optimization

* **APM Incident**: Changed P75 latency positioning to P99 for more precise problem localization.

## March 2, 2023

### Function Optimization

* **APM Incident**: Improved sensitivity in detecting APM errors, making them more immediate.

## February 16, 2023

### Function Optimization

* **RUM Incident**: Added support for session ID redirection to view problematic sessions and provided professional optimization methods in inspection event reports.
* **Cloud Account Instance-Level Bill Inspection**: Added support for AWS account instance-level bill inspections.

## February 9, 2023

### New Inspection

* **RUM Incident**: RUM is a technology used to monitor application performance by simulating real user behavior on websites. Its purpose is to understand website performance from the user's perspective, including load times, page rendering, element loading, and interaction response. RUM performance inspections are mainly used for client-side websites like e-commerce, finance, and entertainment sites, which require a fast and smooth user experience. Analyzing RUM performance results helps developers quickly understand actual user experiences and improve website performance.
* **Kubernetes Health Inspection**: Kubernetes dominates the container ecosystem, managing distributed deployments across hosts for service-oriented applications. To ensure Kubernetes node health, intelligent inspections analyze current node resource states, application performance management, and service fault logs. This accelerates event investigation, reduces engineer workload, decreases mean time to repair, and improves end-user experience.

## December 29, 2022

### New Inspection

* **Cloud Account Instance-Level Bill Inspection**: Helps users manage anomaly alerts, predict expenses, and visualize consumption at the instance level, supporting multi-dimensional visualization of cloud service resource consumption.
* **Alibaba Cloud Spot Instance Survival Inspection**: Due to fluctuating market prices for spot instances, users must specify bid prices during creation. When the real-time price is below the bid and inventory is sufficient, spot instances can be created successfully. Spot instance inspections alert users when instances are about to be released, showing the latest prices in all available zones and historical prices, along with appropriate handling suggestions.

## December 1, 2022

### New Inspection

* **Kubernetes Pod Abnormal Restart Inspection**: Kubernetes automates scheduling and scaling of containerized applications, but modern Kubernetes environments have become increasingly complex. Engineers need to investigate dynamic, containerized environments, where meaningful signals can be difficult to find. Intelligent inspections filter anomalies based on current context, accelerating event investigation, reducing engineer workload, decreasing mean time to repair, and improving end-user experience.
* **MySQL Performance Inspection**: With increasingly complex application architectures, more customers adopt managed cloud databases. Regular MySQL performance inspections are critical, automatically analyzing and alerting on performance issues.
* **Server-Side Application Error Inspection**: Early detection and alerts for server-side errors help developers identify and fix issues promptly, ensuring they do not affect applications. Error reports highlight new errors in the past hour and provide diagnostic clues.
* **Memory Leak Inspection**: Based on memory anomaly detectors, regular inspections identify hosts with memory issues, perform root cause analysis, and determine processes and pod information at the anomaly time, checking for memory leaks.
* **Disk Usage Rate Inspection**: Based on disk anomaly detectors, regular inspections identify hosts with disk issues, perform root cause analysis, and determine mount points and disk information at the anomaly time, checking for disk usage issues.
* **APM Incident**: Based on APM anomaly root cause analysis detectors, select `service`, `resource`, `project`, `env` information, and regularly inspect application performance. Automatically analyze upstream and downstream information for abnormal service metrics to confirm root causes.

### Function Optimization

* **Frontend Application Log Error Inspection**: Added frontend user impact display in error log inspection event reports.

## November 3, 2022

### New Inspection

* **Cloud Account Bill Inspection**: Helps users manage budget alerts, anomaly alerts, predict expenses, and visualize consumption, supporting multi-dimensional visualization of cloud service resource consumption.
* **Frontend Application Log Error Inspection**: Identifies new error messages in frontend applications over the past hour, helping developers and operations teams fix code issues promptly to avoid continuous harm to customer experience.
* **Alibaba Cloud Asset Inspection**: Provides additional data integration capabilities for Guance, offering users more insight into cloud vendor product performance.

### Issue Fixes

* **Disk Usage Rate Inspection**: Fixed line chart display issues.