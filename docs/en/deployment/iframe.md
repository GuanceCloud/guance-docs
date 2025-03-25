# Embedding pages via iframe

## Overview

This document explains how private deployment edition users can embed the <<< custom_key.brand_name >>> page into an external platform using an iframe.


## Configuring External Platform Accessibility

After deployment, locate the `DEPLOYCONFIG` configuration file and add `cookieSameSite:"none"` to the configuration. This indicates that the external platform is allowed to embed the <<< custom_key.brand_name >>> page via iframe. (By default, the value of `cookieSameSite` is LAX, which does not allow embedding from external platforms.)

![guance2](img/deployconfig.png)


## How to Obtain the iframe Link

Directly find the target <<< custom_key.brand_name >>> page you wish to embed and copy the page URL. It supports hiding the left menu bar and the "Create Issue" button at the bottom right through parameter controls. Simply append the parameter configuration to the page URL, for example: `<iframe src="https://<<< custom_key.studio_main_site >>>/logIndi/log/all?hideWidget=true&hideTopNav=true&hideLeftNav=true"></iframe>`

| Parameter    | Required | Type     | Description |
| ------------ | -------- | -------- | ---------------------------------------------- |
| hideWidget   | No       | Boolean  | Hides the "Create Issue" button at the bottom right. Default is not hidden, true means hidden |
| hideLeftNav  | No       | Boolean  | Hides the left menu of the <<< custom_key.brand_name >>> console. Default is not hidden, true means hidden |

![guance2](img/iframe-hidewidget.png)