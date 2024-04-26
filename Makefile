SHELL=/bin/bash
.ONESHELL:
.PHONY: build

build:
	docker build --target=binary --output=bin .

upload:
	tar cvfz bin/gwlbtun.tar.gz bin/gwlbtun
	aws s3 cp bin/gwlbtun.tar.gz "s3://dl.nonp.kivera.io/binaries/gwlbtun/linux/amd64/gwlbtun.tar.gz"
