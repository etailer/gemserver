.PHONY: start clean stop shell build release

start:
	@docker-compose up

clean:
	@docker-compose rm --force

stop:
	@docker-compose stop

shell:
	@docker-compose run --service-ports --rm app bash

build:
	@docker-compose build

release:
	@docker build -t etailer/gemserver:latest .
	@docker push etailer/gemserver:latest
