---
title     : 'Grafana Guance Datasource'
summary   : 'Grafana 接入{{{ custom_key.brand_name }}}数据提供的 Datasource 源'
__int_icon: 'icon/grafana_datasource'
---

<!-- markdownlint-disable MD025 -->
# Grafana Guance Datasource
<!-- markdownlint-enable -->

本插件目的为在 Grafana 中展示{{{ custom_key.brand_name }}}数据，提供的 Datasource 插件。

## 配置 {#config}

- 1 [点击下载插件](https://{{{ custom_key.static_domain }}}/grafana-plugins/guance-guance-datasource.zip){:target="_blank"}

- 2 找到 Grafana 配置文件，默认路径参考[官方文档](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location){:target="_blank"}

- 3 在配置文件中找到配置的插件目录

```shell
[paths]
plugins = "/path/to/grafana-plugins"
```

- 4 下载的文件解压放到插件目录

```shell
unzip guance-guance-datasource.zip -d YOUR_PLUGIN_DIR/
```

- 5 修改配置项为：

```shell
[plugins]
allow_loading_unsigned_plugins = guance-guance-datasource
```

- 6 重启 Grafana
