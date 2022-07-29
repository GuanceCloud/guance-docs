#!/bin/bash

files=$(find $PWD | xargs ls -ld  | awk '{print $9}' | grep '\.md')
char_count=0
file_count=0

for f in $files; do
    head -n1 $f

    c=$(cat $f | wc -c)
    char_count=$(($char_count + $c))
    file_count=$(($file_count + 1))

    echo $f '\t字符数: ' $c
done

echo
echo '文档总数: '$file_count
echo '文档总共字符数: '$char_count
