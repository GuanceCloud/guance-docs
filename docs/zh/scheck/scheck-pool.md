# Scheck 并发策略
--- 

- 版本：1.0.7-6-gd485c74
- 发布日期：2022-10-10 08:24:38
- 操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## 用线程池加任务队列实现lua脚本的调度:

原来的形式是一个lua proto对应着一个lua.state对象，每一个state对象都会加载公共lib库和公共数据。
每一个lua proto在运行时都对应一个定时器，这样运行时候 会出现很多lua脚本扎堆式运行，并且所有的state占用了太多的内存。
所以就做了这样的优化：
- 创建一个lua.state池，用的时候从中取出一个，用完就回收。
- 线程池大小做成动态，多个任务需要同时运行时 有足够的state对象可供调用。
- 取消所有的定时器 全部改成间隔时间运行，原因是scheck运行的lua脚本 并没有要求实时性很高，出现一些运行时间差也是允许的。

## 线程池：

 lua.state是运行lua proto的最小单元，也可称为lua虚拟机。线程池是多个lua.state组成的。
- 从线程池中取一个states对象时候,如果池中还有就从池中获取。
- 如果池中没有，但运行的数量还没有达到最大允许的运行数量cap时，创建一个state对象 这个state对象随着调用的结束而回收。
- 池中的state对象用完之后马上回收。
- 有初始化大小和最大容量，是允许有运行数量的峰值。

## 任务队列：

- 将lua运行时间统一改成间隔时间组成的队列。
- 遍历任务队列从中取出离当前时间最近的任务，如果已经超过的当前时间，马上运行。
- 如果离当前时间还有时间，起一个定时器 时间到了就运行
- 任务运行时候需要一个state来运行lua的proto，需要从线程池中获取一个state 这时候 如果池中没有并且总运行的数量已经达到设置的峰值。就会出现等待状态，直到有别的任务执行完归还state。

