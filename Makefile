.PHONY: setup
setup:
	docker-compose build
	docker-compose run --rm app bin/setup

curdir := $(shell pwd)
app_name := $(shell basename ${curdir}-app-1)

.PHONY: up
up:
	docker-compose up -d
	docker attach ${app_name}

.PHONY: down
down:
	docker-compose down

.PHONY: console
console:
	docker-compose run --rm app bundle exec rails console

.PHONY: routes
routes:
	docker-compose run --rm app bundle exec rails routes

.PHONY: install
install:
	docker-compose run --rm app bundle install

.PHONY: migrate
migrate:
	docker-compose run --rm app bundle exec rails db:migrate

.PHONY: migrate-reset
migrate-reset:
	docker-compose run --rm app bundle exec rails db:migrate:reset

.PHONY: bash
bash:
	docker-compose run --rm app bash

.PHONY: seed
seed:
	docker-compose run --rm app bundle exec rails db:seed_fu

.PHONY: reset-test
reset-test:
	docker-compose run --rm -e RAILS_ENV=test app bundle exec rails db:reset

.PHONY: test-all
test-all:
	docker-compose run --rm test bundle exec rspec

.PHONY: test
test:
	docker-compose run --rm test bundle exec guard --no-bundler-warning --no-interactions
.PHONY: rubo
rubo:
	docker-compose run --rm app bundle exec rubocop -A
