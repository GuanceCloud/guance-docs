# External platform nested observation cloud page

# # Overview

This document describes how private deployment users can nest observation cloud pages to external platforms through iframe

# # Configure external platform accessibility

After deployment, find the ` DEPLOYCONFIG ` configuration file and add ` cookieSameSite: "none" ` to the configuration to allow external platforms to nest view cloud pages through iframe. (The value of ` cookieSameSite ` is LAX by default, and external platform nesting is not allowed at this time.)

![guance2](img/deployconfig.png)


# # How do I get an iframe link

Directly find the observation cloud target page that you want to nest, and copy the page URL. Support to hide the "Create Issue" button in the left menu bar and the lower right corner through parameter control. Just append the parameter configuration to the page URL, for example: `<iframe src="https://console.guance.com/logIndi/log/all?hideWidget=true&hideTopNav=true&hideLeftNav=true"></iframe>`

| Parameter    | Required | Type     |  Description |
| ------------ | ------- | -------- | ---------------------------------------------- |
| hideWidget   | No      | Boolean  |  Hide the "Create Issue" press , which is not hidden by default, and true means hidden |
| hideLeftNav  | No      | Boolean  |  Hide the menu on the left side of, which is not hidden by default, and true means hidden   |

![guance2](img/iframe-hidewidget.png)