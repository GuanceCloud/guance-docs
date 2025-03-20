---
title     : 'Automatically Inject DDTrace-Java Agent'
summary   : 'DDTrace Java Integration'
tags      :
  - 'APM'
  - 'JAVA'
__int_icon: 'icon/ddtrace'
---

<!-- markdownlint-disable MD046 MD030 -->
<div class="grid cards" markdown>

-   [:material-language-java: :material-download:](https://static.guance.com/ddtrace/agent-attach-java.jar){:target="_blank"} ·
    [:material-github:](https://github.com/GuanceCloud/agent-attach-java){:target="_blank"} ·
    [Issue](https://github.com/GuanceCloud/agent-attach-java/issues/new){:target="_blank"} ·
    [:octicons-history-16:](https://github.com/GuanceCloud/agent-attach-java/releases){:target="_blank"}

</div>
<!-- markdownlint-enable MD046 MD030 -->

---

This Java tool is mainly used to inject the DDTrace-Java agent into a currently running Java process without manual configuration and restarting the host Java process.

## Principle {#principle}

The basic principle of agent injection is through a file under the directory */proc/[Java-PID]* (or */tmp/*), injecting

``` not-set
load instrument dd-agent.jar=<params...>
```

Then sending a SIGQUIT signal to the JVM, after which the JVM will read the specified agent jar package.

## Download and Compile {#download}

JDK versions 1.8 and above cannot be cross-used.

If using a released version, please use the corresponding [release version](https://github.com/GuanceCloud/agent-attach-java/releases){:target="_blank"}

***It is recommended to download the source code*** and compile:

```shell
git clone https://github.com/GuanceCloud/agent-attach-java
```

If using JDK 1.8 version, modify the pom.xml configuration file:

```xml
<!--Change the version to 1.8 -->
    <configuration>
      <source>1.8</source>
      <target>1.8</target>
    </configuration>
    
    <!--Uncomment the following dependency and comment out tools.jar !!!-->
    <dependency>
      <groupId>io.earcam.wrapped</groupId>
      <artifactId>com.sun.tools.attach</artifactId>
      <version>1.8.0_jdk8u131-b11</version>
      <scope>compile</scope>
      <type>jar</type>
    </dependency>
```

If the version is JDK 9, 11, or 17, use the following pom.xml configuration:

```xml
<!--Change the target version to the specified version-->
    <configuration>
        <source>11</source>
        <target>11</target>
    </configuration>

<!--    <dependency>
      <groupId>io.earcam.wrapped</groupId>
      <artifactId>com.sun.tools.attach</artifactId>
      <version>1.8.0_jdk8u131-b11</version>
      <scope>compile</scope>
      <type>jar</type>
    </dependency>-->
    <dependency>
      <groupId>com.sun</groupId>
      <artifactId>tools</artifactId>
      <version>1.8.0</version>
      <scope>system</scope>
      <systemPath>${project.basedir}/lib/tools.jar</systemPath>
    </dependency>
```

```shell
mvn package
# Use target/agent-attach-java-jar-with-dependencies.jar
rm -f target/agent-attach-java.jar
mv target/agent-attach-java-jar-with-dependencies.jar agent-attach-java.jar
```

Use `-h` to view:

``` shell
agent-attach-java$ java -jar target/agent-attach-java-jar-with-dependencies.jar -h

java -jar agent-attach-java.jar [-options <dd options>]
                                [-agent-jar <agent filepath>]
                                [-pid <pid>]
                                [-displayName <service name/displayName>]
                                [-h]
                                [-help]
[-options]:
   this is dd-java-agnet.jar env, example:
       dd.agent.port=9529,dd.agent.host=localhost,dd.service.name=serviceName,...
[-agent-jar]:
   default is: /usr/local/ddtrace/dd-java-agent.jar
[-pid]:
   service PID String
[-displayName]:
   service name
Note: -pid or -displayName must have a non empty value!!

Example command line:

java -jar agent-attach-java.jar -options 'dd.service.name=test,dd.tag=v1'\
 -displayName tmall.jar \
 -agent-jar /usr/local/ddtrace/dd-java-agent.jar
```

Parameter descriptions:

- `-options` DDTrace parameters: `dd.agent.host=localhost,dd.agent.port=9529,dd.service.name=mytest ...`
- `-agent-jar` agent path Default: `/usr/local/ddtrace/dd-java-agent.jar`
- `-pid` Process PID, both PID and `displayName` cannot be empty at the same time; you can use one of them.
- `-displayName` Process name Example: `-displayName tmall.jar`
- `-h or -help` Help

Note: Since JDK 9 does not include the *tools.jar* file, the *tools* file is included in the project directory. The *lib/tools.jar* is for JDK 1.8 version.

## Dynamically Inject *dd-java-agent.jar* {#dynamic-inject-ddagent-java}

- First download *dd-java-agent.jar*, and place it in the */usr/local/ddtrace/* directory.

```shell
mkdir -p /usr/local/ddtrace
cd /usr/local/ddtrace
wget https://static.guance.com/ddtrace/dd-java-agent.jar
```

<!-- markdownlint-disable MD046 -->
???+ attention

    You must use the [Extended DDTrace](ddtrace-ext-java.md), otherwise the auto-injection feature is limited (various Trace parameters cannot be set).
<!-- markdownlint-enable -->

- Start the Java application (if the Java application has already started, ignore this step)

- Start *agent-attach-java.jar* to inject *dd-trace-java.jar*

```shell
java -jar agent-attach-java.jar \
 -options "dd.agent.port=9529" \
 -displayName "tmall.jar" \
 -agent-jar /usr/local/datakit/data/dd-java-agent.jar
```

Or:

```shell
java -jar agent-attach-java.jar \
 -options "dd.agent.port=9529" \
 -pid 7027 \
 -agent-jar /usr/local/datakit/data/dd-java-agent.jar
```

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Cannot find class VirtualMachine? {#NoClassDefFound}
<!-- markdownlint-enable -->

Error message:

```text
Exception in thread "main" java.lang.NoClassDefFoundError: com/sun/tools/attach/VirtualMachine
        at com.guance.javaagent.JavaAgentLoader.loadAgent(JavaAgentLoader.java:35)
        at com.guance.javaagent.MyMainClass.main(MyMainClass.java:19)
Caused by: java.lang.ClassNotFoundException: com.sun.tools.attach.VirtualMachine
        at java.net.URLClassLoader.findClass(URLClassLoader.java:382)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
        ... 2 more
```

This is due to the absence of the tools.jar package. Use the correct pom.xml configuration file or download the corresponding version.

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Version Unsupported? {#UnsupportedClass}
<!-- markdownlint-enable -->

Error message:

```text
Error: A JNI error has occurred, please check your installation and try again
Exception in thread "main" java.lang.UnsupportedClassVersionError: com/guance/javaagent/MyMainClass has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
        at java.lang.ClassLoader.defineClass1(Native Method)
        at java.lang.ClassLoader.defineClass(ClassLoader.java:763)
        at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
        at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
        at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
        at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
        at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
        at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:495)
```

This occurs because the compilation version is too low while the runtime version is too high. Change the version or recompile with the current version.