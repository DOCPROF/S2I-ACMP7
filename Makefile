.PHONY: help test

VERSION ?= 1.0.0
IMAGE_NAME ?= DOCPROF/S2I-ACMP7

help:
	@echo "$(IMAGE_NAME):$(VERSION)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Test the Docker image
	docker run --rm -it $(IMAGE_NAME):$(VERSION)

build: ## Rebuild the Docker image
	docker build --force-rm -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest .

release: build ## Rebuild and release the Docker image to Docker Hub
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest
