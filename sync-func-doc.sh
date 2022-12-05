#!/bin/bash

set -e

# 拉取最新文档
#git pull

# 进入 DataFlux Func 文档目录
cd docs/zh/dataflux-func

# 下载目录
rm -f .pages
wget https://func.guance.com/doc/.pages -O .pages
sed -i "/# FUNC SITE ONLY START/,/# FUNC SITE ONLY END/d" .pages
sed -i "s/# GUANCE HELP PLACEHOLDER/- index.md/" .pages

# 下载Func文档
python ./sync-docs.py --base-url="${DOC_DOWNLOAD_BASE_URL}"

# 返回
cd -

# 自动提交、推送
#git add .
#git commit -m '同步 DataFlux Func 文档'
#git push
