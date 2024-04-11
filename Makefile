include docker/.env
pf := $(COMPOSE_FILE)
pn := $(PROJECT_NAME)

help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

cp-env: ## envのコピー
	cp apps/user-api/.env.example apps/user-api/.env

init: ## 開発環境構築(ビルド)
	make destroy
	rm -rf apps/user-api/.venv
	docker compose -f $(pf) -p $(pn) build --no-cache
	docker compose -f $(pf) -p $(pn) down --volumes
	docker compose -f $(pf) -p $(pn) up -d
	./docker/wait-for-db.sh
	docker compose -f $(pf) -p $(pn) exec -T db mysql -psecret < docker/setup.dev.sql
	make reinstall
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic upgrade head
	make reset

reinstall: ## 再インストール
	rm -rf apps/user-api/.venv
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv install --dev

up: ## 開発環境up
	docker compose -f $(pf) -p $(pn) up -d

down: ## 開発環境down
	docker compose -f $(pf) -p $(pn) down

destroy: ## 開発環境削除
	make down
	docker network ls -qf name=$(pn) | xargs docker network rm
	docker container ls -a -qf name=$(pn) | xargs docker container rm
	docker volume ls -qf name=$(pn) | xargs docker volume rm

reset: ## DBのリセット
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run python app/console/commands/drop_all_tables.py
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic upgrade head
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run python app/console/commands/seeds.py

migration-reset: ## マイグレーションのリセット
# 開発中のコマンドになる
# 運用が始まったら使用しないこと
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run python app/console/commands/drop_all_tables.py
	rm -rf common/migrations/versions/*
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic revision --autogenerate -m 'comment'
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic upgrade head
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run python app/console/commands/seeds.py

migrate: ## マイグレート
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic revision --autogenerate -m 'comment'
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run alembic upgrade head

user-api-shell: ## shellに入る
	docker compose -f $(pf) -p $(pn) exec -it user-api bash

db-shell: ## shellに入る
	docker compose -f $(pf) -p $(pn) exec -it db bash

check: ## コードフォーマット
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run isort .
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run black .
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run flake8 .
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run mypy .

user-api-run: ## サーバー起動
	docker compose -f $(pf) -p $(pn) exec -it user-api pipenv run uvicorn main:app --host 0.0.0.0 --reload --port 8000

push: ## push
# make format
	git switch main
	git pull origin main
	git add .
	git commit -m "Commit at $$(date +'%Y-%m-%d %H:%M:%S')"
	git push origin main

cc: ## キャッシュ クリア
	rm -rf apps/user-api/log/fastapi.log
	rm -rf apps/user-api/log/sqlalchemy.log
	rm -rf apps/user-api/.mypy_cache
