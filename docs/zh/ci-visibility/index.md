---
icon: zy/ci-visibility
---
# CI 可视化
---

{{{ custom_key.brand_name }}}支持为 Gitlab/Jenkins 内置的 CI 的过程和结果进行可视化，您可以通过{{{ custom_key.brand_name }}}的 CI 可视化功能直接查看在 Gitlab/Jenkins 的 CI 结果。CI 的过程是持续集成，开发人员在 push 代码的时候，若碰到问题，可以在{{{ custom_key.brand_name }}}查看所有 CI 过程的成功率、失败原因、具体失败环节，帮助您提供代码更新保障。

## 名词解释

- CI/CD：是持续集成（Continuous Integration : CI）、持续交付（Continuous Delivery: CD）、持续部署（Continuous Deployment CD）的简称，是一种通过在应用开发阶段引入自动化来频繁向客户交付应用的方法，主要针对在集成新代码时所引发的问题；
- 持续集成：让开发者可以在代码开发过程中，更方便的将代码集成到主分支，自动构建应用进行自动化测试，来验证更新的代码，主要目的是尽早发现集成错误，使团队更加紧密结合，更好地协作；
- 持续交付：在持续集成的基础上，可随时将代码部署到生产环境的代码库；
- 持续部署：在持续交付的基础上，自动将应用发布到生产环境；
- Pipeline：CI/CD 过程的管道，从集成测试到交付部署，贯穿于应用的整个生命周期；
- Job：Pipeline 整个过程中的所有任务；
- Gitlab：基于 Ruby on Rails 开发的开源项目，使用 Git 作为代码管理工具，可通过 Web 界面进行访问，支持代码的开发、部署、维护；
- Jenkins：基于 Java 开发的开源项目，用于持续集成的工具，支持代码的自动构建、测试、集成部署。

## 主要功能

- CI 过程可视化：从 pipeline 和 job 来可视化查看所有 CI 的过程；
- CI 结果统计分析：从 pipeline 和 job 来统计所有 CI 的成功率、失败率等。

