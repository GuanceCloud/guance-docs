# Customizing Data Collection Content for User Access Monitoring SDK
---

By default, the RUM SDK automatically collects data from mini-programs and uploads it to DataKit. In most application scenarios, there is no need to modify this data actively. However, in some specific scenarios, different types of identifiers are required to locate and analyze certain data. Therefore, the RUM SDK provides specific APIs for users to add their own custom logic within their application systems:

1. Customize user identification (ID, name, email)
2. Add custom data TAGs
3. Add custom Actions