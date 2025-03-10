# Resources and System Requirements


## Single Machine Environment Resource List {#list}

???+ warning "Note"

    1. The “Minimum Configuration” is suitable for POC scenario deployment, only for functional verification, not suitable for production environment use.

| **Purpose**                    | **Resource Type** | **Minimum Specification**                           | **Recommended Specification**                       | **Quantity** | **Remarks**           |
|---------------------------| --- |------------------------------------|--------------------------------|--------|------------------|
| **Kubernetes <br/>Middleware <br/>Business Services** | Physical Server&#124;Virtual Machine | 16C64GB <br/>100GB System Disk<br/>500GB Data Disk | 32C128GB  <br/>100GB System Disk <br/>1TB Data Disk | 1      | All required services are deployed on a single server |
| **Others**                    | Email Server/Short Message | -                                  | -                              | 1      | SMS gateway, email server, alert channel  |
|                           | Officially Registered Wildcard Domain | -                                  | -                              | 1      | Main domain needs to be registered           |
|                           | SSL/TLS Certificate | Wildcard Domain Certificate                            | Wildcard Domain Certificate                        | 1      | To secure the site           |