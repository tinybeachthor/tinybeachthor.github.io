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
