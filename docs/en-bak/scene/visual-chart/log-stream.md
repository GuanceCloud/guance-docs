# Log Flow Diagram 
---

## Introduction

Log flow diagram supports users to search, filter, and display log data recorded in the system for hardware, software, system information, and occurring events.

## Use Case

Guance's log flow graph is used to search, filter, and display log data. For example, you can query the last 15 minutes of nginx log content.

## Chart Search

- Query: Support query with data source fixed as 「log」 and support keyword search.
- Filtering: Support filtering. Filter the query log data by entering filtering conditions.
- Display Columns: Select the display columns to be displayed. The content of 「message」 exists by default, you can rename 「content」.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title name for the chart, after setting, it will be displayed on the top left of the chart, and it supports hiding |

## Chart Setup
### Basic Settings
| Options | Description |
| --- | --- |
| Unit | Select the units for displaying columns. Custom units are supported. When the content is of numeric type, the user 「selects」 the data unit; when the content is of non-numeric type, the user 「enters」 the data unit. |

### 高级设置
| Options | Description |
| --- | --- |
| Lock time | Support locking the time range of the chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Chart Description | Add description information for the chart, after setting the chart title will appear behind the 【i】 prompt, not set, it will not be displayed|

### Formatting configuration

| Options | Description |
| --- | --- |
| Formatting configuration | The formatting configuration allows you to hide sensitive log data content or highlight log data content that needs to be viewed.<br />- Fields: Added display columns<br />- Matching mode: support `=`, `! =`, `match`, `not match`<br />- Matching content: the data content of the query result<br />- Show as content: Replace with the content you want to show<br /> |

## Example diagram

The following is an example of the nginx log content for the most recent day。

![](../img/log.png)

