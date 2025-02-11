# Configure Keycloak Users and Mapping Rules
---

## Introduction

This article will guide you on how to configure users and mapping rules in Keycloak. After completing the configuration, you can use the mapping rules to single sign-on into Guance.

## Configure Keycloak Users {#new}

1. In the created gcy realm, click **User**, then click **Add user**.

   ![](img/05_keycloak_13.png)

2. Enter the **Username** and **Email**. The Email is a required field and must match the user email configured in the Guance backend management for email mapping login to Guance.

   ![](img/05_keycloak_14.png)

3. After creating the user, set the password for the user under **Credentials**.

   ![](img/05_keycloak_15.png)

## Configure Mapping Rules

After adding Keycloak users, there are <u>two methods</u> to configure the mapping rules: one is [directly adding mapping rule attributes for the user](#user), and the other is [adding the user to a user group and then adding the mapping rule attributes](#group).

### Add Mapping Rule Attributes for User {#user}

In the created gcy realm, click **User**, select the user who needs to add the mapping rule, and in **Attributes**, click **Add** to add, for example:

- Key: department
- Value: product

![](img/10.keycloak_11.png)

#### Configure Keycloak Mapping Fields {#config}

This step involves creating Client Scopes and configuring mapping fields to <u>link the mapping rules between Keycloak and Guance</u>.

1. In the created "gcy" realm, click **Client Scopes**, and on the right side, click **Create**.

   ![](img/10.keycloak_3.png)

2. In **Add client scope**, enter the attribute field that needs to be mapped, such as "department", and click **Save**.

   ![](img/10.keycloak_4.png)

3. Click into the created key, such as "department", and under **Mappers**, click **Create** on the right to create the mapping.

   ![](img/10.keycloak_5.png)

4. In the pop-up window **Create Protocol Mappers**, fill in the following content and click **Save** after completion.

| Field            | Description                          |
| ------------------ | ------------------------------------ |
| Name            | Enter the mapped attribute field, such as "department".                          |
| Mapper Type      | Select "User Attribute".                          |
| User Attribute      | Enter the mapped attribute field, such as "department".                          |
| Token Claim Name      | Enter the mapped attribute field, such as "department".                          |
| Claim JSON Type      | Select "String".                          |

   ![](img/10.keycloak_7.png)

5. In **Client**, click the created "Guance" client.

   ![](img/10.keycloak_8.png)

6. Click into it, and under **Client Scopes > Setup**, add the created "department" to the right **Assigned Default Client Scopes**.

   ![](img/10.keycloak_9.png)

#### Verify if the Mapping Rule Works

After completing the above steps, you can log in directly to Guance via Keycloak to check if the user has been added to the corresponding workspace and assigned the appropriate roles.

<font color=coral>You can also verify the mapping rules in Keycloak:</font>

After configuring the mapping rules, go to **Client > Client Scopes > Evaluate > Generated User Info** to see if the mapping rules work. As shown in the figure below, if the configured mapping fields, such as "department", exist, it means that login can be mapped through this field.

![](img/10.keycloak_10.png)

#### Configure Mapping Rules in Guance Management Backend

In addition to configuring the single sign-on mapping rules in Keycloak, you need to configure the mapping rules in the management backend. Only after both configurations are completed will the mapping rules take effect.

Go to the Guance Deployment Plan **management backend > [Mapping Rules](./setting.md#mapping)** for configuration. Accounts that match will join the workspace according to the rules and be granted the appropriate roles.

<!--

![](img/10.keycloak_2.png)

-->

#### Use Keycloak Account to Single Sign-On into Guance

After all configurations are completed, you can [single sign-on into Guance](keycloak-sso.md#5-keycloak).

### Add Mapping Rule Attributes for User Group {#group}

1. In the created gcy realm, click **Groups**, then click **New** to create a new user group, such as "department".

   ![](img/10.keycloak_14.png)

2. In **Attributes**, click **Add** to add, for example:

   - Key: department
   - Value: product

   ![](img/10.keycloak_13.png)

3. In **User > Groups**, click **Join** to add the user to the user group.

   ![](img/10.keycloak_12.png)

4. [Start configuring the mapping rules](#config).