# 监控器问题排查

## 简介

本文将介绍如何排查监控器常见问题：

- 监控器不产生事件
- 监控器有事件，但没有推送消息通知


## 前提条件

- 需要<<< custom_key.brand_name >>>创建监控器的账号权限
- 需要观测后台管理权限

## 排查步骤

### 步骤一：创建测试监控器

- 登录<<< custom_key.brand_name >>>控制台
- 选择「监控」-「新建监控器」-「阈值检测」

- 检测指标：

  ```shell
  M::`cpu`:(COUNT(`usage_guest`)) BY `host`
  ```

- 触发条件：紧急 Result > 0

- 事件标题：test

- 事件内容：test

- 告警策略：选择你设置好的策略

- 保存

  ![](img/faq-cron-demo.png)

  

### 步骤二：获取自动触发配置 ID

- 登录<<< custom_key.brand_name >>>控制台 选择「监控」- 打开浏览器调试模式

  ![](img/faq-get-cron-id.png)

- 点击监控器名称链接

  ![](img/faq-get-cron-id-2.png)

- 获取自动触发配置 ID

  ![](img/faq-get-cron-id-3.png)

### 步骤三：登录 Func 平台查询问题

- Launcher 获取 Func 登录地址
  ![](img/faq-cron-4.png)

  ![](img/faq-cron-5.png)

- 登录您的 func 平台

  ![](img/faq-func.png)

- 「管理」-「自动触发配置」-「选择显示全部」-「输入步骤二的ID」-「确认搜索」-「近期执行」

  ![](img/faq-get-info.png)



- 你可以通过 「近期执行」查看详细报错信息

  ![](img/faq-get-error.png)

### 步骤四：查看告警通知日志排查

???+ warning "注意"
     建议执行`kubectl rollout restart -n middleware deploy message-desk-worker message-desk`，再测试排查。

message-desk-worker 服务是<<< custom_key.brand_name >>>告警通知模块，负责发送钉钉机器人通知，邮件通知，飞书机器人通知等。

- namespace: middleware
- deployment: message-desk-worker
- log patch: /logdata/bussiness.log

![](img/faq-message-desk-log.png)