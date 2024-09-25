# 自定义前端配色
---

本文通过更改服务配置来实现前端不同的配色方案


## 配置 configmap
将以下内容保存为 theme.css 文件
```css
/* 以下配置是覆盖默认配置的变量 */
:root {
  /* 按钮 主色调 */
  --gc-primary-color: #1770e6;
  --gc-primary-color-hover: #4d7ee6;

  /* 标签tag ，如 主机详情里面*/
  --gc-subprimary-color: #76b1ea;
  --gc-subprimary-color-hover: #549adf;

  /* 提醒 主色调，比如菜单active */
  --gc-warning-color: #1770e6;
  --gc-warning-color-hover: #1770e6;

  /* error 按钮，以及一些重要操作主色调 */
  --gc-error-color: #e64545;
  --gc-error-color-hover: #f46359;
  --gc-success-color: #4ac473;

  /* 查看器，状态字段主色调 */
  --gc-status-ok-color: #508371;
  --gc-status-error-color: #ff9500;
  --gc-status-critical-color: #e64545;
  --gc-status-info-color: #1770e6;
  --gc-status-warning-color: #ffd500;
  --gc-status-fail-color: #aaacb2;
  --gc-status-debug-color: #9666b9;
  --gc-status-alert-color: #ff9500;

  /* 蜂窝图,拓扑图 状态字段主色调 */
  --gc-level-0-color: #6ed08f;
  --gc-level-1-color: #508371;
  --gc-level-2-color: #ffd500;
  --gc-level-3-color: #ff9500;
  --gc-level-4-color: #e64545;

  /* 链接，A标签 状态字段主色调 */
  --gc-link-color: #1770e6;
  --gc-link-hover-color: #3873ef;
  --gc-link-active-color: #1770e6;
  --gc-link-normal-color: #777;
}
/* 默认主题颜色配置 */
html.light {
  --gc-color-background: #fff;
  --gc-disabled-color: #c0c4cc;
  --gc-color-text: rgba(28, 43, 52, 0.98);
  /* 左侧导航的背景颜色 */
  --gc-leftmenu-background: #2c2f39;
  /* 左侧导航的字体颜色 */
  --gc-leftmenu-color: rgba(255, 255, 255, 0.6);
  /* 左侧导航hover 或者 选中的背景颜色 */
  --gc-leftmenu-active-background: #21262d;
  /* 菜单选中效果背景 */
  --gc-list-item-active-background: #e9effe;
}
/* 暗黑主题颜色配置 */
html.dark {
  --gc-color-background: #101319;
  --gc-disabled-color: #52515c;
  --gc-color-text: hsla(0, 0%, 100%, 0.76);
  /* 左侧导航的背景颜色 */
  --gc-leftmenu-background: #161b22;
  /* 左侧导航的字体颜色 */
  --gc-leftmenu-color: hsla(0, 0%, 100%, 0.5);
  /* 左侧导航hover 或者 选中的背景颜色 */
  --gc-leftmenu-active-background: #21262d;
  /* 菜单选中效果背景 */
  --gc-list-item-active-background: #0e1935;
}

```
执行以下命令创建 configmap
```shell
kubectl -n forethought-webclient create cm front-customize-color-config --from-file=theme.css
```

## 使用 configmap
通过下列语句使用该 configmap
```shell
kubectl -n forethought-webclient edit deploy front-webclient
```
按提示添加内容
```yaml
        ...
        volumeMounts:
        - mountPath: /etc/nginx/conf.d
          name: front-nginx-config
        - mountPath: /config/cloudcare-forethought-webclient/deployConfig.js
          name: front-web-config
          subPath: config.js
        # 添加以下内容
        - mountPath: /config/cloudcare-forethought-webclient/theme/theme.css
          name: front-customize-color-config
          subPath: theme.css
        ...
        ...
      volumes:
      - configMap:
          defaultMode: 420
          name: front-web-config
          optional: false
        name: front-web-config
      - configMap:
          defaultMode: 420
          name: front-nginx-config
          optional: false
        name: front-nginx-config
      # 添加以下内容
      - configMap:
          defaultMode: 420
          name: front-customize-color-config
          optional: false
        name: front-customize-color-config
```

## 重启应用
重启应用使配置生效
```shell
kubectl -n forethought-webclient rollout restart deploy front-webclient
```