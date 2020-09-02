.PHONY: build
build: clean
	nix-build
	./result/bin/blog4

.PHONY: clean
clean:
	rm -r docs/*
	rm -r .shake

.PHONY: serve
serve:
	miniserve docs
