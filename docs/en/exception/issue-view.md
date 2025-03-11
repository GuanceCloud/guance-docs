# Analysis Dashboard
---

In the scene > System View, you can search and clone an Incident analysis dashboard to create a new one.

The view contains the following Metrics information:

| <div style="width: 190px">Field </div> | Description |
| --- | --- |
| Total Issues | Counts the number of Issues within the specified time range. |
| Open Issues | Counts the number of Issues with the status "open" within the specified time range. |
| Pending Issues | Counts the number of Issues with the status "pending" within the specified time range. |
| Resolved Issues | Counts the number of Issues with the status "resolved" within the specified time range. |
| Average Resolution Time for Issues | Calculates the average resolution time for resolved Issues within the specified time range. |
| Maximum Resolution Time for Issues | Identifies the maximum resolution time for resolved Issues within the specified time range. |
| Issue Severity Distribution | Lists the number of Issues within the specified time range categorized by severity levels. |
| Issue Source Distribution | Lists the number of Issues within the specified time range categorized by sources. |
| Top 10 Responsible Parties by Number of Handled Issues | Statistics on the number of Issues handled by each responsible party. The statistics include all statuses. |
| Top 10 Responsible Parties by Resolution Time | Groups resolved (status: resolved) Issues by different responsible parties and calculates the resolution time for corresponding Issues, returning the top 10 results. |
| Unresolved Issues by Responsible Party | Groups unresolved (status: open OR pending) Issues by different responsible parties and counts them. |
| List of Unresolved Issues | Lists all unresolved (status: open OR pending) Issues within the current workspace. Fields listed: title, severity, status, responsible party. |

![](img/issue-analysis.png)

> For operations related to charts, refer to [Visual Charts](../scene/visual-chart/index.md).