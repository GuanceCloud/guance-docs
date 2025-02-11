# Customizing RUM SDK Data Collection
---

By default, the RUM SDK automatically collects Web data and uploads it to DataKit. In most application scenarios, there is no need to actively modify this data. However, in some specific situations, different types of identifiers are required to locate and analyze certain data. Therefore, for these cases, the RUM SDK provides specific APIs that allow users to add their own custom logic into their application systems:

1. [Customize User Identification (ID, name, email)](./user-id.md)
2. [Custom Add Additional Data TAG](./add-additional-tag.md)
3. [Custom Add Action](./add-action.md)
4. [Custom Add Error](./add-error.md)