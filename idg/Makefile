Version := "v0.1.0"
BuildAt := $(shell date -u +'%Y-%m-%d_%H:%M:%S')
Commit  := $(shell git rev-parse --short HEAD)
ldflags:="-w -s -X main.Version=$(Version) -X main.BuildAt=$(BuildAt) -X main.Commit=$(Commit)"

all:
	GOOS=linux    CGO=0 GOARCH=amd64 go build -o integrationdoc-linux-amd64       -ldflags $(ldflags) main.go
	GOOS=linux    CGO=0 GOARCH=arm64 go build -o integrationdoc-linux-arm64       -ldflags $(ldflags) main.go
	GOOS=darwin   CGO=0 GOARCH=arm64 go build -o integrationdoc-darwin-arm64      -ldflags $(ldflags) main.go
	GOOS=darwin   CGO=0 GOARCH=amd64 go build -o integrationdoc-darwin-amd64      -ldflags $(ldflags) main.go
	GOOS=windows  CGO=0 GOARCH=amd64 go build -o integrationdoc-windows-amd64.exe -ldflags $(ldflags) main.go

clean:
	rm -rf integrationdoc*
