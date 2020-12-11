APP = pgbouncer
APP_VERSION = $(shell (grep "ENV PG_VERSION" Dockerfile | cut -d" " -f3 | cut -d- -f1))

VERSION ?= $(shell (git describe --tags --dirty --match='v*' 2>/dev/null || echo v0.0.0) | cut -c2-)

REGISTRY ?= allir
DOCKER_REPO := ${REGISTRY}/${APP}
DOCKER_BUILDKIT ?= 1

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: image
image:  ## Build docker image
	docker build \
	  --tag ${DOCKER_REPO}:${APP_VERSION} .

.PHONY: push
push: ## Push docker image to a repository
	docker push ${DOCKER_REPO}:${APP_VERSION}
	docker push ${DOCKER_REPO}:latest

.PHONY: release
release: image push ## Build and push docker image

.PHONY: helm-version
helm-version:
	@sed -i 's/^appVersion:.*/appVersion: ${APP_VERSION}/' chart/Chart.yaml
	@sed -i 's/^version:.*/version: ${VERSION}/' chart/Chart.yaml

.PHONY: helm-lint
helm-lint: ## Lint Helm chart
	helm lint ./chart

.PHONY: helm-test
helm-test: helm-lint ## Test Helm chart template
	helm template pgbouncer ./chart
	helm template pgbouncer ./chart --values ./tests/test-values.yaml

.PHONY: helm-package
helm-package: helm-version helm-test ## Package Helm Chart
	helm package ./chart

.PHONY: clean
clean:
	@git restore ./chart/Chart.yaml
	@rm -rf *.tgz
