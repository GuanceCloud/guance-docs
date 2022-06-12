#!/bin/bash

set -e

# 下载Func文档
python ./sync-docs.py --base-url="${DOC_DOWNLOAD_BASE_URL}"