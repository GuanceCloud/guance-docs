---
title     : 'Grafana Guance Datasource'
summary   : 'Grafana connects to the data provided by Guance Datasource'
__int_icon: 'icon/grafana_datasource'
---

<!-- markdownlint-disable MD025 -->
# Grafana Guance Datasource
<!-- markdownlint-enable -->

This plugin is designed to display Guance data within Grafana, providing a Datasource plugin.

## Configuration {#config}

- 1 [Click to download the plugin](https://static.guance.com/grafana-plugins/guance-guance-datasource.zip){:target="_blank"}

- 2 Locate the Grafana configuration file. The default path can be referenced in the [official documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location){:target="_blank"}

- 3 Find the configured plugin directory in the configuration file

```shell
[paths]
plugins = "/path/to/grafana-plugins"
```

- 4 Extract the downloaded file and place it in the plugin directory

```shell
unzip guance-guance-datasource.zip -d YOUR_PLUGIN_DIR/
```

- 5 Modify the configuration item to:

```shell
[plugins]
allow_loading_unsigned_plugins = guance-guance-datasource
```

- 6 Restart Grafana