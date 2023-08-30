---
icon: zy/release-notes
---

# Release Note—2023
---

This document records the updated content description of each online release of our product, including Guance, DataKit, Guance Best Practices and Guance Integration Documentation.

## August 24, 2023

### Guance Update

- [Billing Items](../billing/billing-method/index.md)：
    - Backup Logs: Add billing items for four archive types: OSS, OBS, AWS S3, and Kafka. Based on the corresponding archive type selected by the user, the amount of forwarded traffic is calculated and summarized, and the account is issued according to the data.
    - APM Trace、RUM PV Add 30 days/ 60 days data storage strategy.
- Monitoring: 
    - [Mute Rules](../monitoring/silent-management.md): Support configuring alarm mute based on different dimensions.
    - [Monitor](../monitoring/monitor/index.md#list): Support adding tags to monitors. Add a quick filter column to the monitor list, and make some optimizations to the list.  
    - SLO: Add **Error Burndown** list.
- Logs > Backup Logs：Add [Kafka Message Queue](../logs/backup.md#kafka)external storage.
- Explorers/Dashboards: Add [Refresh](../getting-started/function-details/explorer-search.md#refresh).
- Explorers Details Page: Add Bind View entry.

## August 17, 2023

### Guance Update



- Management: Add [Sensitive Data Scanner](../management/data-scanner.md) function: Realize information shielding by creating desensitization rules for data.
- Add new billing item: [Sensitive Data Scanning Traffic](../billing/billing-method/index.md#scanned-data): Based on the scanning rules, the raw traffic size of the scanned sensitive data is counted (per GB/day).
- Billing: The consumption analysis section is temporarily removed from the shelves due to renovation and optimization.


## August 10, 2023

### Guance Update

- New billing items:  
    - Report: Billing is made according to the number of times a scheduled report is sent in a single day in the workspace;  
    - Ingested log: billed according to the original log write traffic reported by the user.  
- Scenes: New feature **[Service Management](../scene/service-management.md)**: Service Management is a centralized portal for accessing key information of all services. Users can view the performance and business data of different services in the current workspace, as well as all correlation analysis and other information, and quickly locate and solve service-related problems.   
- All the charts support PromQL queries and expression queries.
- Logs: You can directly view context logs on the log details page; you can select the scope of context retrieval.  
- Explorer: Open a data detail page, and support one-click export of the current data as a JSON file.
- APM > Service > Call Map: Add the upstream and downstream call relationship table of the current service, showing the number of requests, average response time, and errors of the one-way service relationship.
- Monitor > Threshold Detection: Add conversion of detection metrics to PromQL queries.
- Infrastructure > Containers: Add Kubernetes Events component on the details page of Pods, Services, Deployments, Nodes, Replica Sets, Cron Jobs and Daemonset.

## January 17, 2023 

### The English version of Guance has launched.
