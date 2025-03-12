---
icon: zy/ci-visibility
---
# CI Visualization
---

<<< custom_key.brand_name >>> supports visualizing the process and results of Gitlab/Jenkins built-in CI. You can directly view the CI results in Gitlab/Jenkins through <<< custom_key.brand_name >>>'s CI visualization feature. The CI process is continuous integration, where developers can check the success rate, failure reasons, and specific failed stages of all CI processes when pushing code, helping to ensure code updates.

## Terminology

- CI/CD: Short for Continuous Integration (CI), Continuous Delivery (CD), and Continuous Deployment (CD). It is a method of frequently delivering applications to customers by introducing automation during the application development phase, primarily addressing issues that arise when integrating new code;
- Continuous Integration: Allows developers to more easily integrate code into the main branch during the development process, automatically building and testing the application to validate updated code. The main goal is to detect integration errors early, fostering tighter team collaboration and better cooperation;
- Continuous Delivery: Building on continuous integration, it ensures that code can be deployed to the production environment's code repository at any time;
- Continuous Deployment: Building on continuous delivery, it automatically releases the application to the production environment;
- Pipeline: The pipeline of the CI/CD process, from integration testing to delivery deployment, spanning the entire lifecycle of the application;
- Job: All tasks throughout the Pipeline process;
- Gitlab: An open-source project developed using Ruby on Rails, using Git as the code management tool. It can be accessed via a web interface and supports code development, deployment, and maintenance;
- Jenkins: An open-source project developed using Java, used as a continuous integration tool, supporting automatic code building, testing, and integration deployment.

## Key Features

- CI Process Visualization: Visualize all CI processes from pipelines and jobs;
- CI Result Analysis: Statistically analyze the success rate, failure rate, etc., of all CI processes from pipelines and jobs.