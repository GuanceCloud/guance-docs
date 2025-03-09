# Embedding Pages via iframe

## Overview

This document describes how private deployment users can embed <<< custom_key.brand_name >>> pages into external platforms using iframes.

## Configuring External Platform Access

After deployment, locate the `DEPLOYCONFIG` configuration file and add `cookieSameSite:"none"` to the configuration. This allows external platforms to embed <<< custom_key.brand_name >>> pages via iframe. (By default, the value of `cookieSameSite` is LAX, which does not permit embedding from external platforms.)

![guance2](img/deployconfig.png)

## How to Obtain the iframe Link

To embed a <<< custom_key.brand_name >>> page, simply find the target page you wish to embed and copy its URL. You can use parameters to control hiding the left sidebar and the "Create Issue" button in the lower right corner. Just append parameter configurations to the page URL, for example: `<iframe src="https://console.guance.com/logIndi/log/all?hideWidget=true&hideTopNav=true&hideLeftNav=true"></iframe>`

| Parameter     | Required | Type    | Description |
| ------------- | -------- | ------- | ------------------------------------------------------------------- |
| hideWidget    | No       | Boolean | Hide the "Create Issue" button in the lower right corner. Default is not hidden; true hides it. |
| hideLeftNav   | No       | Boolean | Hide the left navigation menu in the <<< custom_key.brand_name >>> console. Default is not hidden; true hides it. |

![guance2](img/iframe-hidewidget.png)