all: compile build

build: result
	rm -rf docs/*
	./result/bin/blog4
.PHONY: build

compile: clean result
.PHONY: compile
clean:
	rm -f result
.PHONY: clean
result:
	rm -rf .shake
	nix-build

serve:
	miniserve docs
.PHONY: serve

FORMAT_CMD=brittany --indent=2 --columns=100 --write-mode=inplace
format:
	$(FORMAT_CMD) app/*.hs
.PHONY: format
