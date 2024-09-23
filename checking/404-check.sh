# check 404 pages under ./docs
# author: tanb
# date: Tue Jan  3 16:38:35 CST 2023

# Install tool:
#
#   npm install -g markdown-link-check
#
# See:
#   https://github.com/tcort/markdown-link-check#installation

doc_dir=$1

if [ -z $doc_dir ]; then
	doc_dir="./docs" # default
fi

# NOTE: # links within integration-index.md will not pass 404 check for it's
#   <img src="../icon/xxx/icon.png" />
# the path '../icon' within docs/{en,zh}/integrations/icon, so the check always failed.
files=($(find $doc_dir -name '*.md' -not -name "integration-index.md"))

TOTAL=${#files[@]}

printf "checking %d markdown files under docs...\n" $TOTAL

truncate -s 0 deadlink.log
ITER=0
HL='\033[0;32m' # high light
NC='\033[0m'    # no color
for f in "${files[@]}"; do
	j=$(awk "BEGIN{print $ITER / $TOTAL * 100}")
	printf "*************************************\n"
	printf "            checking ${HL}%04d/%d(%.2f%%)${NC}           \n" $ITER $TOTAL $j
	printf "*************************************\n"
	markdown-link-check -q -p -c $2 $f | tee -a deadlink.log;
	ITER=$(expr $ITER + 1)
done

# sed -n '/^FILE: \.\/docs\/zh\/datakit.*/,/FILE/p' deadlink.log |grep -B 1 '✖' | grep -vE http
