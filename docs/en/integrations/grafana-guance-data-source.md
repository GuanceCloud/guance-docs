---
title     : 'Grafana <<< custom_key.brand_name >>> Datasource'
summary   : 'Grafana connects to the data provided by <<< custom_key.brand_name >>> Datasource'
__int_icon: 'icon/grafana_datasource'
---

<!-- markdownlint-disable MD025 -->
# Grafana <<< custom_key.brand_name >>> Datasource
<!-- markdownlint-enable -->

This plugin is designed to display <<< custom_key.brand_name >>> data within Grafana, providing a Datasource plugin.

## Configuration {#config}

- 1 [Click to download the plugin](https://static.<<< custom_key.brand_main_domain >>>/grafana-plugins/guance-guance-datasource.zip){:target="_blank"}

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