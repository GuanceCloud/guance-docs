# SourceMap Sharded Upload Associated Interface Usage Instructions

## Involved Interfaces
1. [Shard Upload Event Initialization](../../open-api/rum-sourcemap/multipart-upload-init/)
2. [Upload Single Shard](../../open-api/rum-sourcemap/upload-part/)
3. [Cancel a Shard Upload Event](../../open-api/rum-sourcemap/upload-cancel/)
4. [List Uploaded Shards for a Shard Upload Event](../../open-api/rum-sourcemap/part-list/)
5. [Merge Shards to Generate File](../../open-api/rum-sourcemap/part-merge/)


## Shard Upload Interface Operation Steps

1. [Shard Upload Event Initialization] Initialize the shard upload event, generating an event ID. Subsequent uploads of resources will be confirmed based on this ID.

2. [Upload Single Shard] After slicing the SourceMap file, upload individual sliced files.

3. [Cancel a Shard Upload Event] Generally used when there is an error in uploading shards or they become invalid, to delete uploaded but unmerged shards.

4. [List Uploaded Shards for a Shard Upload Event] Generally used for resuming interrupted uploads, to obtain the list of already uploaded shards for a specific upload event.

5. [Merge Shards to Generate File] Merge the resources of a specific upload event into one file, ending the SourceMap sharded upload process. Internally, it also initiates an unpacking command to decompress the SourceMap file into the corresponding resource directory.


## Single File Upload Process
### Involved Interfaces
[Upload Single File Content](../../open-api/rum-sourcemap/upload-file-content/)

### Description
Used to upload single source file content (individual source files after decompressing SourceMap).


## Limitations

Individual shard file size should be controlled within 10MB.