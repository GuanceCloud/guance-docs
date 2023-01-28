# Data Collection
---

## Introduction

Guance supports reporting the process and results of Gitlab/Jenkins built-in CI to Guance for visualization.You can install DataKit, turn on the Gitlab/Jenkins collector, and report the results of the entire CI process (e.g. Build, Test, Deploy) to DataKit, process them through the DataWay data gateway, and then report them to Guance for viewing and analysis.

![](img/17.CI_1.png)



## Preconditions

You need to create an [Guance account](https://auth.guance.com/register?channel=帮助文档) and [install DataKit](../datakit/datakit-install.md) on your host. 

## Data Collection

After the DataKit installation is complete, you can open [Gitlab](../integrations/cicd/gitlab.md) / [Jenkins](../integrations/cicd/jenkins.md) in the DataKit installation directory. It collector and restart DataKit to get CI related data.

## More References

- [Gitlab-CI Observable Best Practices](../best-practices/monitoring/gitlab-ci.md)

- [Jenkins Observable Best Practices](../best-practices/monitoring/jenkins.md)
