# Client Token 管理

Client Token 在{{{ custom_key.brand_name }}}的 RUM 应用中是用于从用户设备安全发送数据到服务器的密钥。当用户与网站或应用程序交互时，Client Token 随性能数据一起被发送，以便服务器验证并接收这些数据，从而确保数据的安全性和准确性。这种令牌机制不仅简化了身份验证流程，还支持了高效的跨域数据传输，为{{{ custom_key.brand_name }}}提供了一种简洁而有效的方式来收集和分析用户的真实使用情况。

![](img/overall-token.png)

Client Token 在 RUM 中的主要出现在接入应用的场景中。在使用公网 DataWay 接入 RUM 应用时，{{{ custom_key.brand_name }}}将为您自动生成一个 Client Token，此令牌用于从用户设备中发送数据。您可使用这一默认的 Token，也可以点击更换使用您[新建](#create)的 Token。


![](img/client-token.png)


## 新建 Token {#create}

1. 输入 Client Token 名称；
2. 点击确定;
3. 按需复制{{{ custom_key.brand_name }}}自动生成的 Client Token。

## 管理 Token 列表

所有已创建的 Client Token 均在列表内列出。您可通过列表直接查看 Client Token 名称、Client Token、创建人与创建时间。

点击删除按钮，即可删除当前 Token。删除后，如果有任何代理正在使用此令牌，将立即停止数据上报。

**注意**：如果该应用被删除，Client Token 管理列表中对应的 Client Token 也会被同步删除。

