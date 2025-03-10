---
title     : 'Grafana Dashboard Import'
summary   : 'Tool for importing Grafana Dashboard templates into Guance'
__int_icon: 'icon/grafance_import'
---

<!-- markdownlint-disable MD025 -->
# Grafana Dashboard Import Tool
<!-- markdownlint-enable -->

Guance currently provides a Node script to convert Grafana dashboard templates into Guance dashboard templates.

## Configuration {#config}

### Prerequisites {#requirement}

You need to have `nodejs` and `npm` installed on your system, with the following version requirements:

- [x]  node >= 12.7.0
- [x]  npm >= 6.10.0

### Usage

- 1 Install the script

```bash
npm install -g @cloudcare/guance-front-tools
```

- 2 View script usage help

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertToGuance
```
<!-- markdownlint-enable -->

The specific script execution commands are as follows:
`-d`: Directory location of the Grafana JSON file, for example: `./grafana/json/grafana.json`
`-o`: Output location of the Guance dashboard JSON file, for example: `./guance/json/guance.json`

- 3 Execute the conversion command

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertToGuance -d ./grafana/json/grafana.json -o ./guance/json/guance.json
```
<!-- markdownlint-enable -->
- 4 Import the converted `json` file into the Guance console

- 5 Complete