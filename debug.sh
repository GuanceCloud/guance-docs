#!/bin/bash
# author: tanb
# date: Sun Jul 23 09:55:07 CST 2023
#
# Start show local docs preview.

lang=zh
bind=0.0.0.0
port=8000

usage() {
	echo "" 1>&2;
	echo "Usage: " 1>&2;
	echo "" 1>&2;
	echo "debug.sh -l string: set language(zh/en)" 1>&2
	echo "         -p int: set mkdocs port(default ${port})" 1>&2
	echo "         -b string: set mkdocs bind(default ${bind})" 1>&2
	echo "" 1>&2;
	exit -1;
}

while getopts ":p:b:lh" arg; do
	case "${arg}" in
		p)
			port="${OPTARG}"
			;;
		b)
			bind="${OPTARG}"
			;;
		l)
			lang="${OPTARG}"
			;;
		h)
			usage
			;;
		*)
			echo "invalid args $@";
			usage
			;;
	esac
done
shift $((OPTIND-1))

mkdocs serve -f mkdocs.${lang}.yml -a ${bind}:${port} --no-livereload 2>&1 | tee mkdocs.log
