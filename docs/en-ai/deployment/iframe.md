# Embedding Pages via iframe

## Overview

This document explains how private Deployment Plan users can embed Guance pages into external platforms using iframes.

## Configuring External Platform Access

After deployment, locate the `DEPLOYCONFIG` configuration file and add `cookieSameSite:"none"` to allow external platforms to embed Guance pages via iframe. (By default, the value of `cookieSameSite` is LAX, which does not permit embedding from external platforms.)

![guance2](img/deployconfig.png)

## How to Obtain the iframe Link

To embed a target Guance page, simply copy the URL of the page you wish to embed. You can use parameters to control hiding the left navigation menu and the "Create Issue" button at the bottom right. Just append parameter configurations to the page URL, for example: `<iframe src="https://console.guance.com/logIndi/log/all?hideWidget=true&hideTopNav=true&hideLeftNav=true"></iframe>`

| Parameter     | Required | Type     | Description |
| ------------- | -------- | -------- | -------------------------------------------------------------------- |
| hideWidget    | No       | Boolean  | Hide the "Create Issue" button at the bottom right; default is not hidden, true means hidden |
| hideLeftNav   | No       | Boolean  | Hide the left navigation menu in the Guance console; default is not hidden, true means hidden |

![guance2](img/iframe-hidewidget.png)