# 数据转发至华为云 OBS
---

## 开始配置

![](../img/back-8.png)

1. 在**配置华为云资源访问授权**，须使用观测云为您提供的专属华为云账号 ID `f000ee4d7327428da2f53a081e7109bd`，[前往添加跨账号访问授权策略](../obs-config.md)；

2. 选择地区；

3. 在**存储桶**，输入您在华为云的桶名称；

4. 填入[存储路径](#standard)，方便后续进一步区分和查找数据转发的具体位置。
5. 点击**确定**，即可创建成功。


**关于海外站点**：海外站点的账号 ID 与中国站点不同，请作区分：

| 站点 | ID    |
| ---------- | ------------- |
| 中国香港 | 25507c35fe7e40aeba77f7309e94dd77    |
| 俄勒冈 | 25507c35fe7e40aeba77f7309e94dd77    |
| 新加坡 | 25507c35fe7e40aeba77f7309e94dd77    |
| 法兰克福 | 25507c35fe7e40aeba77f7309e94dd77    |


### 目录路径（文件夹）命名规范 {#standard}

1. 创建单个文件夹和多层级文件夹，斜杠（/）表示创建多层级文件夹。  
2. 文件夹名称不能以斜杠（/）开头或结尾。  
3. 不能包含两个以上相邻的斜杠（/）。 

**注意**：
    
- 若填入的文件夹不存在，观测云将直接创建，数据仍会存入该路径下。
- 请谨慎变更存储路径，由于更新配置存在 5 分钟左右的延迟，变更后可能会有部分数据依然转发到原目录下。

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 在观测云添加账号访问授权策略</font>](../obs-config.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 什么是桶策略？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 在华为云，如何对其他帐号授予桶的读写权限？</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)


</div>

</font>