# 通过 iframe 实现页面嵌套

## 概述

本文档介绍私有部署版用户如何通过 iframe 嵌套<<< custom_key.brand_name >>>页面到外部平台

## 配置外部平台可访问

部署后，找到 `DEPLOYCONFIG` 配置文件，添加 `cookieSameSite:"none"`到配置中，表示允许外部平台通过 iframe 嵌套<<< custom_key.brand_name >>>页面。（默认情况下 `cookieSameSite`值为 LAX，此时不允许外部平台嵌套）

![guance2](img/deployconfig.png)

## 如何获取 iframe 链接

直接找到想要嵌套的<<< custom_key.brand_name >>>目标页面，复制页面 URL 即可。支持通过参数控制隐藏左侧菜单栏和右下角的「创建 Issue」按钮。只需要在页面 URL 后面追加参数配置，例如：`<iframe src="https://<<< custom_key.studio_main_site >>>/logIndi/log/all?hideWidget=true&hideTopNav=true&hideLeftNav=true"></iframe>`

| 参数          | 是否必填 | 类型    | 描述                                                                       |
| ------------- | -------- | ------- | -------------------------------------------------------------------------- |
| hideWidget    | 否       | Boolean | 隐藏右下角「创建 Issue」按，默认不隐藏，true 表示隐藏                      |
| hideLeftNav   | 否       | Boolean | 隐藏<<< custom_key.brand_name >>>控制台左侧菜单，默认不隐藏，true 表示隐藏 |
| hideTopHeader | 否       | Boolean | 隐藏<<< custom_key.brand_name >>>控制台顶部导航，默认不隐藏，true 表示隐藏 |

![guance2](img/iframe-hidewidget.png)
