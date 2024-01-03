HL  = \033[0;32m # high light
NC  = \033[0m    # no color
RED = \033[31m   # red

DOC_DIR?=docs/

404_check:
	@bash checking/404-check.sh $(DOC_DIR) checking/404-check.json;
	cat deadlink.log | grep '✖' && \
		{ printf "$(RED) [FAIL] 404 check failed \n$(NC)"; exit -1; } || \
		{ printf "$(HL)\n-----------\n404 check ok\n-----------\n$(NC)"; }

spell_check:
	cspell lint -c checking/cspell.json --no-progress $(DOC_DIR)/**/*.md | tee cspell.lint;
	@if [ -s cspell.lint ]; then \
		printf "$(RED) [FAIL] cspell.lint not empty \n$(NC)"; \
		exit -1; \
	fi

markdown_check:
	markdownlint -c checking/markdownlint.yml $(DOC_DIR) 2>&1 | grep " MD" | tee mdlint.out;
	@if [ -s mdlint.out ]; then \
		printf "$(RED) [FAIL] mdlint.out not empty \n$(NC)"; \
		exit -1; \
	fi

lint: 404_check spell_check markdown_check 
