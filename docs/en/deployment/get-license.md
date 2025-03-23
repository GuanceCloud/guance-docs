# Apply for License

The <<< custom_key.brand_name >>> Deployment Plan provides a simple, accessible, and fully-featured productized local deployment platform for teachers, students, cloud computing enthusiasts, and other community users. You are welcome to apply and download for free, set up your own <<< custom_key.brand_name >>> platform, and experience the complete product features.

## Steps


### Register Deployment Plan Account

Directly open the registration address for the deployment plan ([https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private](https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private)) and register a deployment plan account according to the prompts.

![](img/6.deployment_3.png)

After completing the registration, enter the <<< custom_key.brand_name >>> Deployment Plan Billing Center.


### Obtain AK/SK

In the "AK Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create AK." After creating the AK and SK, copy them and fill them into the AK and SK fields in "Step4: Activate Deployment Plan."

![](img/6.deployment_5.png)

### Obtain License

In the "License Management" section of the <<< custom_key.brand_name >>> Deployment Plan Billing Center, click "Create License." When creating the license, you need to agree to the user license agreement for the deployment plan and pass mobile verification. The created license can then be copied and filled into the License text field in "Step2: Activate Deployment Plan."

![](img/6.deployment_6.png)


**Note**:

1. After obtaining the license, please proceed to activate it. If the license is not activated, data queries will not be possible.

2. The **`**?token={}**`** in the data gateway address should be retained as is, without removal. There is no need to write a specific token, and **`**{}**`** is just a placeholder.
 
## FAQ {#faq}

:material-chat-question: How to apply for a License with DK quantity restrictions?

1. Access the launcher console;
2. Enter the application configuration modification interface;
3. Modify the `datakit_usage_check_enabled` configuration item under the [kodo-inner component](./application-configuration-guide.md#kodo-inner) to determine whether the number of DataKits exceeds the License limit.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Activate <<< custom_key.brand_name >>>**</font>](./activate.md)

</div>

</font>