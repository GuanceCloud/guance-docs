# Generate integration index markdown
# Fri Sep 13 09:52:10 CST 2024

arch=
case $(uname -m) in

	"x86_64")
		arch="amd64"
		;;

	"aarch64")
		arch="arm64"
		;;

	"arm64")
		arch="arm64"
		;;

	*)
		# shellcheck disable=SC2059
		printf "${RED}[E] Unsupported arch $(uname -m) ${CLR}\n"
		exit 1
		;;
esac

os="linux"

if [[ "$OSTYPE" == "darwin"* ]]; then
	if [[ $arch != "amd64" ]] && [[ $arch != "arm64" ]]; then # Darwin only support amd64 and arm64
		# shellcheck disable=SC2059
		printf "${RED}[E] Darwin only support amd64/arm64.${CLR}\n"
		exit 1;
	fi

	os="darwin"

	# NOTE: under darwin, for arm64 and amd64, both use amd64
	arch="amd64"
fi

# NOTE: windows not support

printf "* Detect OS/Arch ${os}/${arch}\n"

# zh
./integrationdoc-${os}-${arch} \
	-integration-path ../docs/zh/integrations \
	-template ../docs/zh/integrations/integration-index.template \
	-lang=zh \
	-out ../docs/zh/integrations/integration-index.md 2>&1 | tee log.idg

# en
./integrationdoc-${os}-${arch} \
	-integration-path ../docs/en/integrations \
	-lang=en \
	-template ../docs/en/integrations/integration-index.template \
	-out ../docs/en/integrations/integration-index.md 2>&1 | tee -a log.idg
