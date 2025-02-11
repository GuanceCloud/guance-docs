# Resources and System Requirements


## Single-Machine Environment Resource List {#list}

???+ warning "Note"

    1. The “Minimum Configuration” is suitable for POC scenarios, only for functional verification, not recommended for production environments.

| **Purpose**                    | **Resource Type** | **Minimum Specification**                           | **Recommended Specification**                       | **Quantity** | **Remarks**           |
|-------------------------------|-------------------|----------------------------------------------------|---------------------------------------------------|--------------|-----------------------|
| **Kubernetes <br/>Middleware <br/>Business Services** | Physical Server&#124;VM | 16C64GB <br/>100GB system disk<br/>500GB data disk | 32C128GB  <br/>100GB system disk <br/>1TB data disk | 1             | All required services are deployed on a single server |
| **Others**                     | Email Server/SMS  | -                                                  | -                                                 | 1            | SMS gateway, email server, alert channels          |
|                               | Officially registered wildcard domain | -                                                  | -                                                 | 1            | Main domain must be registered                    |
|                               | SSL/TLS Certificate | Wildcard domain certificate                        | Wildcard domain certificate                        | 1            | Ensures site security                             |