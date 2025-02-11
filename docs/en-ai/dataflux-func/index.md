---
icon: zy/dataflux-func
---

# DataFlux Func
---

DataFlux Func is a platform for the development, management, and execution of Python-based scripts. It is a function computing component under [Guance](https://guance.com/) and has now become an independently operable system.

It mainly consists of two parts:

- Server: Built using Node.js + Express, it primarily provides Web UI services and external API interfaces.
- Worker: Constructed using Python3 + Celery, it mainly offers an execution environment for Python scripts (including the Beat module).