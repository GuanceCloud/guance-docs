---
title     : 'Grafana Guance Datasource'
summary   : 'Grafana integration with Guance data provided as a Datasource plugin'
__int_icon: 'icon/grafana_datasource'
---

<!-- markdownlint-disable MD025 -->
# Grafana Guance Datasource
<!-- markdownlint-enable -->

This plugin aims to display Guance data within Grafana, providing a Datasource plugin.

## Configuration {#config}

- 1 [Click to download the plugin](https://static.guance.com/grafana-plugins/guance-guance-datasource.zip){:target="_blank"}

- 2 Locate the Grafana configuration file. The default path can be found in the [official documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location){:target="_blank"}

- 3 In the configuration file, find the configured plugin directory

```shell
[paths]
plugins = "/path/to/grafana-plugins"
```

- 4 Extract the downloaded file and place it in the plugin directory

```shell
unzip guance-guance-datasource.zip -d YOUR_PLUGIN_DIR/
```

- 5 Modify the configuration to:

```shell
[plugins]
allow_loading_unsigned_plugins = guance-guance-datasource
```

- 6 Restart Grafana
