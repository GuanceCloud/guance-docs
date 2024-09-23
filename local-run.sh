# local preview markdown docs under mkdocs
port=$(shuf -i 40000-50000 -n 1)
lang=$1
if [ -z "$1" ]; then
	lang="zh"
fi
mkdocs serve -f mkdocs.${lang}.yml -a 0.0.0.0:${port} --no-livereload  2>&1 | tee mkdocs.log
