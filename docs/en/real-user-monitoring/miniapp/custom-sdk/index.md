# Custom RUM SDK Data Collection Content
---

By default, the RUM SDK automatically collects data from mini-programs and uploads it to DataKit. In most application scenarios, there is no need to actively modify this data. However, in some specific scenarios, it is necessary to set different types of identifiers to analyze certain data. Therefore, for these situations, the RUM SDK provides specific APIs that allow users to add their own custom logic within their application systems:

1. Custom user identification (ID, name, email)
2. Custom addition of extra data tags
3. Custom addition of Actions