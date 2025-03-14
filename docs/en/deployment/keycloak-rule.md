# Configure Keycloak Users and Mapping Rules
---

## Introduction

This article will explain how to configure users and mapping rules in Keycloak. After configuration is complete, single sign-on (SSO) can be achieved through the mapping rules to <<< custom_key.brand_name >>>.

## Configure Keycloak Users {#new}

1. In the created gcy realm, click **User**, then click **Add user**.

   ![](img/05_keycloak_13.png)

2. Enter the **Username** and **Email**. The email is a required field and must match the user email configured in the <<< custom_key.brand_name >>> backend management to ensure correct email mapping for SSO login to <<< custom_key.brand_name >>>.

   ![](img/05_keycloak_14.png)

3. After creating the user, set a password for the user under **Credentials**.

   ![](img/05_keycloak_15.png)

## Configure Mapping Rules 

After adding Keycloak users, there are <u>two ways</u> to configure mapping rules: one is [adding mapping rule attributes directly to the user](#user), and the other is [adding the user to a user group and then adding the mapping rule attributes](#group).

### Add Mapping Rule Attributes to User {#user}

In the created gcy realm, click **User**, select the user to which you want to add the mapping rule, and under **Attributes**, click **Add**. For example:

- Key: department
- Value: product

![](img/10.keycloak_11.png)

#### Configure Keycloak Mapping Fields {#config}

This step involves creating Client Scopes and configuring mapping fields to <u>synchronize the mapping rules between Keycloak and <<< custom_key.brand_name >>></u>.

1. In the created "gcy" realm, click **Client Scopes**, and on the right side, click **Create**.

   ![](img/10.keycloak_3.png)

2. In **Add client scope**, enter the attribute field that needs to be mapped, such as “department”, and click **Save**.

   ![](img/10.keycloak_4.png)

3. Click into the created key, such as “department”, and under **Mappers**, click **Create** on the right side to create the mapping.

   ![](img/10.keycloak_5.png)

4. In the pop-up window **Create Protocol Mappers**, fill in the following details and click **Save** after completion.

| Field               | Description                          |
|---------------------|--------------------------------------|
| Name                | Enter the mapping attribute field, e.g., “department”. |
| Mapper Type         | Select “User Attribute”.             |
| User Attribute      | Enter the mapping attribute field, e.g., “department”. |
| Token Claim Name    | Enter the mapping attribute field, e.g., “department”. |
| Claim JSON Type     | Select “String”.                    |

   ![](img/10.keycloak_7.png)

5. In **Client**, click the created “Guance” client.

   ![](img/10.keycloak_8.png)

6. Click into it, and under **Client Scopes > Setup**, add the created “department” to the right side of **Assigned Default Client Scopes**.

   ![](img/10.keycloak_9.png)

#### Verify the Mapping Rule

After completing the above steps, you can log in directly to <<< custom_key.brand_name >>> via Keycloak SSO to check if the user has been added to the corresponding workspace and assigned the appropriate role.

<font color=coral>You can also verify the mapping rules within Keycloak:</font>

After configuring the mapping rules, go to **Client > Client Scopes > Evaluate > Generated User Info** to check if the mapping rules are functional. As shown in the figure below, if the configured mapping fields, such as “department”, exist, it indicates that login can be performed using these fields.

![](img/10.keycloak_10.png)

#### Configure <<< custom_key.brand_name >>> Management Backend Mapping Rules

In addition to configuring Keycloak SSO mapping rules, you also need to configure the mapping rules in the management backend. Both configurations must be completed for the mapping rules to take effect.

Go to <<< custom_key.brand_name >>> Deployment Plan **Management Backend > [Mapping Rules](./setting.md#mapping)** for configuration. Matching accounts will join the workspace and be granted roles based on the rules.

#### Use Keycloak Account to SSO <<< custom_key.brand_name >>>

After all configurations are complete, you can [SSO to <<< custom_key.brand_name >>>](keycloak-sso.md#5-keycloak).

### Add Mapping Rule Attributes to User Group {#group}

1. In the created gcy realm, click **Groups**, then click **New** to create a new user group, such as “department”.

   ![](img/10.keycloak_14.png)

2. Under **Attributes**, click **Add** to add attributes, such as:

   - Key: department
   - Value: product

   ![](img/10.keycloak_13.png)

3. In **User > Groups**, click **Join** to add the user to the user group.

   ![](img/10.keycloak_12.png)

4. [Start configuring the mapping rules](#config).