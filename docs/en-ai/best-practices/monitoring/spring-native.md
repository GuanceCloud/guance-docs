# GraalVM and Spring Native Project for Tracing Observability

---

## Introduction

GraalVM is a high-performance, cloud-native, multi-language JDK distribution designed to accelerate the execution of applications written in Java and other JVM languages. It also provides runtimes for JavaScript, Python, and many other popular languages.

![image](../images/spring-native/1.png)

As a runtime environment, GraalVM is unique in that it offers multiple operational modes: JVM runtime mode, Native Image, and Java on Truffle (the same Java application can run on any of these).

#### JVM Runtime Mode

When running programs on the HotSpot JVM, GraalVM defaults to using the [GraalVM Compiler](https://www.graalvm.org/22.1/reference-manual/java/compiler/) as the top-level JIT compiler. At runtime, the application loads and executes normally on the JVM. The JVM passes bytecode from Java or any other native JVM language to the compiler, which compiles it into machine code and returns it to the JVM. Interpreters for supported languages written on the [Truffle framework](https://www.graalvm.org/22.1/graalvm-as-a-platform/language-implementation-framework/) themselves run as Java programs on the JVM.

#### Native Image

[Native Image](https://www.graalvm.org/22.1/reference-manual/native-image/) is an innovative technology that compiles Java code into standalone binary executables or native shared libraries. During the native image build process, the Java bytecode processed includes all application classes, dependencies, third-party dependency libraries, and any required JDK classes. The generated self-contained native executable is specific to each individual operating system and machine architecture that does not require a JVM.

Spring Native provides support for compiling Spring applications into native executables using the GraalVM native image compiler. This article uses the JVM runtime mode and ddtrace to implement tracing integration with Guance.

## Procedure

???+ warning

    The version information used in this example is as follows: DataKit `1.4.0`, CentOS `7.9`, Cloud Server `4-core 8GB`, Git `1.8.3.1`, Maven `3.8.5`, OpenJDK `17.0.3`, GraalVM CE `22.1.0`

### Step 1: Deploy Git

```shell
yum install -y git
git --version
```

![image](../images/spring-native/2.png)

### Step 2: Deploy GraalVM

```shell
cd /usr/local/df-demo
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.1.0/graalvm-ce-java17-linux-amd64-22.1.0.tar.gz
tar -zxvf graalvm-ce-java17-linux-amd64-22.1.0.tar.gz
```

Edit `/etc/profile` and add the following content:

```shell
export JAVA_HOME=/usr/local/df-demo/graalvm-ce-java17-22.1.0
export CLASSPATH=$JAVA_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$PATH
```

Install and configure `native-image`.

```shell
gu install native-image
yum install zlib-devel -y
```

### Step 3: Deploy Maven

```shell
cd /usr/local/df-demo
wget https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
tar -zxvf apache-maven-3.8.5-bin.tar.gz
```

Edit `/etc/profile` and add the following content:

```shell
export MAVEN_HOME=/usr/local/df-demo/apache-maven-3.8.5
export PATH=$PATH:$MAVEN_HOME/bin:$JAVA_HOME/bin   # Modify
```

```shell
source /etc/profile
```

```shell
cd /usr/local/df-demo/apache-maven-3.8.5/conf
```

Edit `settings.xml` and add the following content:

```xml
<mirrors>
    <mirror>
        <id>alimaven</id>
        <name>aliyun maven</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <mirrorOf>central</mirrorOf>
    </mirror>
    <mirror>
        <id>alimaven</id>
        <mirrorOf>central</mirrorOf>
        <name>aliyun maven</name>
        <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>
    </mirror>
</mirrors>
```

### Step 4: Create a Spring Boot Project

Go to [spring.io](https://start.spring.io/), select 「Spring Native」 and 「Spring Web」, choose 「Maven Project」 for Project, 「Java」 for Language, and define your own Project Name. Click 「GENERATE」.

![image](../images/spring-native/3.png)

Add Application and Controller, as shown in the sample project [springboot-native-demo](https://github.com/stevenliu2020/springboot-native-demo).

![image](../images/spring-native/4.png)

### Step 5: Package the Project

Upload the project to the `/usr/local/df-demo` directory on the cloud server and execute the packaging command.

```shell
cd /usr/local/df-demo/springboot-native-demo
mvn -Pnative -DskipTests clean package
```

![image](../images/spring-native/5.png)

Check the target directory; there should be binary files `springboot-native-demo` and `springboot-native-demo-1.0-SNAPSHOT-exec.jar`.

![image](../images/spring-native/6.png)

### Step 6: Trace Integration

#### 6.1 Install DataKit

Log in to 「[Guance](https://console.guance.com/)」, navigate to 「Integration」 - 「DataKit」 - 「Linux」, and click 「Copy Icon」 to copy the installation command.

![image](../images/spring-native/7.png)

Log in to the Linux server and execute the copied command.

![image](../images/spring-native/8.png)

#### 6.2 Enable Collector

Enable RUM by allowing remote access to DataKit's port 9529. Edit the following file:

```bash
/usr/local/datakit/conf.d/datakit.conf
```

Change the `listen` value to `0.0.0.0:9529`

![image](../images/spring-native/9.png)

Enable the ddtrace collector.

```shell
cd /usr/local/datakit/conf.d/ddtrace
cp ddtrace.conf.sample ddtrace.conf
```

![image](../images/spring-native/10.png)

#### 6.3 Restart DataKit

```shell
systemctl restart datakit
```

#### 6.4 Start the Application

```shell
cd /usr/local/df-demo/springboot-native-demo/target
java -DspringAot=true -javaagent:/usr/local/datakit/data/dd-java-agent.jar -Ddd.service.name=spring-native-demo -Ddd.env=dev -Ddd.agent.port=9529 -jar springboot-native-demo-1.0-SNAPSHOT-exec.jar
```

![image](../images/spring-native/11.png)

#### 6.5 Trace Reporting

Access the application's interface `curl localhost:8090/ping` to report trace data.

![image](../images/spring-native/12.png)

Log in to 「[Guance](https://console.guance.com/)」 - 「APM」, and you can see the `spring-native-demo` service.

![image](../images/spring-native/13.png)

In the 「Trace」 view, you can check the trace details, flame graphs, etc.

![image](../images/spring-native/14.png)

![image](../images/spring-native/15.png)