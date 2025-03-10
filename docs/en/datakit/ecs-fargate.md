# Integration with AWS ECS Fargate
---

## Prerequisites {#req}

- Task metadata endpoint version 4

## Overview {#intro}

Datakit can be integrated into the AWS ECS Fargate environment, and data collection can be enabled with simple configuration.

The data that can be collected from ECS Fargate includes:

- Container metrics and object data, including basic container information, CPU and memory usage, etc.
- Receiving APM data sent by other containers within the current Task.
- Enabling log streaming to receive container log data.

The ECS Fargate task metadata endpoint (Task metadata Endpoint) can only be used internally within task definitions, so a Datakit container needs to be deployed in each task definition.

The only required configuration is to add an environment variable `ENV_ECS_FARGATE` set to `"on"`, and Datakit will automatically switch to this collection mode.

## Deployment and Configuration {#config}

In most cases, you just need to integrate Datakit as a container in the task definition and specify the necessary task role in the task definition. This can be divided into 3 steps, as follows:

1. Create or modify the [IAM policy](https://docs.aws.amazon.com/zh_cn/IAM/latest/UserGuide/introduction.html){:target="_blank"}, Datakit requires at least the following 3 permissions:

    - `ecs:ListClusters` to list available clusters
    - `ecs:ListContainerInstances` to list instances in the cluster
    - `ecs:DescribeContainerInstances` to describe instances and add metrics about running resources and tasks

1. Add the Datakit container in the task definition. Example configuration items are as follows:

    - Name: `datakit`
    - Image: `pubrepo.guance.com/datakit/datakit:<specified version>`
    - Essential container: `"No"`
    - Port mapping, container port: `9529` (configure as needed, default is 9529)
    - Resource allocation limits: 2vCPU CPU, 4GB memory limit

1. Configure Datakit using environment variables. The necessary environment variables are as follows:

    - `ENV_ECS_FARGATE`: `on`
    - `ENV_DATAWAY`: `https://openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>`
    - `ENV_HTTP_LISTEN`: `0.0.0.0:9529`
    - `ENV_DEFAULT_ENABLED_INPUTS`: `dk,container,ddtrace`

This is an example of a task definition for running Datakit and trace:

```json
{
    "family": "datakit-dev",
    "containerDefinitions": [
        {
            "name": "trace",
            "image": "pubrepo.guance.com/datakit-dev/ddtrace-golang-demo:v1",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "ddtrace-80-tcp",
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "DD_TRACE_AGENT_PORT",
                    "value": "9529"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "readonlyRootFilesystem": false
        },
        {
            "name": "dk",
            "image": "pubrepo.guance.com/datakit/datakit:1.21.0",
            "cpu": 2048,
            "memory": 4096,
            "portMappings": [
                {
                    "name": "dk-9529-tcp",
                    "containerPort": 9529,
                    "hostPort": 9529,
                    "protocol": "tcp"
                }
            ],
            "essential": false,
            "environment": [
                {
                    "name": "ENV_ECS_FARGATE",
                    "value": "on"
                },
                {
                    "name": "ENV_DATAWAY",
                    "value": "https://openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>"
                },
                {
                    "name": "ENV_HTTP_LISTEN",
                    "value": "0.0.0.0:9529"
                },
                {
                    "name": "ENV_DEFAULT_ENABLED_INPUTS",
                    "value": "dk,container,ddtrace"
                }
            ],
            "mountPoints": [],
            "volumesFrom": []
        }
    ],
    "taskRoleArn": "arn:aws-cn:iam::123123123:role/datakit-dev",
    "executionRoleArn": "arn:aws-cn:iam::123123123:role/datakit-dev",
    "networkMode": "awsvpc",
    "requiresCompatibilities": [
        "FARGATE"
    ],
    "cpu": "4096",
    "memory": "8192",
    "runtimePlatform": {
        "cpuArchitecture": "ARM64",
        "operatingSystemFamily": "LINUX"
    }
}
```