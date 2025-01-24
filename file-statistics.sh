#!/bin/bash

directory="${1:-.}"

if [ ! -d "$directory" ]; then
    echo "目录 $directory 不存在!"
    exit 1
fi

echo "统计目录 $directory 中各扩展名文件的数量："
find "$directory" -type f | awk -F. 'NF>1{print $NF}' | sort | uniq -c | sort -n

