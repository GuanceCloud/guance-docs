# GitLab-CI Observability Best Practices
--- 
## GitLab

**GitLab** is developed by GitLabInc. and is licensed under the [MIT License](https://baike.baidu.com/item/MIT%E8%AE%B8%E5%8F%AF%E8%AF%81). It is a web-based Git repository management tool that includes wiki and issue tracking features. GitLab uses [Git](https://baike.baidu.com/item/Git) as its code management tool and is built as a web service on top of it.

## CI/CD 
**CI/CD** stands for Continuous Integration (CI), Continuous Delivery (CD), and Continuous Deployment (CD).<br />**Continuous Integration** focuses on integrating the work of various developers into a single code repository multiple times a day, with the main goal of detecting integration issues early and fostering better team collaboration.<br />**Continuous Delivery** aims to minimize friction in the deployment or release process. Typically, this involves automating each step of the build and deployment process to ensure safe code releases at any time (ideally).<br />**Continuous Deployment** represents a higher level of automation where significant changes to the code trigger automatic builds/deployments.<br />Some popular CI/CD tools:

> 1. Jenkins
>
> 1. GitLab CI
> 1. Travis CI
> 1. GoCD


## GitLab CI

GitLab CI/CD (hereinafter referred to as GitLab CI) is a CI/CD system based on GitLab. Although it is a relatively new player in the CI/CD field, it has already taken a leading position in Forrester Wave's continuous integration tools. Developers can configure CI/CD workflows using `.gitlab-ci.yml` files in their projects. After commits, the system can automatically or manually execute tasks to complete CI/CD operations. Its configuration is simple, and the CI Runner is written in Go, packaged into a single file, making it easy to run on platforms like bare metal + SSH, Docker, or Kubernetes. I recommend Docker because it is easy to set up.

## Guance

[Guance](https://guance.com/) is a cloud-native observability platform. The platform includes infrastructure, logs, metrics, events, APM, RUM, dial testing, security checks, and more. It provides full-stack data analysis and insights for Logging, Metrics, and Tracing data. It supports comprehensive coverage of H5, iOS, Android, and mini-programs, offering detailed user behavior tracking and real experience monitoring. It provides page performance, resource calls, error alerts, business visits, and other data and analysis views. Linked with tracing, it helps you gain real-time insights into application performance and the actual needs behind each request. Flexible layout options, rich chart choices, and drag-and-drop interactions make it easy to build your own dashboard. Unified data query methods support configuring various types of data, making it easy to use.
## DataKit

DataKit is an open-source collection tool from Guance, available at: [https://github.com/DataFlux-cn/datakit](https://github.com/DataFlux-cn/datakit)

## Background Introduction
With the rise of microservices, enterprises are transitioning from monolithic architectures to microservice architectures. Microservices feature numerous modules, which can complicate deployment. While CI/CD tools excel at integration, delivery, and deployment, they often struggle with statistical analysis during the deployment process. Using Guance's powerful observability and custom view capabilities can help you effectively monitor and analyze issues that arise during continuous deployment.
## Architecture Flow

![image.png](../images/gitlab-ci.png)

> 1. Developers commit & push code
>
> 1. GitLabRunner registers with GitLab
> 1. GitLab triggers execution of GitLab-CI
> 1. After GitLab-CI completes, it triggers a webhook to send data to DataKit
> 1. DataKit tags and pushes data to the Guance platform

## Prerequisites

- <[Install DataKit](/datakit/datakit-install)>
- DataKit version >=1.2.13

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
Parameter explanations<br />enable_collect: false # Disable metric collection<br />prometheus_url ： Metric collection URL<br />enable_ci_visibility： true Enable gitlab-ci

#### Restart DataKit

```toml
datakit --restart
```
### GitLab Installation and Configuration
Ignore if already installed

#### Install GitLab via Docker
> docker run --name=gitlab -d -p 8899:8899 -p 2443:443 --restart always \ --volume /data/midsoftware/gitlab/config:/etc/gitlab \ --volume /data/midsoftware/gitlab/logs:/var/log/gitlab \ --volume /data/midsoftware/gitlab/data:/var/opt/gitlab  docker.io/gitlab/gitlab-ce

Port descriptions

| Port | Description |
| --- | --- |
| 8899 | GitLab UI port |
| 2443 | GitLab SSL port |


#### Modify configuration file: gitlab.rb

```
# Access URL
external_url 'http://192.168.91.11:8899'

# Set timeout, default 10 (seconds)
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

#### Check GitLab Initial Password

```shell
[root@middle config]# docker exec -it gitlab cat /etc/gitlab/initial_root_password |grep Password
#          2. Password hasn't been changed manually, either via UI or via command line.
Password: yBY9toQ0SJ8fxh3mndHPzfWclVUDZ/J8e8O4bDsal2E=
```

Account root, log in via browser at http://ip:8899 and change the password.

![2022-01-14-12-02-04-image.png](../images/gitlab-ci-2.png)

#### Create the First Project
menu -> Projects-> Your Projects -> New Project -> Select Create Blank Project. Fill in the project name

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

### Register GitLab-Runner Authorization Token
GitLab Runner does not support global configuration, so the token must be found within the project. Navigate to the project -> settings -> runners, copy the token, which will be used during registration.

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

Parameter descriptions

| Parameter Name | Value | Description |
| --- | --- | --- |
| executor | docker | Can use others or omit this parameter; choose Docker if deploying to a Docker environment |
| docker-image | alpine:latest | Docker image version, used with executor |
| url | [http://192.168.91.11:8899](http://192.168.91.11:8899) | GitLab access URL |
| registration-token | token | GitLab admin token |
| description | gitlab-runner | Description information |
| tag-list | docker,localMachine | Tags to select corresponding executor |

For more parameters, refer to: [https://docs.gitlab.com/runner/configuration/advanced-configuration.html](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)

### Configure GitLab Webhook
Navigate to the created project, select Settings -> Webhooks, fill in the URL, check pipeline events, and save.

![image.png](../images/gitlab-ci-5.png)

Explanation:

> URL: http://<datakit address>/v1/gitlab
>
> Enable Job events
>
> Enable Pipeline events


You can also click Test -> Select Pipeline events, which will trigger a pipeline event and push data to the configured webhook URL. Check the status to verify if the process works correctly.

![image.png](../images/gitlab-ci-6.png)

### Write .gitlab-ci.yml
Navigate to the created project, select CI/CD -> Editor

![image.png](../images/gitlab-ci-7.png)

Fill in the script content as follows:
```yaml
# Set the execution image
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
Click Save, which will automatically trigger CI/CD. After triggering, the process will be pushed to the previously configured webhook URL through the webhook.
### View Webhook Push Records
![image.png](../images/gitlab-ci-8.png)

Status 200 indicates successful push

## Guance
After the pipeline pushes successfully, you can observe the overall execution status of the pipeline via the Guance platform using dashboards and explorers.
### CI Explorer
View `gitlab_pipeline` and `gitlab_job` details through the menu `CI` explorer.

gitlab_pipeline：

![image.png](../images/gitlab-ci-9.png)

gitlab_job

![image.png](../images/gitlab-ci-10.png)

Clicking on details allows you to view flame graphs and job lists<br />Flame graph<br />![image.png](../images/gitlab-ci-11.png)
### CI Summary
The CI summary provides an overview of GitLab-CI pipeline and job execution, such as pipeline success rate, execution time, job success rate, execution time, etc.<br />![image.png](../images/gitlab-ci-12.png)