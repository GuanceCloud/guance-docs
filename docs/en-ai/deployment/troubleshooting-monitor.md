# Monitor Troubleshooting

## Introduction

This article will introduce how to troubleshoot common monitor issues:

- The monitor does not generate events
- The monitor has events, but no notification messages are sent


## Prerequisites

- Requires account permissions to create monitors in Guance
- Requires backend management permissions for Guance

## Troubleshooting Steps

### Step One: Create a Test Monitor

- Log in to the Guance console
- Select "Monitoring" - "Create New Monitor" - "Threshold Detection"

- Detection Metrics:

  ```shell
  M::`cpu`:(COUNT(`usage_guest`)) BY `host`
  ```

- Trigger Condition: Critical Result > 0

- Event Title: test

- Event Content: test

- Alert Strategy: Choose the strategy you have set up

- Save

  ![](img/faq-cron-demo.png)

  

### Step Two: Obtain the Automatic Trigger Configuration ID

- Log in to the Guance console and select "Monitoring" - open browser debugging mode

  ![](img/faq-get-cron-id.png)

- Click on the monitor name link

  ![](img/faq-get-cron-id-2.png)

- Obtain the automatic trigger configuration ID

  ![](img/faq-get-cron-id-3.png)

### Step Three: Log in to the Func Platform to Query Issues

- Launcher to get the Func login URL
  ![](img/faq-cron-4.png)

  ![](img/faq-cron-5.png)

- Log in to your Func platform

  ![](img/faq-func.png)

- "Management" - "Automatic Trigger Configurations" - "Show All" - "Enter the ID from Step Two" - "Confirm Search" - "Recent Executions"

  ![](img/faq-get-info.png)

- You can view detailed error information through "Recent Executions"

  ![](img/faq-get-error.png)

### Step Four: Check Alert Notification Logs for Troubleshooting

???+ warning "Note"
     It is recommended to execute `kubectl rollout restart -n middleware deploy message-desk-worker message-desk`, then proceed with testing and troubleshooting.

The `message-desk-worker` service is the alert notification module of Guance, responsible for sending notifications via DingTalk bots, email, Feishu bots, etc.

- namespace: middleware
- deployment: message-desk-worker
- log path: /logdata/bussiness.log

![](img/faq-message-desk-log.png)