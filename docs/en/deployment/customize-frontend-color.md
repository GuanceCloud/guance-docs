# Custom Frontend Color Scheme
---

This article explains how to achieve different frontend color schemes by modifying service configurations.

## Configure ConfigMap
Save the following content as a `theme.css` file:
```css
/* The following configuration overrides the default variable settings */
:root {
  /* Primary button color */
  --gc-primary-color: #1770e6;
  --gc-primary-color-hover: #4d7ee6;

  /* Secondary color for tags, such as in host details */
  --gc-subprimary-color: #76b1ea;
  --gc-subprimary-color-hover: #549adf;

  /* Warning color, e.g., active menu items */
  --gc-warning-color: #1770e6;
  --gc-warning-color-hover: #1770e6;

  /* Error button and critical operation color */
  --gc-error-color: #e64545;
  --gc-error-color-hover: #f46359;
  --gc-success-color: #4ac473;

  /* Explorer status field colors */
  --gc-status-ok-color: #508371;
  --gc-status-error-color: #ff9500;
  --gc-status-critical-color: #e64545;
  --gc-status-info-color: #1770e6;
  --gc-status-warning-color: #ffd500;
  --gc-status-fail-color: #aaacb2;
  --gc-status-debug-color: #9666b9;
  --gc-status-alert-color: #ff9500;

  /* Status field colors for honeycomb and topology maps */
  --gc-level-0-color: #6ed08f;
  --gc-level-1-color: #508371;
  --gc-level-2-color: #ffd500;
  --gc-level-3-color: #ff9500;
  --gc-level-4-color: #e64545;

  /* Link and A tag status field colors */
  --gc-link-color: #1770e6;
  --gc-link-hover-color: #3873ef;
  --gc-link-active-color: #1770e6;
  --gc-link-normal-color: #777;
}
/* Default theme color configuration */
html.light {
  --gc-color-background: #fff;
  --gc-disabled-color: #c0c4cc;
  --gc-color-text: rgba(28, 43, 52, 0.98);
  /* Left navigation background color */
  --gc-leftmenu-background: #2c2f39;
  /* Left navigation font color */
  --gc-leftmenu-color: rgba(255, 255, 255, 0.6);
  /* Left navigation hover or selected background color */
  --gc-leftmenu-active-background: #21262d;
  /* Selected menu item background */
  --gc-list-item-active-background: #e9effe;
}
/* Dark theme color configuration */
html.dark {
  --gc-color-background: #101319;
  --gc-disabled-color: #52515c;
  --gc-color-text: hsla(0, 0%, 100%, 0.76);
  /* Left navigation background color */
  --gc-leftmenu-background: #161b22;
  /* Left navigation font color */
  --gc-leftmenu-color: hsla(0, 0%, 100%, 0.5);
  /* Left navigation hover or selected background color */
  --gc-leftmenu-active-background: #21262d;
  /* Selected menu item background */
  --gc-list-item-active-background: #0e1935;
}

```
Execute the following command to create the ConfigMap:
```shell
kubectl -n forethought-webclient create cm front-customize-color-config --from-file=theme.css
```

## Using the ConfigMap
Use the following command to apply the ConfigMap:
```shell
kubectl -n forethought-webclient edit deploy front-webclient
```
Add the following content as prompted:
```yaml
        ...
        volumeMounts:
        - mountPath: /etc/nginx/conf.d
          name: front-nginx-config
        - mountPath: /config/cloudcare-forethought-webclient/deployConfig.js
          name: front-web-config
          subPath: config.js
        # Add the following content
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
      # Add the following content
      - configMap:
          defaultMode: 420
          name: front-customize-color-config
          optional: false
        name: front-customize-color-config
```

## Restart the Application
Restart the application to apply the new configuration:
```shell
kubectl -n forethought-webclient rollout restart deploy front-webclient
```