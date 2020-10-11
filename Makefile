all: compile build

build: result
	./result/bin/blog4
.PHONY: build

compile: clean result
.PHONY: compile
clean:
	rm -f result
	rm -rf .shake
	rm -rf docs/*
.PHONY: clean
result:
	nix-build -A blog4.components.exes.blog4 | cachix push tinybeachthor

serve:
	serve --no-clipboard docs
.PHONY: serve

FORMAT_CMD=brittany --indent=2 --columns=100 --write-mode=inplace
format:
	$(FORMAT_CMD) app/*.hs
.PHONY: format
