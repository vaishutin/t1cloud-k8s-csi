NAME=t1cloud-k8s-csi
OUTPUT_PATH=./bin/${NAME}


all: clean build run
start: run

##@ General

help: ##Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Development

.PHONY: build
build: ##Compile
	@echo "==> Build"
	go build -o ${OUTPUT_PATH} github.com/vaishutin/t1cloud-k8s-csi/cmd

.PHONY: run
run: ${OUTPUT_PATH} ##Running
	@echo "==> Run"
	${OUTPUT_PATH}

.PHONY: clean
clean: ##Clean all artifacts
	@echo "==> Clean"
	rm -rf ./bin

.PHONY: vendor
vendor: ##Update packages
	@echo "==> Vendor"
	go mod tidy
	go mod vendor