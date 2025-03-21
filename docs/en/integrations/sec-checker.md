---
title     : 'SCheck'
summary   : 'Receive data collected by SCheck'
tags:
  - 'Security Checks'
__int_icon: 'icon/scheck'
---

Operating system support: :fontawesome-brands-linux: :fontawesome-brands-windows:

---

Datakit can directly access the data from Security Checker. For specific usage of Security Checker, refer to [this link](../scheck/scheck-install.md).

## Install Security Checker through DataKit {#install}

```shell
sudo datakit install --scheck
```

After installation, Security Checker will send data to the DataKit `:9529/v1/write/security` interface by default.