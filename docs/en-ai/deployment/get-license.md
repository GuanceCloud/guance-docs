# Apply for a License

The Deployment Plan of Guance provides a simple, accessible, and fully-featured local deployment platform for teachers, students, cloud computing enthusiasts, and other community users. You are welcome to apply and download the trial version for free, set up your own Guance platform, and experience the complete product features.

## Steps

### Register for a Deployment Plan Account

Directly open the registration address for the Deployment Plan ([https://boss.guance.com/index.html#/signup?type=private](https://boss.guance.com/index.html#/signup?type=private)) and register for a Deployment Plan account according to the prompts.

![](img/6.deployment_3.png)

After completing the registration, enter the Service Charges center of the Deployment Plan.

### Obtain AK/SK

In the "AK Management" section of the Deployment Plan Service Charges center, click "Create AK." Copy the created AK and SK to fill in the AK and SK fields in "Step 4: Activate Deployment Plan."

![](img/6.deployment_5.png)

### Obtain License

In the "License Management" section of the Deployment Plan Service Charges center, click "Create License." When creating a License, you need to agree to the Deployment Plan user license agreement and verify via mobile phone. Copy the created License to fill in the License text field in "Step 2: Activate Deployment Plan."

![](img/6.deployment_6.png)

**Note**:

1. After obtaining the License, please proceed to activate it. If not activated, data queries will not be possible.
   
2. The **`**?token={}**`** part following the data gateway address should remain unchanged; do not remove it. You do not need to write a specific token, as **`**{}**`** is just a placeholder.

## FAQ {#faq}

:material-chat-question: How do I apply for a License with DK quantity restrictions?

1. Visit the launcher console;
2. Enter the application configuration modification interface;
3. Modify the `datakit_usage_check_enabled` configuration item under the [kodo-inner component](./application-configuration-guide.md#kodo-inner) to determine whether the number of DataKits exceeds the License limit.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Activate Guance**</font>](./activate.md)

</div>

</font>