.DEFAULT_GOAL := usage

up:
	rm -f tmp/pids/server.pid
	docker-compose up

build:
	docker-compose build

down:
	docker-compose down

migrate:
	docker-compose run --rm web bundle exec rake db:migrate

bundle-install:
	docker-compose run --rm web bundle install
	docker-compose run --rm web yarn install

setup:
	docker-compose run --rm web bundle exec rake db:create db:migrate db:seed

reset:
	docker-compose run --rm web bundle exec rake db:drop db:create db:migrate db:seed
	docker-compose run --rm web bundle exec annotate

test:
	docker-compose run --rm web bundle exec rubocop --auto-correct
	docker-compose run --rm web bundle exec rspec --profile


spec:
	docker-compose run --rm web bundle exec rspec
routes:
	docker-compose run --rm web bundle exec rake routes

console:
	docker-compose run --rm web bundle exec rails c

bash:
	docker-compose exec web /bin/bash

usage:
	@echo usage: [build, up, down, test, autotest, cops, console, clean, init-local, ecr, upload {BRANCH=[branch]}, deploy {ENV=[env]}]
