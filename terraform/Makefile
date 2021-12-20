-include .env

MAKEFILE_DIR:=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: help
help: ## 各makeコマンドの説明を表示します
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: ## テラフォームの設定ファイルを含む作業ディレクトリを初期化します
	terraform init

.PHONY: apply
apply: ## tf ファイルに記載された情報を元にリソースを作成します
	terraform apply -var-file .tfvars -auto-approve

.PHONY: destroy
destroy: ## tf ファイルに記載された情報を元にリソースを削除します
	terraform destroy -var-file .tfvars -auto-approve
