#!/bin/bash

set -e

# 下载目录
rm -f .pages
wget https://func.guance.com/doc/.pages -O .pages
sed -i "/# FUNC SITE ONLY START/,/# FUNC SITE ONLY END/d" .pages

# 下载Func文档
python ./sync-docs.py --base-url="${DOC_DOWNLOAD_BASE_URL}"