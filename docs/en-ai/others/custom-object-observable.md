# How to Collect Resource Catalog Data
---

## Introduction

In addition to hosts, containers, and processes, "Guance" supports you in defining new object categories and reporting related object data to the Guance console. Through the "Custom" section under "Infrastructure," you can view all "Resource Catalog" data reported to your workspace.



## Prerequisites

- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Install DataFlux Func ([DataFlux Func Installation Documentation](https://func.guance.com/doc/quick-start/))
- Connect DataFlux Func and DataKit ([Connecting and Operating DataKit](https://func.guance.com/doc/practice-connect-to-datakit/))



## Method/Steps



### Step1: Add a Resource Catalog Category

In the Guance workspace, through "Infrastructure" - "Custom" - "Add Object Category," you can create new object categories and define the category name and object fields for the resource catalog.

- **Object Category**: The category name for the resource catalog, i.e., the "object category name" used when reporting resource catalog data. When reporting data, ensure that the **"object category name" matches the name used during reporting**.
- **Alias**: Define an alias for the current object category, which is the name displayed in the resource catalog list.
- **Default Attributes**: Add custom fields and field aliases required for objects. By default, the `name` field is added. During data reporting, these custom fields are mandatory for the object category.

**Note:**

1. All custom fields in "Default Attributes" are mandatory when reporting data. If the reported data lacks any mandatory fields, it will not be reported to the Guance workspace.
2. If the reported data includes mandatory fields along with other fields, non-mandatory fields will appear as data tags.
3. If the data type of the reported data does not match the defined field data type, the data will not be reported to the Guance workspace. For example, if the field type is defined as string in DataFlux Func but the reported data type is integer, the data will not be reported to the Guance workspace.

![](img/1.custom_1.png)

For more details, refer to the [Resource Catalog Categories Help Documentation](../infrastructure/custom/index.md).



### Step2: Custom Reporting of Object Data

After adding the resource catalog category, you can proceed with custom data reporting. To report resource catalog data, you need to install and connect DataKit and DataFlux Func first, then report data from DataFlux Func to DataKit, and finally report data to the Guance workspace via DataKit.

![](img/custom_1.png)

For detailed steps, refer to the documentation on [Reporting Resource Catalog Data](../infrastructure/custom/data-reporting.md).