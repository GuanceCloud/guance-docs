# Customize SDK Collecting Data
---

By default, RUM SDK automatically collects web data and uploads it to datakit, Most application scenarios do not need to actively modify these data, but there are also some specific scenarios that need to locate and analyze some data by setting different types of identifiers. Therefore, in view of these situations, RUM SDK provides some specific API aspects. Users add their own specific logic to their own application systems:

1. Customized User Identification (ID, name, email)
2. Customize to add additional data TAG
3. Custom Add Action
4. Custom Add Error 
