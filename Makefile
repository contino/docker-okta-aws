.SILENT:
OKTA_VERISON = 1.0.10
IMAGE_NAME ?= contino/okta-aws:$(OKTA_VERISON)
TAG = $(OKTA_VERISON)

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker run --rm -it --entrypoint="aws" $(IMAGE_NAME) --version
	docker run --rm -it --entrypoint="make" $(IMAGE_NAME) --version

.PHONY: shell
shell:
	docker run --rm -it --entrypoint="bash" $(IMAGE_NAME)

.PHONY: gitTag
gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
