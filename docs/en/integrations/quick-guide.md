---
title     : 'Grafana Dashboard Import'
summary   : 'Grafana Dashboard template import tool for <<< custom_key.brand_name >>>'
__int_icon: 'icon/grafana_import'
---

<!-- markdownlint-disable MD025 -->
# Grafana Dashboard Import Tool
<!-- markdownlint-enable -->

<<< custom_key.brand_name >>> currently provides a node script to convert Grafana dashboard templates into <<< custom_key.brand_name >>> dashboard templates.

## Configuration {#config}

### Prerequisites {#requirement}

You need to have `nodejs` and `npm` installed on your system, with the following version requirements:

- [x]  node >= 12.7.0
- [x]  npm >= 6.10.0

### Usage

- 1. Install the script

```bash
npm install -g @cloudcare/guance-front-tools
```

- 2. View the script usage help

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertToGuance
```
<!-- markdownlint-enable -->

The specific script execution command is as follows:
`-d`: The directory location of the Grafana JSON file, for example: `./grafana/json/grafana.json`
`-o`: The output location of the <<< custom_key.brand_name >>> dashboard JSON file, for example: `./guance/json/guance.json`

- 3. Execute the conversion command

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertTo<<< custom_key.brand_name >>> -d ./grafana/json/grafana.json -o ./guance/json/guance.json
```
<!-- markdownlint-enable -->
- 4. Import the converted `json` file in the <<< custom_key.brand_name >>> console

- 5. Complete
