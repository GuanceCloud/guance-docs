---
title     : 'Socket Logging'
summary   : 'Mainly describes how to configure Socket in Java/Go/Python logging frameworks to send logs to the Datakit log collector.'
tags:
  - 'LOG'
__int_icon      : 'icon/socket'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

This article mainly introduces how to configure Socket in Java/Go/Python logging frameworks to send logs to the Datakit log collector.

> File collection and Socket collection are mutually exclusive. Before enabling Socket collection, please first disable file collection; see [Log Collection Configuration](logging.md).

## Configuration {#config}

### Java {#java}

When configuring log4j, note that log4j v1 defaults to using *.properties* files for configuration, while log4j-v2 uses XML files for configuration.

Although the filenames differ, when log4j looks for configuration files, it searches the Class Path directory, following the standard: v1 configurations are located in *resources/log4j.properties*, and v2 configurations are in *resources/log4j.xml*.

#### log4j(v2) {#log4j-v2}

In Maven configuration, import the log4j 2.x jar package:

``` xml
<dependency>
   <groupId>org.apache.logging.log4j</groupId>
   <artifactId>log4j-api</artifactId>
   <version>2.6.2</version>
</dependency>

<dependency>
   <groupId>org.apache.logging.log4j</groupId>
   <artifactId>log4j-core</artifactId>
   <version>2.6.2</version>
</dependency>
```

In the *resources* directory, configure *log4j.xml* and add `Socket Appender`:

``` xml
 <!-- Socket appender configures log transmission to port 9530 on localhost, protocol default is TCP -->
 <Socket name="socketname" host="localhost" port="9530" charset="utf8">
     <!-- Customize output format and sequence layout -->
     <PatternLayout pattern="%d{yyyy.MM.dd 'at' HH:mm:ss z} %-5level [traceId=%X{trace_id} spanId=%X{span_id}] %class{36} %L %M - %msg%xEx%n"/>

     <!-- Note: Do not enable serialization transmission to the socket collector, as DataKit cannot deserialize it; use plain text transmission instead -->
     <!-- <SerializedLayout/>-->

     <!-- Second output format JSON -->
     <!-- Note: The compact and eventEol settings must be true so each log entry is output on a single line -->
     <!-- Sending logs to Guance will automatically expand the JSON, so here we recommend you output each log entry on a single line -->
     <!-- <JsonLayout  properties="true" compact="true" complete="false" eventEol="true"/>-->
 </Socket>

 <!-- Then define logger; only defined loggers with attached appenders will take effect -->
 <loggers>
      <root level="trace">
          <appender-ref ref="Console"/>
          <appender-ref ref="socketname"/>
      </root>
 </loggers>
```

Java code example:

``` java
package com.example;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.io.PrintWriter;
import java.io.StringWriter;

public class logdemo {
    public static void main(String[] args) throws InterruptedException {
        Logger logger = LogManager.getLogger(logdemo.class);
       for (int i = 0; i < 5; i++) {
            logger.debug("this is log msg to  datakt");
        }

        try {
            int i = 0;
            int a = 5 / i; // Division by zero exception
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsString = sw.toString();
            logger.error(exceptionAsString);
        }
    }
}
```

#### log4j(v1) {#log4j-v1}

In Maven configuration, import the log4j 1.x jar package

``` xml
 <dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>1.2.17</version>
 </dependency>
```

Create a *log4j.properties* file in the resources directory:

``` text
log4j.rootLogger=INFO,server
# ... Other configurations

log4j.appender.server=org.apache.log4j.net.SocketAppender
log4j.appender.server.Port=<dk socket port>
log4j.appender.server.RemoteHost=<dk socket ip>
log4j.appender.server.ReconnectionDelay=10000

# Can be configured in JSON format
# log4j.appender.server.layout=net.logstash.log4j.JSONEventLayout
...
```

#### Logback {#logback}

The `SocketAppender` in Logback [cannot send plain text over the Socket](https://logback.qos.ch/manual/appenders.html#SocketAppender){:target="_blank"}.

> The issue is that `SocketAppender` sends serialized Java objects rather than plain text. You can use `log4j` input, but replacing the logging component is not recommended. Instead, rewrite an `Appender` that sends log data as plain text and use it with JSON formatting.

Alternative solution: [Best Practices for Logback Logstash Plugin](../best-practices/cloud-native/k8s-logback-socket.md#spring-boot){:target="_blank"}


### Golang {#golang}

#### Zap {#zap}

The most commonly used logging framework in Golang is Uber's open-source Zap logging framework, which supports custom Output injection.

Customize the log outputter and inject it into `zap.core`:

``` golang
type soceketOutput struct {
    conn net.Conn
}

func (s *soceketOutput) Write(b []byte) (int, error) {
    return s.conn.Write(b)
}

func zapcal() {
    conn, _ := net.DialTCP("tcp", nil, DK_LOG_PORT)
    socket := &soceketOutput{
        conn: conn,
    }

    w := zapcore.AddSync(socket)

    core := zapcore.NewCore(zapcore.NewConsoleEncoder(zapcore.EncoderConfig{
        TimeKey:        "ts",
        LevelKey:       "level",
        NameKey:        "logger",
        CallerKey:      "caller",
        FunctionKey:    zapcore.OmitKey,
        MessageKey:     "msg",
        StacktraceKey:  "stacktrace",
        LineEnding:     zapcore.DefaultLineEnding,
        EncodeLevel:    zapcore.LowercaseLevelEncoder,
        EncodeTime:     zapcore.EpochTimeEncoder,
        EncodeDuration: zapcore.SecondsDurationEncoder,
        EncodeCaller:   zapcore.ShortCallerEncoder,
    }),
        w,
        zapcore.InfoLevel)
    
    l := zap.New(core, zap.AddCaller())

    l.Info("======= message =======")
}
```

### Python  {#python}

#### logging.handlers.SocketHandler {#socket-handler}

The native `socketHandler` sends log objects via the socket, not in plain text form, so you need to customize a Handler and override the `makePickle(self, record)` method in `socketHandler`.

Code for reference:

```python
import logging
import logging.handlers

logger = logging.getLogger("") # Instantiate logging

# Custom class overriding makePickle method
class PlainTextTcpHandler(logging.handlers.SocketHandler):
    """ Sends plain text log messages over TCP channel """

    def makePickle(self, record):
     message = self.formatter.format(record) + "\r\n"
     return message.encode()


def logging_init():
    # Create file handler
    fh = logging.FileHandler("test.log", encoding="utf-8")
    # Create custom handler
    plain = PlainTextTcpHandler("10.200.14.226", 9540)

    # Set logger log level
    logger.setLevel(logging.INFO)

    # Set log output format
    formatter = logging.Formatter(
        fmt="%(asctime)s - %(filename)s line:%(lineno)d - %(levelname)s: %(message)s"
    )

    # Specify output format for handler, note case sensitivity
    fh.setFormatter(formatter)
    plain.setFormatter(formatter)
  
    
    # Add log handlers to logger
    logger.addHandler(fh)
    logger.addHandler(plain)
    
    return True

if __name__ == '__main__':
    logging_init()

    logger.debug(u"debug")
    logger.info(u"info")
    logger.warning(u"warning")
    logger.error(u"error")
    logger.critical(u"critical")
    
```

TODO: We will gradually supplement the logging frameworks of other languages to use sockets to send logs to DataKit.
```