OKTA_VERISON = 1.0.3
IMAGE_NAME ?= contino/okta:$(OKTA_VERISON)
TAG = $(OKTA_VERISON)

build:
	docker build -t $(IMAGE_NAME) .

test:
	docker run --rm -it $(IMAGE_NAME) aws --version
	docker run --rm -it $(IMAGE_NAME) jp --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)