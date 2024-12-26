

# SourceMap分片上传关联接口使用说明

## 涉及接口
<<<<<<< HEAD
1. [分片上传事件初始化](../../open-api/rum-sourcemap/multipart-upload-init/)
2. [上传单个分片](../../open-api/rum-sourcemap/upload-part/)
3. [取消一个分片上传事件](../../open-api/rum-sourcemap/upload-cancel/)
4. [列出一个分片上传事件所对应的已上传的分片列表](../../open-api/rum-sourcemap/part-list/)
5. [合并各分片生成文件](../../open-api/rum-sourcemap/part-merge/)
=======
[分片上传事件初始化](../../open-api/rum-sourcemap/multipart-upload-init/)
[上传单个分片](../../open-api/rum-sourcemap/upload-part/)
[取消一个分片上传事件](../../open-api/rum-sourcemap/upload-cancel/)
[列出一个分片上传事件所对应的已上传的分片列表](../../open-api/rum-sourcemap/part-list/)
[合并各分片生成文件](../../open-api/rum-sourcemap/part-merge/)
>>>>>>> release

## 分片上传接口操作步骤

1. [分片上传事件初始化] 初始化分片上传事件，生成一个事件标识ID, 后续上传资源根据该标识ID确认资源归属。

2. [上传单个分片] SourceMap 文件切片之后，上传的单个切片文件

3. [取消一个分片上传事件] 一般切片上传错误，或者失效的情况下，用于删除某个已上传但未合并的分片

4.[列出一个分片上传事件所对应的已上传的分片列表] 一般用于断点续传时，获取某个上传事件已上传的 分片列表

5. [合并各分片生成文件] 将某个上传事件对应的 分片资源合并为一个文件，SourceMap 分片上传流程结束。同时内部会发起解压命令将 SourceMap 文件解压到对应资源目录下。



## 单文件上传流程
### 涉及接口
[上传单个文件内容](../../open-api/rum-sourcemap/upload-file-content/)

### 说明
用于上传单个源文件内容（SourceMap 解压后的单个源文件）



## 限制

单片文件大小控制在 10MB 以内