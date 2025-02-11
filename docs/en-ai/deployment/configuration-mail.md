# Configure Email Service

## Introduction

This article will demonstrate how to configure the email alert service in Guance.

## Prerequisites

- Guance has been fully initialized.
- You have the information for your email service:
    - `host`
    - `port`
    - `useTLS`
    - `user`
    - `password`
    - `useSSL`
    - `usePlainAuth`

## Configuration Steps

### Step One: Test Email Service Information

Execute the following Python script within the message-desk-worker pod under middleware, modify the host, port, sender, password, use_tls, recipient, useSSL, usePlainAuth parameters, and run it to test whether the configuration is correct.

```shell
cat <<EOF> test-maile.py
from mailer import Mailer
from mailer import Message

host = 'smtp.example.com'
port = 587
sender = 'your_email@example.com'
password = 'your_email_password'
use_tls = True
recipient = 'recipient@example.com'
use_ssl = False
use_plain_auth = False

message = Message(From=sender, To=recipient)
message.Subject = 'Test email'
message.Body = 'This is a test email'

mailer = Mailer(host=host, port=587, use_tls=use_tls, usr=sender, pwd=password, use_plain_auth=use_plain_auth, use_ssl=use_ssl)

try:
    mailer.send(message)
    print('Email sent successfully.')
except Exception as e:
    print('Error:', e)
EOF
```

Run the Python script:

```shell
  python test-maile.py
```

Check the execution result:

![](img/faq-mail-4.png)

### Step Two: Modify Service Configuration

???+ warning "Note"
    Please modify the configuration according to your actual email service information.

1. Log in to Launcher, click on the settings in the top right corner.
2. Select "Modify Service Configuration"

  ![](img/faq-mail.png)

=== "Version 1.90.170 or later"

    - Namespace: func2
    - Modify the configuration of the following services:
      - func2Config (Function Computation, Function Computation Inner, Task Queue Scheduler, worker 0, worker 1, worker 2, worker 3, worker 4, worker 5, worker 6, worker 7, worker 8, worker 9)
    - Sample configuration file:

    ```yaml
    # Email SMTP, please fill in the configuration values based on your email service information
    CUSTOM_MESSAGE_DESK_MAIL_HOST: 'smtpdm.aliyun.com'
    CUSTOM_MESSAGE_DESK_MAIL_PORT: 465
    CUSTOM_MESSAGE_DESK_MAIL_USE_SSL: true
    CUSTOM_MESSAGE_DESK_MAIL_USE_TLS: false
    CUSTOM_MESSAGE_DESK_MAIL_USE_PLAIN_AUTH: true
    CUSTOM_MESSAGE_DESK_MAIL_FROM: 'xxxxx <noreply@xxxxx.cn>'
    CUSTOM_MESSAGE_DESK_MAIL_USER: 'xxxxx@xxxxx.cn'
    CUSTOM_MESSAGE_DESK_MAIL_PASSWORD: 'xxxxx'
    ```

    ![](img/mail-config-func2.png)

    - Save the configuration and restart

      ![](img/faq-mail-6.png)

=== "Before version 1.90.170"

    - Namespace: middleware
    - Modify the configuration of the following services:
        - messageDeskWorker (Message Center Worker)
    - Modify configuration
      ![](img/faq-mail-2.png)


    - Save the configuration and restart

      ![](img/faq-mail-6.png)

### Step Three: Testing and Troubleshooting

You can create an incorrect alert configuration to manually trigger the alert settings.

![](img/faq-mail-3.png)

Refer to [Monitor Troubleshooting](troubleshooting-monitor.md) for troubleshooting issues.