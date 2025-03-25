# Gitlab-CI Observability Best Practices
--- 
## GitLab

**GitLab** is developed by GitLabInc., and uses the [MIT License](https://en.wikipedia.org/wiki/MIT_License) as a web-based [Git](https://en.wikipedia.org/wiki/Git) [repository](https://en.wikipedia.org/wiki/Repository_(version_control)) management tool that also includes [wiki](https://en.wikipedia.org/wiki/Wiki) and issue tracking functionality. It uses [Git](https://en.wikipedia.org/wiki/Git) for code management, and builds a web service on top of it.

## CI/CD 
**CI/CD** stands for Continuous Integration (CI), Continuous Delivery (CD), and Continuous Deployment (CD).<br />**Continuous Integration** focuses on combining the work of different developers into one code repository. This is typically done several times a day with the main purpose being to identify integration errors early, allowing the team to stay closely connected and collaborate better.<br />**Continuous Delivery** aims to minimize the inherent friction in deployment or release processes. Its implementation usually automates each step of building and deploying so that code can be released safely at any time (ideally).<br />**Continuous Deployment** represents a higher level of automation where every significant change to the code automatically triggers a build/deployment process.<br />Some popular CI/CD tools:

> 1. Jenkins
>
> 1. Gitlab CI
> 1. Travis CI
> 1. GoCD


## GitLab CI

GitLab CI/CD (hereafter referred to as GitLab CI) is a CI/CD system based on GitLab. Though it is a newcomer in the CI/CD field, it has already taken a leading position in Forrester Wave's continuous integration tools. Developers can configure CI/CD workflows within their projects using `.gitlab-ci.yml`. After commits, the system can automatically or manually execute tasks, completing CI/CD operations. Moreover, its configuration is very simple. The CI Runner is written in Go language and packaged into a single file, so all you need is a Runner program and an execution platform for running jobs (such as bare metal + SSH, Docker, or Kubernetes, I recommend Docker because it’s quite easy to set up) to run a complete CI/CD system.

## <<< custom_key.brand_name >>>

“[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/)” is a cloud-era system observability platform. The platform includes infrastructure, logs, metrics, events, application performance monitoring, user access monitoring, cloud synthetic testing, system-level security checks, and other Features modules. It provides full-chain data analysis and insight capabilities for Logging, Metrics, Tracing data generated from these functionalities. It comprehensively covers H5, iOS, Android, Mini Programs, etc., supporting complete tracking of user access behaviors and real experiences, offering data and analytical views such as page performance, resource invocation, error alerts, and business visits. Linked with APM, it helps you gain real-time insights into application performance and the actual needs behind each request. Flexible scene layouts, rich chart selections, and drag-and-drop interaction experiences make it easy to build your "own" dashboard. Unified data querying methods support configuring various types of data, making it simple and easy to get started.
## DataKit

DataKit is an open-source collection tool provided by <<< custom_key.brand_name >>>. Open-source address: [https://github.com/DataFlux-cn/datakit](https://github.com/DataFlux-cn/datakit)

## Background Introduction
As microservices become increasingly popular, enterprises start transitioning monolithic service architectures to microservice architectures. One feature of microservices is that there are numerous engineering modules, which makes deployment relatively complicated. Although CI/CD tools can facilitate integration, delivery, and deployment well, it's difficult to statistically analyze issues arising during deployment. By leveraging <<< custom_key.brand_name >>>'s powerful observability and custom view capabilities, it can help you effectively monitor and analyze problems that occur during continuous software deployment.
## Architecture Process

![image.png](../images/gitlab-ci.png)

> 1. Developers commit & push code
>
> 1. GitlabRunner registers with gitlab
> 1. Gitlab trigger executes Gitlab-CI
> 1. After Gitlab-CI completes, it triggers a webhook to send data to DataKit
> 1. DataKit tags and pushes the data to the <<< custom_key.brand_name >>> platform

## Prerequisites

- <[Install DataKit](/datakit/datakit-install)>
- DataKit version >= 1.2.13

### Enable gitlab-ci in DataKit

#### Edit gitlab.conf
> cd conf.d/gitlab
> cp gitlab.conf.sample gitlab.conf

Full content of gitlab.conf
```toml
[[inputs.gitlab]]
## Set true if you need to collect metric from url below
enable_collect = false

## param type: string - default: http://127.0.0.1:80/-/metrics
prometheus_url = "http://127.0.0.1:80/-/metrics"

## param type: string - optional: time units are "ms", "s", "m", "h" - default: 10s
interval = "10s"

## DataKit can listen to gitlab ci data at /v1/gitlab when enabled
enable_ci_visibility = true

## Extra tags for gitlab-ci data.
## These tags will not overwrite existing tags.
[inputs.gitlab.ci_extra_tags]
# some_tag = "some_value"
# more_tag = "some_other_value"

## Extra tags for gitlab metrics
[inputs.gitlab.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
```
Parameter descriptions<br />enable_collect: false # Disable metric collection<br />prometheus_url: Metric collection address<br />enable_ci_visibility: true Enable gitlab-ci

#### Restart DataKit

```toml
datakit --restart
```
### Gitlab Installation and Configuration
If already installed, please ignore

#### Install Gitlab via Docker
> docker run --name=gitlab -d -p 8899:8899 -p 2443:443 --restart always \ --volume /data/midsoftware/gitlab/config:/etc/gitlab \ --volume /data/midsoftware/gitlab/logs:/var/log/gitlab \ --volume /data/midsoftware/gitlab/data:/var/opt/gitlab  docker.io/gitlab/gitlab-ce

Port description

| Port | Description |
| --- | --- |
| 8899 | Gitlab-ui port |
| 2443 | Gitlab SSL port |


#### Modify configuration file: gitlab.rb

```
# Access URL
external_url 'http://192.168.91.11:8899'

# Set timeout time, default 10 (unit s)
gitlab_rails['webhook_timeout'] = 60
```

#### Restart Gitlab

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

Account root, log in via browser at http://ip:8899 and change password.

![2022-01-14-12-02-04-image.png](../images/gitlab-ci-2.png)

#### Create the First Project
Menu -> Projects -> Your Projects -> New Project -> Select Create Blank Project. Fill in the project name.

![image.png](../images/gitlab-ci-3.png)

### Gitlab-Runner Installation and Configuration
If already installed, please ignore
#### Install GitLab-Runner via Docker
```shell
docker run -d --name gitlab-runner --restart always \
    -v /data/midsoftware/gitlab-runner/config:/etc/gitlab-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gitlab/gitlab-runner:latest
```

### GitLab-Runner Authorization Key
GitLab Runner does not currently support global configuration, so the key for the Runner must be found within the project. Navigate to the project just created -> settings -> runners, copy the key, which will be used in the next step for Runner registration.

![image.png](../images/gitlab-ci-4.png)

### Register Gitlab-Runner to Gitlab

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
| executor | docker | Other options are available, this parameter can also be omitted; if deploying to a Docker environment, it is recommended to choose Docker |
| docker-image | alpine:latest | Docker image version, used in conjunction with the executor |
| url | [http://192.168.91.11:8899](http://192.168.91.11:8899) | Gitlab access URL |
| registration-token | token | Gitlab admin token |
| description | gitlab-runner | Description information |
| tag-list | docker,localMachine | Tags can be selected based on corresponding executors |

More parameters reference: [https://docs.gitlab.com/runner/configuration/advanced-configuration.html](https://docs.gitlab.com/runner/configuration/advanced-configuration.html)

### Configure GitLab Webhook
Navigate to the project just created, select Settings -> Webhooks, fill in the URL, check pipeline events, and save.

![image.png](../images/gitlab-ci-5.png)

Explanation:

> url: http://<datakit address>/v1/gitlab
>
> Enable Job events
>
> Enable Pipeline events


You can also click Test -> Select Pipeline Events, which will trigger a pipeline event, pushing data to the webhook address configured earlier. Check the status to ensure the process works correctly.

![image.png](../images/gitlab-ci-6.png)

### Write .gitlab-ci.yml
Navigate to the project just created, select CI/CD -> Editor

![image.png](../images/gitlab-ci-7.png)

Fill in the script content as follows:
```git
# Set execution image
image: busybox:latest

# Entire pipeline has two stages
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
Click Save, which automatically triggers CI/CD. Once triggered, it sends the process through the webhook to the previously configured webhook address.
### View Webhook Push Records
![image.png](../images/gitlab-ci-8.png)

Status 200 indicates successful push

## <<< custom_key.brand_name >>>
After successfully pushing the pipeline, we can use <<< custom_key.brand_name >>> platform in a visual way to observe the overall execution of the pipeline through dashboards and Explorers.
### CI Explorer
View `gitlab_pipeline` and `gitlab_job` details through the `CI` Explorer menu.

gitlab_pipeline:

![image.png](../images/gitlab-ci-9.png)

gitlab_job

![image.png](../images/gitlab-ci-10.png)

Clicking on details allows you to view flame graphs and job lists.<br />Flame graph<br />![image.png](../images/gitlab-ci-11.png)
### CI Overview
The CI Overview shows the execution status of gitlab-ci pipelines and jobs, such as the success rate and execution time of pipelines, and the success rate and execution time of jobs.<br />![image.png](../images/gitlab-ci-12.png)