#!/bin/bash

# 依赖 ffmpeg 的 png 图片批量优化脚本
# 运行之前需要在本机安装 ffmpeg

files=$(find $PWD | xargs ls -ld  | awk '{print $9}' | grep '\.png')
before_size_total=0
after_size_total=0
file_count=0

echo '' > /tmp/optimize.log

for f in $files; do
  size=$(ls -l $f | awk '{print $5}')
    
  if [ $size -gt 1024 ]; then
    ffmpeg -i $f -q 5 /tmp/optimized.png
    mv /tmp/optimized.png $f

    new_size=$(ls -l $f | awk '{print $5}')

    file_count=$(($file_count + 1))
    before_size_total=$(($before_size_total + $size))
    after_size_total=$(($after_size_total + $new_size))

    echo $f '\t优化前文件大小: ' $size '\t优化后文件大小: ' $new_size | tee -a /tmp/optimize.log
  fi
done

echo ''
echo 优化图片总数: ${file_count}, 优化前总大小: ${before_size_total}, 优化后总大小: ${after_size_total} | tee -a /tmp/optimize.log
