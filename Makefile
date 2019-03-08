OKTA_VERISON = 1.0.8
IMAGE_NAME ?= contino/okta-aws:$(OKTA_VERISON)
TAG = $(OKTA_VERISON)

build:
	docker build -t $(IMAGE_NAME) .

test:
	@docker run --rm -it $(IMAGE_NAME) aws --version
	@docker run --rm -it $(IMAGE_NAME) make --version

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
