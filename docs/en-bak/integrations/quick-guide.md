---
title     : 'Grafana Dashboard Import'
summary   : 'Grafana Dashboard Template Import Tool for Guance Cloud'
__int_icon: 'icon/grafana_import'
---

<!-- markdownlint-disable MD025 -->
# Grafana Dashboard Import
<!-- markdownlint-enable -->

Guance Cloud provides a `Node.js` script to convert Grafana dashboard JSON templates into Guance Cloud dashboard JSON templates.

## Configuration {#config}

### Prerequisites {#requirement}

Ensure that `nodejs` and `npm` are installed on the system with the following version requirements:

- [x] node >= 12.7.0
- [x] npm >= 6.10.0

### Usage

- 1 Install the script

```bash
npm install -g @cloudcare/guance-front-tools
```

- 2 View the script usage help

```bash
grafanaCovertToGuance
```

The specific script commands are:

- `-d`: Path to the Grafana JSON file, e.g.: `./grafana/json/grafana.json`
- `-o`: Output path for the Guance dashboard JSON file, e.g.: `./guance/json/guance.json`

- 3 Execute the conversion command

```bash
grafanaCovertToGuance -d ./grafana/json/grafana.json -o ./guance/json/guance.json
```

- 4 Import the converted JSON file in the Guance Cloud console.

- 5 Done.
