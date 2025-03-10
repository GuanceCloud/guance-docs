# Apply for a License

The <<< custom_key.brand_name >>> Deployment Plan provides teachers, students, cloud computing enthusiasts, and other community users with a simple, accessible, and fully functional productized local deployment platform. You are welcome to apply and download for free to try it out, set up your own <<< custom_key.brand_name >>> platform, and experience the complete product features.

## Steps

### Register for a Deployment Plan Account

Directly open the registration page for the Deployment Plan ([https://boss.guance.com/index.html#/signup?type=private](https://boss.guance.com/index.html#/signup?type=private)) and follow the instructions to register for a Deployment Plan account.

![](img/6.deployment_3.png)

After completing the registration, enter the <<< custom_key.brand_name >>> Deployment Plan Billing Center.

### Obtain AK/SK

In the "AK Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create AK." Copy the created AK and SK and fill them into the AK and SK fields in "Step4: Activate Deployment Plan."

![](img/6.deployment_5.png)

### Obtain License

In the "License Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create License." When creating a License, you need to agree to the Deployment Plan user license agreement and verify via phone. Copy the created License and fill it into the License text field in "Step2: Activate Deployment Plan."

![](img/6.deployment_6.png)

**Note**:

1. After obtaining the License, please proceed to activate it. If the License is not activated, data queries will not be possible.
2. The data gateway address should retain the **`?token={}`** part exactly as shown. Do not remove it or specify an actual token; **`{}`** is just a placeholder.

## FAQ {#faq}

:material-chat-question: How do I apply for a License with a DK quantity limit?

1. Visit the launcher console;
2. Enter the application configuration modification interface;
3. Modify the `datakit_usage_check_enabled` configuration item under the [kodo-inner component](./application-configuration-guide.md#kodo-inner) to determine whether the number of DataKits exceeds the License limit.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Activate <<< custom_key.brand_name >>>**</font>](./activate.md)

</div>

</font>