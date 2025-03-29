# Embedding pages via iframe

## Overview

This document introduces how private deployment edition users can embed <<< custom_key.brand_name >>> pages into external platforms via iframe.

## Configuring External Platform Accessibility

After deployment, locate the `DEPLOYCONFIG` configuration file and add `cookieSameSite:"none"` to the configuration. This indicates that external platforms are allowed to embed <<< custom_key.brand_name >>> pages through iframe. (By default, the value of `cookieSameSite` is LAX, which does not allow external platforms to embed.)

![guance2](img/deployconfig.png)

## How to Obtain the iframe Link

Directly locate the target <<< custom_key.brand_name >>> page you wish to embed and copy the page URL. It supports hiding the left menu bar and the "Create Issue" button at the bottom right corner via parameter control. Simply append parameter configurations to the page URL, for example: `<iframe src="https://<<< custom_key.studio_main_site >>>/logIndi/log/all?hideWidget=true&hideLeftNav=true&hideTopNav=true"></iframe>`

| Parameter         | Required | Type     | Description                                                                                          |
| ----------------- | -------- | -------- | -------------------------------------------------------------------------------------------------- |
| hideWidget        | No       | Boolean  | Hides the "Create Issue" button at the bottom right corner. Default is not hidden, true means hidden |
| hideLeftNav      | No       | Boolean  | Hides the left menu of the <<< custom_key.brand_name >>> console. Default is not hidden, true means hidden |
| hideTopHeader    | No       | Boolean  | Hides the top navigation of the <<< custom_key.brand_name >>> console. Default is not hidden, true means hidden |

![guance2](img/iframe-hidewidget.png)