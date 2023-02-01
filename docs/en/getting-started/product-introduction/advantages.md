# Product Advantage
---

## Guance VS Zabbix
Zabbix is the mainframe management and monitoring product used by most operators and maintenance professionals. Compared to Zabbix, Guance has the following advantages.

- The bottom layer of Zabbix is Mysql, and its data accuracy and data storage capacity should not be too large. Compared with Guance, it can have the data collection capability of seconds (default 10s), and at the same time, it stores data for one year by default, and its performance will not be degraded due to massive data.
- Guance is more oriented to the cloud-native era, including support for Kubernetes compared to Zabbix.
- Guance does not just monitor hosts, but provides observability across the full technology stack.
- Guance uses a secure language that is more secure and reliable than Zabbix's script-based approach.
- Guance supports logging, while Zabbix has no logging capabilities.
## Guance VS Prometheus
Prometheus is a recently popular observability product based on a temporal database, featuring a Scrape model for data synchronization, an independent Exporter system, and a cloud-native monitoring solution recommended by the CNCF Cloud Native Foundation. Compared to Prometheus, Guance has several advantages.

- Prometheus is more complex to build as a whole, so if a large application requires a combination of Grafana, OpenTSDB or InfluxDB as an overall solution, Guance is ready to use out of the box.
- Prometheus has a large number of third-party Exporter that are difficult to use and have a lot of potential technical risks in the open source code.
- Prometheus only provides the construction of Metrics, and cannot provide the other two capabilities, including Logging and Tracing, which need to be used in combination with Loki and Skywalking.
- Prometheus' AlertManager is simple and powerful for anomaly detection of Guance.
- Prometheus data storage is only stand-alone by default and cannot save and query a large number of metrics for a long time.
## Guance VS ELK
ELK is an overall monitoring and detection solution developed by Elastic.co based on ElasticSearch, consisting of ElasticSearch, Logstash and Kibana. Recently, there are also products based on Fluentd as an alternative to Logstash, forming the EFK solution to better suit the cloud native environment. In terms of metrics collection, ELK uses the Beats component series, MetricBeats and Filebeats, while recently opening up the ELK APM module, compared to ELK, Guance has the following advantages.

- ELK is extremely complex to deploy and install, and it is fine if you simply collect logs, but if you use Logstash and Kibana, the learning cost is huge.
- The overall cost of ELK operations and maintenance is huge, and ElasticSearch clusters require a lot of money, while if you consider hot and cold data to save money is also a headache, using the Guance does not need to consider these issues.
- ELK's beats series stores metrics in logs, which can lead to OOM in clustering calculations and large scale data queries.
- Kibana is not that easy to use and KQL is expensive to learn, while Guance is much simpler.
- Beats, Logstash, or Fluentd are not as easy to configure and have a very high learning curve, but Guance solves all the problems by simply installing a DataKit and completing the installation.
- Guance is also compatible with Beats, Logstash and Fluentd.
## Guance VS Zipkin, jaeger, Pinpoint and Skywalking
This category of open source products are all based on application observability and open source APM products built on the OpenTelemetry system, represented by Skywalking, which has just been selected by the Apache Foundation and is characterized by its focus on application layer performance, failures, and providing observability for the application layer. In contrast, Guance have the following advantages.

- Guance are more comprehensive, covering not only data at the APM layer, but also infrastructure, containers, middleware, and network performance.
- These products usually rely on big data bases, such as ElasticSearch and HBase, their own products also have huge costs and investment in operation and maintenance, while Guance does not need to consider these issues.
- These products have different levels of support for various programming languages and frameworks, while Guance is based on the dd-trace of DataDog, the world's largest observability service provider, and is also compatible with all the above-mentioned agents (except Pinpoint), so it can achieve compatibility with all programming languages.
- Compared to these products, Guance provides a unified UI for displaying application performance and front-end performance, and forms a correlation model with other underlying data.
## Guance VS Grafana
Grafana is an open source data visualization tool for the monitoring domain that does not process data itself, but rather integrates with the aforementioned products in order to be valuable. Compared to Grafana, Guance has the following advantages.

- Grafana does not process data, it is only a presentation layer, equivalent to the scenario function of Guance.
- Grafana itself does not have a unified data query language, and different data layers determine the use of different query languages to build the presentation layer, while Cloud unifies the query layer through the DQL query language, greatly reducing the user's threshold of use.
- Grafana mainly spends on time-series structured data, which cannot be effectively displayed for relational data, and the usage function seems to be powerful but quite cumbersome. Guance not only has similar functions and is simple to use, but also has a large number of built-in tools for analyzing and examining data, and is not just a simple data visualization tool.
- Grafana, because of its open source property, needs to redesign the corresponding data interface of the presentation layer for different data sources, and the production of the presentation layer is quite tedious, while Guance itself unifies the data layer through DataKit, and can build the presentation layer very easily and conveniently.
## Guance VS other commercial software
Compared to other commercial software, Guance has the following advantages.

- Born and serve for users, Guance is based on on-demand and on-volume fees, free of charge for features, paid for data storage and processing, completely using the cloud business model compared to other commercial software. It is really qualified only when users use it well.
- Compared to other commercial software that takes monitoring as the starting point, Guance takes safeguarding each business project as the starting point, and provides the overall full-link observability capability of a project as the cornerstone of Devops.
- Unlike most solutions on the market, Guance has built a complete product form and data form from the first day of the product, so all functions are one storage, one platform and one product. The different functions of other commercial software are cut into individual software, and if the data generated by all the software is to be integrated and aggregated, it is necessary to introduce heavyweight big data processing solutions such as Hadoop, Flink and Spark. Guance is inherently cloud-native, and we leverage powerful multimodal data processing technologies to achieve an integrated product.
- Guance as a whole provides not just software, but a service. We do not just sell software but provide our customers with a comprehensive set of real-time data-based support guarantee system, while the overall user use of comprehensive investment is far lower than other commercial software on the market.

