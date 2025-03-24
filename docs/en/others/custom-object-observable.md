# How to Collect Resource Catalogs
---

## Introduction

In addition to hosts, containers, and processes, “<<< custom_key.brand_name >>>” allows you to define new object classifications and report related object data to the “<<< custom_key.brand_name >>>” console. Through the 「Infrastructure」 section's 「Custom」 option, you can view all the "Resource Catalog" data reported to your workspace.



## Prerequisites

- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Install DataFlux Func ([DataFlux Func Installation Documentation](https://<<< custom_key.func_domain >>>/doc/quick-start/))
- Connect DataFlux Func and DataKit ([Connect and Operate DataKit](https://<<< custom_key.func_domain >>>/doc/practice-connect-to-datakit/))



## Methods/Steps



### Step1: Add a Resource Catalog Classification

In the <<< custom_key.brand_name >>> workspace, through 「Infrastructure」 - 「Custom」 - 「Add Object Classification」, you can create new object classifications along with resource catalog classification names and object fields.

- Object Classification: The classification name of the resource catalog, i.e., the "object classification name" used during the reporting of resource catalog data. When reporting data, you need to ensure that the **"object classification name" matches the naming used during data reporting.**
- Alias: Add an alias for the current object classification, which is the name displayed in the resource catalog list.
- Default Attributes: Add custom fields and field aliases required for objects, with the default `name` field added for objects. During data reporting, these custom fields are mandatory for the object classification under which the data is being reported.

**Note:**

1. The custom fields in the 「Default Attributes」 are mandatory fields when reporting data. If the reported data is missing any mandatory fields, it will not be successfully reported to the <<< custom_key.brand_name >>> workspace.
2. If the reported data contains mandatory fields and includes other fields, non-mandatory fields will appear as data tags.
3. If the data type reported does not match the defined field data type, the data will not be successfully reported to the <<< custom_key.brand_name >>> workspace. For example: If the field type is defined as character type in DataFlux Func, but the data type reported is integer type, this data will not be successfully reported to the <<< custom_key.brand_name >>> workspace.

![](img/1.custom_1.png)

For more details, refer to the help documentation [Resource Catalog Classification](../infrastructure/custom/index.md).



### Step2: Custom Reporting of Object Data

After adding the resource catalog classification, you can proceed with custom data reporting. To report resource catalog data, you need to install and connect DataKit and DataFlux Func first, then use DataFlux Func to report data to DataKit, and finally report the data to the <<< custom_key.brand_name >>> workspace via DataKit.

![](img/custom_1.png)

For specific operational steps, refer to the document [Resource Catalog Data Reporting](../infrastructure/custom/data-reporting.md).