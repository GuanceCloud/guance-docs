# GitLab-CI Observability Best Practices
--- 
## GitLab

**GitLab** is developed by GitLabInc. and uses the [MIT License](https://en.wikipedia.org/wiki/MIT_License). It is a web-based [Git](https://git-scm.com/) repository management tool with [wiki](https://en.wikipedia.org/wiki/Wiki) and issue tracking features. GitLab uses [Git](https://git-scm.com/) as the code management tool and builds a web service on top of it.

## CI/CD 
**CI/CD** stands for Continuous Integration (CI), Continuous Delivery (CD), and Continuous Deployment (CD).<br />**Continuous Integration** focuses on integrating the work of various developers into a single code repository. Typically, this happens several times a day, with the main goal of detecting integration issues early, fostering tighter team collaboration.<br />**Continuous Delivery** aims to minimize friction inherent in deployment or release processes. Its implementation often automates each step of the build deployment process so that code releases can be safely completed at any time (ideally).<br />**Continuous Deployment** represents a higher level of automation where builds/deployments are automatically triggered whenever significant changes are made to the code.<br />Some popular CI/CD tools:

> 1. Jenkins
>
> 1. GitLab CI
> 1. Travis CI
> 1. GoCD


## GitLab CI

GitLab CI/CD (hereinafter referred to as GitLab CI) is a CI/CD system based on GitLab. Although it is a newcomer in the CI/CD field, it has taken the lead in Forrester Wave's continuous integration tools. Developers can configure CI/CD workflows using `.gitlab-ci.yml` files within their projects. After commits, the system can automatically or manually execute tasks to complete CI/CD operations. Moreover, its configuration is straightforward, with CI Runners written in Go and packaged as a single file. Therefore, only a Runner program and an execution platform (such as bare metal + SSH, Docker, or Kubernetes, with Docker recommended due to its ease of setup) are needed to run a complete CI/CD system.

## <<< custom_key.brand_name >>>

“[<<< custom_key.brand_name >>>](https://guance.com/)” is a cloud-era observability platform. The platform includes infrastructure, logs, metrics, events, APM, RUM, synthetic tests, and system-level security checks among other feature modules. It provides comprehensive data analysis and insights for Logging, Metrics, and Tracing data. It covers H5, iOS, Android, and mini-programs, supporting the complete tracing of user access behavior and real experiences. It offers data and analysis views such as page performance, resource calls, error alerts, and business visits. Linked with trace analysis, it helps you gain real-time insights into application performance and the true needs behind every request. Flexible layout options, rich chart selections, and drag-and-drop interaction make it easy to build your own dashboard. A unified data query method supports configuring various types of data, making it simple and easy to use.

## DataKit

DataKit is an open-source collection tool provided by <<< custom_key.brand_name >>>. The open-source address is: [https://github.com/DataFlux-cn/datakit](https://github.com/DataFlux-cn/datakit)

## Background Introduction
With the increasing popularity of microservices, enterprises are transitioning from monolithic service architectures to microservice architectures. Microservices have many engineering modules and can be relatively complex to deploy. While CI/CD tools excel at integrating, delivering, and deploying, they often struggle with statistical analysis during the deployment process. Using <<< custom_key.brand_name >>>'s powerful observability and customizable view capabilities, you can effectively monitor and analyze issues that arise during continuous deployment.

## Architecture Process

![image.png](../images/gitlab-ci.png)

> 1. Developers commit & push code 
>
> 1. GitlabRunner registers with GitLab 
> 1. GitLab triggers Gitlab-CI execution 
> 1. After Gitlab-CI completes, it triggers a webhook to send data to DataKit
> 1. DataKit tags and pushes the data to the <<< custom_key.brand_name >>> platform

## Prerequisites

- <[Install DataKit](/datakit/datakit-install)>
- DataKit version >= 1.2.13

### Enabling gitlab-ci in DataKit

#### Edit gitlab.conf
> cd conf.d/gitlab
> cp gitlab.conf.sample gitlab.conf

Full content of gitlab.conf:
```toml
[[inputs.gitlab]]
## set true if you need to collect metric from url below
enable_collect = false

## param type: string - default: http://127.0.0.1:80/-/metrics
prometheus_url = "http://127.0.0.1:80/-/metrics"

## param type: string - optional: time units are "ms", "s", "m", "h" - default: 10s
interval = "10s"

## datakit can listen to gitlab ci data at /v1/gitlab when enabled
enable_ci_visibility = true

## extra tags for gitlab-ci data.
## these tags will not overwrite existing tags.
[inputs.gitlab.ci_extra_tags]
# some_tag = "some_value"
# more_tag = "some_other_value"

## extra tags for gitlab metrics
[inputs.gitlab.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
```
Parameter Explanation<br />enable_collect: false # Disable metric collection<br />prometheus_url: Metric collection URL<br />enable_ci_visibility: true Enable gitlab-ci

#### Restart DataKit

```toml
datakit --restart
```

### GitLab Installation and Configuration
Ignore if already installed

#### Install GitLab via Docker
> docker run --name=gitlab -d -p 8899:8899 -p 2443:443 --restart always \ --volume /data/midsoftware/gitlab/config:/etc/gitlab \ --volume /data/midsoftware/gitlab/logs:/var/log/gitlab \ --volume /data/midsoftware/gitlab/data:/var/opt/gitlab  docker.io/gitlab/gitlab-ce

Port Description

| Port | Description |
| --- | --- |
| 8899 | GitLab UI port |
| 2443 | GitLab SSL port |

#### Modify Configuration File: gitlab.rb

```
# Access URL
external_url 'http://192.168.91.11:8899'

# Set timeout, default 10 (unit: seconds)
gitlab_rails['webhook_timeout'] = 60
```

#### Restart GitLab

```shell
docker restart gitlab
```

#### Check GitLab Version Number

```shell
[root@middle config]# docker exec -it gitlab cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
14.6.2
```

#### Check Initial GitLab Password

```shell
[root@middle config]# docker exec -it gitlab cat /etc/gitlab/initial_root_password |grep Password
#          2. Password hasn't been changed manually, either via UI or via command line.
Password: yBY9toQ0SJ8fxh3mndHPzfWclVUDZ/J8e8O4bDsal2E=
```

Account: root, log in to http://ip:8899 via browser and change the password.

![2022-01-14-12-02-04-image.png](../images/gitlab-ci-2.png)

#### Create the First Project
menu -> Projects -> Your Projects -> New Project -> Select Create Blank Project. Fill in the project name

![image.png](../images/gitlab-ci-3.png)

### GitLab-Runner Installation and Configuration
Ignore if already installed
#### Install GitLab-Runner via Docker
```shell
docker run -d --name gitlab-runner --restart always \
    -v /data/midsoftware/gitlab-runner/config:/etc/gitlab-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gitlab/gitlab-runner:latest
```

### GitLab-Runner Registration Key
GitLab Runner does not support global configuration, so the registration token must be found within the project. Navigate to the recently created project -> settings -> runners, copy the token, which will be used during the next registration step.

![image.png](../images/gitlab-ci-4.png)

### Register GitLab-Runner to GitLab

```shell
docker run --rm -v /data/midsoftware/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "http://192.168.91.11:8899" \
  --registration-token "U6uhCZGPrZ7tGs6aV8rY" \
  --description "gitlab-runner" \
  --tag-list "docker,localMachine" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
```

Parameter Description

| Parameter Name | Value | Description |
| --- | --- | --- |
| executor | docker | Can be other values or omitted; choose docker if deploying to Docker environment |
| docker-image | alpine:latest | Docker image version, used with executor |
| url | [http://192.168.91.11:8899](http://192.168.91.11:8899) | GitLab access URL |
| registration-token | token | GitLab admin token |
| description | gitlab-runner | Description information |
| tag-list | docker,localMachine | Tags to select corresponding executors |

More parameters: [https://docs.gitlab.com/runner/configuration/advanced-configuration.html](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)

### Configure GitLab Webhook
Navigate to the recently created project, select Settings -> Webhooks, fill in the URL, check pipeline events, and save.

![image.png](../images/gitlab-ci-5.png)

Explanation:

> URL: http://<datakit_address>/v1/gitlab
>
> Enable Job events
>
> Enable Pipeline events


You can also click Test -> select Pipeline events, which will trigger a pipeline event and push data to the configured webhook URL. Check the status to ensure the process works correctly.

![image.png](../images/gitlab-ci-6.png)

### Write .gitlab-ci.yml
Navigate to the recently created project, select CI/CD -> Editor

![image.png](../images/gitlab-ci-7.png)

Enter the script content as follows:
```yaml
# Set execution image
image: busybox:latest

# The entire pipeline has two stages
stages:
  - build
  - test

before_script:
  - echo "Before script section"

after_script:
  - echo "After script section"


build_job:
  stage: build
  only:
    - master
  script:
    - echo "Write content to cache"
    - sleep 80s
    # - d ps 

test_job:
  stage: test
  script:
    - echo "Read content from cache"
```
Click Save, which will automatically trigger the CI/CD process and push the results to the configured webhook URL.
### View Webhook Push Records
![image.png](../images/gitlab-ci-8.png)

Status 200 indicates successful push

## <<< custom_key.brand_name >>>
After the pipeline pushes successfully, we can use the <<< custom_key.brand_name >>> platform to visualize and observe the overall pipeline execution through dashboards and explorers.
### CI Explorer
View `gitlab_pipeline` and `gitlab_job` details via the `CI` explorer menu.

gitlab_pipeline:

![image.png](../images/gitlab-ci-9.png)

gitlab_job

![image.png](../images/gitlab-ci-10.png)

Clicking on details allows viewing flame graphs and job lists<br />Flame graph<br />![image.png](../images/gitlab-ci-11.png)
### CI Overview
The CI overview displays the execution status of GitLab-CI pipelines and jobs, including success rates and execution times for both pipelines and jobs.<br />![image.png](../images/gitlab-ci-12.png)