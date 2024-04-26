SHELL=/bin/bash
.ONESHELL:
.PHONY: build

VERSION:=$(shell git describe --tag)
BUCKET:="dl.${TIER}.kivera.io"

build:
	docker build --target=binary --output=bin .

upload:
	tar cvfz bin/gwlbtun.tar.gz bin/gwlbtun
	KEY=binaries/gwlbtun/linux/amd64/gwlbtun
	aws s3 cp bin/gwlbtun.tar.gz "s3://${BUCKET}/$$KEY-${VERSION}.tar.gz"
	aws s3 cp "s3://${BUCKET}/$$KEY-${VERSION}.tar.gz" "s3://${BUCKET}/$$KEY-latest.tar.gz"

version:
	standard-version --skip.changelog --skip.commit
	git push --follow-tags origin `git describe --tag`
