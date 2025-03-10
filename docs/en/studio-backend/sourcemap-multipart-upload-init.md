# SourceMap Sharded Upload and Associated Interface Usage Instructions

## Involved Interfaces
1. [Shard Upload Event Initialization](../../open-api/rum-sourcemap/multipart-upload-init/)
2. [Upload Single Shard](../../open-api/rum-sourcemap/upload-part/)
3. [Cancel a Shard Upload Event](../../open-api/rum-sourcemap/upload-cancel/)
4. [List Uploaded Shards for a Shard Upload Event](../../open-api/rum-sourcemap/part-list/)
5. [Merge Shards to Generate File](../../open-api/rum-sourcemap/part-merge/)


## Shard Upload Interface Operation Steps

1. [Shard Upload Event Initialization] Initialize the shard upload event, generating an event ID. Subsequent resource uploads use this ID to confirm resource ownership.

2. [Upload Single Shard] After slicing the SourceMap file, upload individual sliced files.

3. [Cancel a Shard Upload Event] Generally used in cases of upload errors or expiration to delete uploaded but unmerged shards.

4. [List Uploaded Shards for a Shard Upload Event] Typically used for resuming interrupted uploads, retrieving the list of uploaded shards for a specific upload event.

5. [Merge Shards to Generate File] Merge the resources corresponding to a specific upload event into a single file, marking the end of the SourceMap sharded upload process. Internally, it will also initiate a decompression command to extract the SourceMap file into the corresponding resource directory.


## Single File Upload Process
### Involved Interfaces
[Upload Single File Content](../../open-api/rum-sourcemap/upload-file-content/)

### Description
Used to upload the content of a single source file (a single source file extracted from a SourceMap).


## Limitations

The size of a single shard file should be controlled within 10MB.