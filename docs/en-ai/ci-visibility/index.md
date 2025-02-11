---
icon: zy/ci-visibility
---
# CI Visualization

---

Guance supports visualizing the process and results of Gitlab/Jenkins built-in CI, allowing you to directly view the CI results in Gitlab/Jenkins through Guance's CI visualization feature. The CI process is continuous integration, where developers can check the success rate, failure reasons, and specific failure stages of all CI processes when they encounter issues while pushing code, providing assurance for code updates.

## Terminology

- CI/CD: Short for Continuous Integration (CI), Continuous Delivery (CD), and Continuous Deployment (CD). It is a method of frequently delivering applications to customers by introducing automation during the application development phase, mainly addressing issues arising from integrating new code;
- Continuous Integration: Allows developers to more easily integrate code into the main branch during the code development process, automatically building and testing the application to validate updated code. The primary goal is to detect integration errors early, fostering tighter team collaboration and better cooperation;
- Continuous Delivery: On the basis of continuous integration, it refers to the ability to deploy code to the production environment codebase at any time;
- Continuous Deployment: On the basis of continuous delivery, it automatically publishes the application to the production environment;
- Pipeline: The pipeline of the CI/CD process, from integration testing to delivery deployment, spanning the entire lifecycle of the application;
- Job: All tasks within the entire Pipeline process;
- Gitlab: An open-source project developed using Ruby on Rails, utilizing Git as the code management tool. It can be accessed via a web interface and supports code development, deployment, and maintenance;
- Jenkins: An open-source project developed using Java, used as a continuous integration tool that supports automatic code builds, testing, and integration deployments.

## Key Features

- CI Process Visualization: Visualize all CI processes from pipelines and jobs;
- CI Result Analysis: Analyze CI success rates, failure rates, etc., from pipelines and jobs.