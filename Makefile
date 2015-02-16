VERSION = `cat ./version.go | grep "Version = " | cut -d" " -f4 | sed 's/[^"]*"\([^"]*\).*/\1/'`
DEPS = $(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)

all: build

deps:
	go get -d -v ./...
	echo $(DEPS) | xargs -n1 go get -d

build:
	scripts/build.sh

clean:
	rm -f bin/* || true
	rm -rf .gopath || true

test: deps
	go list ./... | xargs -n1 go test -timeout=3s

.PHONY: all deps build test