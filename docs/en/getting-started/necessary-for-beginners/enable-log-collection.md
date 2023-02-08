# Turn on Log Collection
---

Guance supports custom log collection and standard log collection.

- Custom log collection: Go to the conf.d/log directory under the DataKit installation directory, copy logging.conf.sample and name it logging.conf for configuration. After the configuration is completed, restarting DataKit will take effect.
- Standard log collection: By opening log collectors supported by observation cloud, such as [Nginx](../../integrations/webserver/nginx.md), [Redis](../../integrations/datastorage/redis.md) and [ElasticSearch](../../integrations/datastorage/elasticsearch.md), log collection can be started with one click.

## Turn on Custom Log Collection

1.You can go to the `conf.d/log` directory under the DataKit installation directory, copy `logging.conf.sample` and name it `logging.conf`。

(Note: The open collector must be a .conf file.)

![](../img/13.logging.png)

2.Use the command `vim logging.conf` to open and edit `logging.conf`, modify the `logfiles` address (default `logfiles = ["/var/log/syslog"]`）, and add the `source` source as “syslog”.

(Note: Press i to enter edit mode, press esc to exit edit mode, enter :wq save to exit edit mode, enter :q do not save to exit edit mode.)

![](../img/13.logging_2.png)

The address of `logfiles` can be checked by `ls /var/log` to see which directory it is and confirmed by `tail -f /var/log/syslog` to see if there are logs in that directory. See the doc [log collector](../../datakit/logging.md) for more configurations.

![](../img/13.logging_1.png)

After the configuration is complete, you can restart DataKit through `datakit --restart` to take effect.

3.After the configuration of the custom log collector is completed, wait for a period of time after the DataKit is restarted, and the corresponding log data can be viewed in the Guance workspace. Click "Log" to view the collected "syslog" log.

![](../img/13.logging_3.png)

## Turn on Standard Log Collection

1.To start standard log collection, take nginx as an example, enter the `conf.d/nginx` directory under the datakit installation `/usr/local/datakit`, copy `nginx.conf.sample` and name it `nginx.conf`.

(Note: Before starting Nginx log collection, you need to build an Nginx project environment on the host.)

![](../img/13.nginx.png)

2.In `nginx.conf` , open `files` and write the absolute path to the `NGINX` log file.

`files = ["/var/log/nginx/error.log","/var/log/nginx/access.log"]`

![](../img/13.nginx_3.png)

The address of Nginx's `files` can be viewed at `ls /var/log`, [learn more about Nginx log data collection configuration](../../integrations/webserver/nginx.md).

![](../img/13.nginx_1.png)

After the configuration is complete, you can restart DataKit through `datakit --restart` to take effect.

3.After the configuration of Nginx log collector is completed, wait for a while after DataKit restarts, and then view Nginx log data in the Guance workspace.

![](../img/13.nginx_4.png)

After the log data is collected, we can cut the log through the log Pipeline tool provided by Guance, which makes the log data easier to search and analyze. For how to open and use the log Pipeline tool, please refer to the doc [how to quickly analyze Nginx log](../basic-introduction/nginx-collection-analysis.md).

In addition, DataKit installs and collects data, and we can also [build a scene dashboard](custom-dashboard.md) for the collected data. If data visual analysis and monitoring alarm are needed, please refer to the document on [how to quickly use scenes and monitoring for details](../basic-introduction/scene-alert.md).