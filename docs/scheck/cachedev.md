# 使用开发者模式查看内存和缓存使用情况
---

- 版本：1.0.7-4-g582a075
- 发布日期：2022-07-11 02:27:55
- 操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## 说明
在开发测试或者实际运行过程中，对lua产生的缓存大小有时候是不可控的 如：缓存一个目录下的文件列表，当文件数量太大时 会造成占用内存太大 严重时触发cgroup 导致进程挂起或卡死。

所以使用开发者模式，可在运行过程中实时查看内存情况和缓存情况是有必要的。

### cache_dev 开发者模式
### 想要解决的问题和办法：

- 内存或者cpu波动较大又无法定位哪里出现了问题
- 为解决缓存占用太大问题,必须要知道缓存了多少数据，
- 而在缓存过程中只有存储时和取出时（同一个lua脚本或同样功能脚本）才知道cache的type
- 但是在cache单元里是不知道具体的存储类型。
- 对于string bool int/float 可以知道大小，lua.table结构类型 无法直接获取大小
- 所以：对于lua.table类型 应当做别的处理 如：落盘
- 这样才能控制scheck在运行过程中不至于占用太大的内存，实际上也不应该占用150M以上。
- scheck异常结束进程，而又可以以结束之前状态继续断点启动运行。

#### 解决办法：

- 相同脚本类型使用的cache一样 key也相同 但由于不同文件（规则ID不同）存了两份一模一样的。所以 应当使用同一处缓存 而不应该分别存储两份。
- 解决上一个问题 带来的另一个问题：所有规则有自己的cache key。容易出现混淆
- 缓存持久化、可视化。同时带来的好处是快速定位问题、mock测试、规则测试等。
- 持久化之后 可相应减少内存开销


## 配置
打开配置文件，并将pprof设置成true

```toml
[system]
    ...
 pprof = true
```

打开开关后 会监听本地端口`127.0.0.1:6060`,只能通过本机访问。 通过go pprof命令查看内存和cpu使用情况 [官方文档入口](https://code.google.com/p/google-perftools/)

```shell
# 然后使用pprof工具查看堆剖面：
go tool pprof http://localhost:6060/debug/pprof/heap
# top 20 
top 20
# list func name or pkg name 
list

# 或查看周期30秒的CPU剖面
go tool pprof http://localhost:6060/debug/pprof/profile
# 或查看go程阻塞剖面
go tool pprof http://localhost:6060/debug/pprof/block

# 要查看所有可用的剖面，在你的浏览器阅读http://localhost:6060/debug/pprof/。要学习这些运转的设施，访问
http://blog.golang.org/2011/06/profiling-go-programs.html
```

### 缓存
打开开发者模式后，lua脚本产生的缓存会序列化到安装目录下`cache.json`中。
目前支持缓存lua有多种类型：LTString,LTNumber,LTBool,LTTable。
不支持的lua类型：LTChannel, LTFunction, LTNil, LTThread, LTUserData。

```
{
	"msg_data": {
		"/boot/grub2/grub.cfg": {           // key
			"c_type": 0,
			"rule_name": "0070-grub-priv", // 规则名称
			"val": "-rw-r--r--"             // val string类型
		},
		"/etc/fstab": {
			"c_type": 1,
			"rule_name": "0029-fstab-exist",
			"val": true             // val bool类型
		},
		"/usr/lib/systemd/system/docker.socket": {
        	    "c_type": 2,
        	    "rule_name": "0307-docker-socket-priv",
        	    "val": 420          // val number类型
        }
    ... 
  }
}
```

每隔一段时间都会将全部缓存全部写入文件中，scheck并不会读取缓存内容。
断点重启等功能待后续开发。
