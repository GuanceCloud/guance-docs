# How to Collect Resource Catalog Data
---

## Introduction

In addition to hosts, containers, and processes, “<<< custom_key.brand_name >>>” supports you in defining new object categories and reporting related object data to the “<<< custom_key.brand_name >>>” console. Through the "Infrastructure" - "Custom" section, you can view all "Resource Catalog" data reported to your workspace.



## Prerequisites

- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Install DataFlux Func ([DataFlux Func Installation Documentation](https://func.guance.com/doc/quick-start/))
- Connect DataFlux Func and DataKit ([Connect and Operate DataKit](https://func.guance.com/doc/practice-connect-to-datakit/))



## Method/Steps



### Step 1: Add a Resource Catalog Category

In the <<< custom_key.brand_name >>> workspace, through "Infrastructure" - "Custom" - "Add Object Category," you can create new object categories and define the category name and object fields for the resource catalog.

- **Object Category**: The category name of the resource catalog, which is the "object category name" used when reporting resource catalog data. When reporting data, ensure that the **"object category name" matches the naming used during data reporting.**
- **Alias**: Add an alias for the current object category, which will be displayed as the name in the resource catalog list.
- **Default Attributes**: Add custom fields and field aliases required for adding objects. By default, the `name` field is added. During data reporting, custom fields are mandatory fields for the object category. 

**Note:**

1. All custom fields in "Default Attributes" are mandatory fields during data reporting. If the reported data lacks any mandatory fields, it will not be reported to the <<< custom_key.brand_name >>> workspace.
2. If the reported data includes mandatory fields along with other fields, non-mandatory fields will appear as data tags.
3. If the data type of the reported data does not match the defined field data type, the data will not be reported to the <<< custom_key.brand_name >>> workspace. For example, if the field type is defined as string in DataFlux Func but the data type reported is integer, the data will not be reported to the <<< custom_key.brand_name >>> workspace.

![](img/1.custom_1.png)

For more details, refer to the help documentation [Resource Catalog Categories](../infrastructure/custom/index.md).



### Step 2: Customize Data Reporting for Objects

After adding the resource catalog category, you can proceed with custom data reporting. To report resource catalog data, you need to install and connect DataKit and DataFlux Func first, then report data from DataFlux Func to DataKit, and finally have DataKit report the data to the <<< custom_key.brand_name >>> workspace.

![](img/custom_1.png)

For detailed steps, refer to the documentation [Reporting Resource Catalog Data](../infrastructure/custom/data-reporting.md).