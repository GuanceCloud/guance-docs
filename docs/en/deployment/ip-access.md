## Domain Access Modification to IP Access

### 1. Modify the SVC Configuration of Related Services

- Modify the service status in the forethought-webclient Namespace

```shell
kubectl patch svc  management-webclient -n forethought-webclient -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc  front-webclient -n forethought-webclient -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc  dataflux-doc -n forethought-webclient -p '{"spec": {"type": "NodePort"}}'
```

- Modify the service status in the forethought-core Namespace

```shell
kubectl patch svc  management-backend -n forethought-core -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc  static-resource-nginx -n forethought-core -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc  front-backend -n forethought-core -p '{"spec": {"type": "NodePort"}}'
```

- Modify the service status in the func2 Namespace

```shell
kubectl patch svc  server -n func2 -p '{"spec": {"type": "NodePort"}}'
```

> Obtain the corresponding NodePort ports for the svc services and record them, as they will be used later.

### 2. Modify the ConfigMap Configuration of Related Services

- **Log in to the launcher interface via the browser**


- **Modify the Configmap configuration related to backend management in forethought-webclient**

![ip-access2](img/ip-access2.png)

![ip-access3](img/ip-access3.png)

![ip-access4](img/ip-access4.png)

> Modify it to the corresponding HOST IP + port under the forethought-core Namespace for management-backend

- **Modify the Configmap configuration related to the homepage in forethought-webclient**

![ip-access5](img/ip-access5.png)

![ip-access6](img/ip-access6.png)

![ip-access7](img/ip-access7.png)

![ip-access8](img/ip-access8.png)

- **Modify the Configmap configuration related to the homepage in forethought-core**

![ip-access9](img/ip-access9.png)

![ip-access10](img/ip-access10.png)

![ip-access11](img/ip-access11.png)

![ip-access12](img/ip-access12.png)

- **Modify the Configmap configuration related to kodo-nginx in forethought-kodo**

![ip-access13](img/ip-access13.png)

- **Modify the Configmap configuration related to the func center in func2**

![ip-access14](img/ip-access14.png)

- **Confirm the configuration modifications, check the restart service option, and verify through the browser**

![ip-access15](img/ip-access15.png)

> Note: After modification, wait a few minutes for the services to restart before accessing them again.