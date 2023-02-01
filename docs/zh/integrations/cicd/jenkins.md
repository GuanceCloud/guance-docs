---
icon: fontawesome/brands/jenkins
---
# Jenkins

---

## 视图预览

Jenkins 性能指标展示，包括项目数量、构建数量、作业数量、空闲构建数量、正在构建数量、CPU 使用率、内存使用量等。

![image](../imgs/input-jenkins-01.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- Jenkins 所在服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- Jenkins 已安装

```
ps -ef | grep jenkins
```

![image](../imgs/input-jenkins-02.png)

## 安装部署

说明：示例 Jenkins 版本为 jenkins-2.289.1(CentOS)，各个不同版本指标可能存在差异。

### 指标采集 (必选)

1、 安装 Metrics Plugin

登录 Jenkins，点击「系统管理」 -「插件管理」

![image](../imgs/input-jenkins-03.png)

点击「插件管理」 - 「可选插件」，输入 metric，点击 「Install without restart」

![image](../imgs/input-jenkins-04.png)

2、 生成 **Access keys**

点击「系统管理」 - 「系统配置」

![image](../imgs/input-jenkins-05.png)

找到「Metrics」，点击「Generate...」 - 「新增」，记录下 `Access keys`

![image](../imgs/input-jenkins-06.png)

3、 开启 Jenkins 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/jenkins
cp jenkins.conf.sample jenkins.conf
```

4、 修改 `jenkins.conf` 配置文件

```
vi jenkins.conf
```

参数说明

- url：jenkins 的 url
- key：步骤 2 中生成的 key

```
[[inputs.jenkins]]
  ## The Jenkins URL in the format "schema://host:port",required
  url = "http://172.16.10.238:9290"

  ## Metric Access Key ,generate in your-jenkins-host:/configure,required
  key = "zItDYv9ClhSqM3sdfeeYcO1juiIeZEuh02bno_PyzphcGQWsUOsiafcyLs5Omyso2"
```

5、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
systemctl restart datakit
```

6、 指标预览

![image](../imgs/input-jenkins-07.png)

### Jenkins CI Visibility (非必选)

Jenkins 采集器可以通过接收 Jenkins datadog plugin 发出的 CI Event 实现 CI 可视化。

1、 `jenkins.conf` 文件配置监听端口，默认已配置了`“:9539”` ，也可以使用其它未被占用的端口。

![image](../imgs/input-jenkins-08.png)

2、 登录 Jenkins，「系统管理」 - 「插件管理」 - 「可选插件」，输入 “Datadog”，在搜索结果中选择 “Datadog”，点击下方的「Install without restart」。

![image](../imgs/input-jenkins-09.png)

3、 进入 Jenkins 的「系统管理」 - 「系统配置」

- 在 「Datadog Plugin」 输入项中，选中「Use the Datadog Agent to report to Datadog ...」
- 「Agent Host」 填 DataKit 的地址
- 「DogStatsD Port」和 「Traces Collection Port」 填 jenkins.conf 配置的监听端口，默认是 `9539`
- 选中「Enable CI Visibility」，点击「保存」

![image](../imgs/input-jenkins-10.png)

![image](../imgs/input-jenkins-11.png)

4、 CI 预览

登录 Jenkins 执行**流水线**后，登录**观测云**，通过「CI」 - 「查看器」，选择 `jenkins_pipeline` 和 `jenkins_job` 查看 流水线执行情况。

![image](../imgs/input-jenkins-12.png)

![image](../imgs/input-jenkins-13.png)

### 日志采集 (非必选)

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- Pipeline：日志切割文件(内置)，实际文件路径 `/usr/local/datakit/pipeline/jenkins.p`
- 相关文档 <[ 文本数据处理（Pipeline）](../../datakit/pipeline.md)>

```
vi /usr/local/datakit/conf.d/jenkins/jenkins.conf
```

```
  [inputs.jenkins.log]
    files = ["/var/log/jenkins/jenkins.log"]
  # grok pipeline script path
    pipeline = "jenkins.p"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

日志预览

![image](../imgs/input-jenkins-14.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Jenkins 指标都会带有 `app = "oa"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
  [inputs.jenkins.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Jenkins 监控视图>

## 检测库

暂无

## [指标详解](../../../datakit/jenkins/#measurements)

## 最佳实践

<[Jenkins 可观测最佳实践](../../best-practices/monitoring/jenkins.md)>

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>
