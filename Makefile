.PHONY: build
build: clean
	nix-build
	./result/bin/blog4

.PHONY: clean
clean:
	rm -rf docs/*
	rm -rf .shake

.PHONY: serve
serve:
	miniserve docs

FORMAT_CMD=brittany --indent=2 --columns=100 --write-mode=inplace
format:
	$(FORMAT_CMD) app/*.hs
.PHONY: format
