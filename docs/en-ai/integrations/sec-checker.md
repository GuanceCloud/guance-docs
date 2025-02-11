---
title     : 'SCheck'
summary   : 'Receive data collected by SCheck'
tags:
  - 'Security'
__int_icon: 'icon/scheck'
---

Operating system support：:fontawesome-brands-linux: :fontawesome-brands-windows:

---

DataKit can directly receive data from Security Checker. For specific usage of Security Checker, refer to [here](../scheck/scheck-install.md).

## Install Security Checker via DataKit {#install}

```shell
sudo datakit install --scheck
```

After installation, Security Checker will send data to the DataKit interface `:9529/v1/write/security` by default.