---
icon: zy/dataflux-func
---

# DataFlux Func
---

DataFlux Func (Automata) is a script development, management, and execution platform based on Python. It is a function computation component under [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/), and has now become an independently operable system.

It is mainly divided into two parts:

1. Server: Built using Node.js + Express, primarily providing Web UI services and external API interfaces.
1. Worker: Built using Python3 + Celery, primarily providing the execution environment for Python scripts (contains the Beat module internally).