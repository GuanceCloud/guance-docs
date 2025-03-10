# Object List Diagram
---

## Introduction

Support adding a list of objects to the view and filtering the data to see the data under the corresponding object category.

## Use Case

The object list graph of the Guance is used to view the data under the corresponding object category. For example, you can view the names of different hosts in the workspace, CPU usage, disk occupancy, and other attributes.

## Chart Search

- Query: Support query with data source fixed as "object" and support keyword search.
- Filtering: Support filtering. Filter the object data of the query by entering filtering conditions.
- Show columns: Select the columns to be displayed. The contents of 「name」 and 「class」exist by default and can be renamed.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | 为Set the title name of the chart, after setting, it will be shown on the top left of the chart, support hide |

## Chart Setup
### Basic Settings
| Options | Description |
| --- | --- |
| Unit | Select the units for displaying columns. Custom units are supported. When the content is of numeric type, the user 「selects」 the data unit; when the content is of non-numeric type, the user 「enters」 the data unit. |

### Advanced Settings
| Options | Description |
| --- | --- |
| Lock time | Support locking the time range of the chart query data, not limited by the global time component. The time set by the user will appear in the upper right corner of the chart after successful setup, e.g. 【xx minutes】, 【xx hours】, 【xx days】. If the time interval is locked at 30 minutes, then when adjusting the time component, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Chart Description | Add description information for the chart, after setting the chart title will appear behind the 【i】 prompt, not set, it will not be displayed |

## Example diagram

The following chart shows the names, CPU usage, disk occupancy, and other attributes of the different hosts in the workspace.

![](../img/object.png)

