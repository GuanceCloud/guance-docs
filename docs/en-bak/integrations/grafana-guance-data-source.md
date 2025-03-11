---
title     : 'Grafana Guance Datasource'
summary   : 'Datasource source provided by Guance Cloud for integration with Grafana.'
__int_icon: 'icon/grafana_datasource'
---

<!-- markdownlint-disable MD025 -->
# Grafana Guance Datasource
<!-- markdownlint-enable -->

The purpose of this plugin is to display data from Guance Cloud in Grafana by providing a Datasource plugin.

## Configuration {#config}

- 1 [Click to download the plugin](https://static.guance.com/grafana-plugins/guance-guance-datasource.zip){:target="_blank"}

- 2 Locate the Grafana configuration file. The default path can be found in the [official documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location){:target="_blank"}.

- 3 In the configuration file, find the plugin directory setting:

```shell
[paths]
plugins = "/path/to/grafana-plugins"
```

- 4 Extract the downloaded file into the plugin directory:

```shell
unzip guance-guance-datasource.zip -d YOUR_PLUGIN_DIR/
```

- 5 Update the configuration file with the following setting:

```shell
[plugins]
allow_loading_unsigned_plugins = guance-guance-datasource
```

- 6 Restart Grafana.
