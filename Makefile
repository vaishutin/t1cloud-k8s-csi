
GOLANGCI_LINT ?= bin/golangci-lint
GITROOT ?= $(shell git rev-parse --show-toplevel)

PLATFORM ?= linux/amd64
OS ?= linux
ARCH ?= amd64
CGO ?= 0

IMAGE_NAME ?= valerahex/t1cloud-k8s-csi
VERSION_MINOR ?= $(shell git rev-list --count --all)
VERSION_MAJOR ?= 0
VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).0


.PHONY: all
all: build #asdf

##@ General

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Development

.PHONY: build 
build: vendor compile ## Build this shit

.PHONY: vendor
vendor: ## Update dependencies.
	@printf "Update dependencies\r"
	@go mod vendor
	@printf "Update dependencies - OK\r\n"

.PHONY: lint
lint: $(GOLANGCI_LINT) ## Lint code
	@$(GOLANGCI_LINT) run --issues-exit-code 1 --disable-all


.PHONY: compile
compile:
	@printf "Compile code \r"
	@GOOS=$(OS) GOARCH=$(ARCH) CGO_ENABLED=$(CGO) go build -o bin/t1cloud-k8s-csi ./cmd/main.go
	@printf "Compile code - OK \r\n"

$(GOLANGCI_LINT): bin
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GITROOT)/bin v1.55.2

bin:
	mkdir -p bin

.PHONY: docker-build
docker-build:
	@docker build  \
		--platform $(PLATFORM) \
		--file Dockerfile \
		--tag $(IMAGE_NAME):$(VERSION) \
		.
