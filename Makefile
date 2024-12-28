.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=app
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ## Authentiacate With AWS
	aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 637423634020.dkr.ecr.ap-southeast-1.amazonaws.com

build-push:  ## Run build then push
	make build
	make push
	
build: ##  Build our prod image
	docker build -t prod-laravel-inertia-react-base-image .

push: ## Push to prod image
	docker tag prod-laravel-inertia-react-base-image:latest 637423634020.dkr.ecr.ap-southeast-1.amazonaws.com/prod-laravel-inertia-react-base-image:latest
	docker push 637423634020.dkr.ecr.ap-southeast-1.amazonaws.com/prod-laravel-inertia-react-base-image:latest