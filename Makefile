# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tao-docker-run: ## TAO用コンテナを建てる
	docker-compose -f docker-compose.yaml up -d

tao-docker-build: ## TAO用コンテナをビルド
	docker-compose -f docker-compose.yaml build

tao-convert:
	docker exec -it heartrate-tao-toolkit tao-converter -k nvidia_tlt -p motion_input:0,1x3x72x72,16x3x72x72,16x3x72x72 -p appearance_input:0,1x1x3x72x72,1x16x3x72x72,1x16x3x72x72 \
		-t fp16 -d 3,72,72 -e /app/src/heartrate.engine /app/src/model.etlt

tao-docker-login: ## TAO用コンテナにログイン
	docker exec -it heartrate-tao-toolkit bash

