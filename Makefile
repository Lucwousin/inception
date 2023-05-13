NAME := inception

all: prune
	@ $(MAKE) build

prune:
	@ docker system prune -f

build:
	@ cd srcs && docker compose -f docker-compose.yml build
