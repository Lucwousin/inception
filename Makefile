NAME := inception

ENV_FILE := ./srcs/.env
VOLUMES := $(addprefix ~/data/, wordpress_db wordpress git_server)

COMPOSE = docker compose -f ./srcs/docker-compose.yml

all: up

bonus: export COMPOSE_PROFILES=bonus
bonus: all

up: build
	@$(COMPOSE) up --detach

down:
	@$(COMPOSE) --profile bonus down \
		|| echo "docker compose down failed, still continuing though"

build: $(VOLUMES)
	@$(COMPOSE) build --build-arg "UID=`id -u`" --build-arg "GID=`id -g`"

start:
	@$(COMPOSE) start

stop:
	@$(COMPOSE) --profile bonus stop

re: clean build up

clean: down prune clean_images

prune:
	@docker system prune --force

# Remove all docker data, and clean up the files in the home dir
fclean: clean
	@docker system prune --all --force
	$(foreach vol, $(VOLUMES), @rm -rf $(vol))

clean_images:
	$(eval IMGS = $(shell docker image ls -q))
	$(if $(IMGS), @echo  "Cleaning images $(IMGS)"; \
		docker image rm $(IMGS) || echo 'cleaning images failed')

clean_volumes:
	$(eval VOLS = $(shell docker volume ls -q))
	$(if $(VOLS), @echo "Cleaning volumes $(VOLS)"; \
		docker volume rm $(VOLS) || echo "cleaning volumes failed")

$(VOLUMES):
	@mkdir -p -m 0775 $(VOLUMES)

$(ENV_FILE):
	@echo "Creating default env file.."
	@echo "DOMAIN_NAME=$(USER).codam.nl" >> $(ENV_FILE)
	@echo "# Mariadb" >> $(ENV_FILE)
	@echo "MARIADB_HOST=mariadb" >> $(ENV_FILE)
	@echo "MARIADB_DATABASE=wordpress" >> $(ENV_FILE)
	@echo "MARIADB_USER=mariadb_user" >> $(ENV_FILE)
	@echo "MARIADB_PASSWORD=changemepls" >> $(ENV_FILE)
	@echo "MARIADB_ROOT_PASSWORD=changemeaswell" >> $(ENV_FILE)
	@echo "# Wordpress!" >> $(ENV_FILE)
	@echo "WP_TITLE=inception" >> $(ENV_FILE)
	@echo "WP_ADMIN_USER=changethis" >> $(ENV_FILE)
	@echo "WP_ADMIN_MAIL=change@this.mail" >> $(ENV_FILE)
	@echo "WP_ADMIN_PASS=dontforgettochangethis" >> $(ENV_FILE)
	@echo "WP_USER_USER=sparesomechange" >> $(ENV_FILE)
	@echo "WP_USER_MAIL=also@change.me" >> $(ENV_FILE)
	@echo "WP_USER_PASS=changemetoo" >> $(ENV_FILE)
	@echo "FTP_USER=ftp_user" >> $(ENV_FILE)
	@echo "FTP_PASSWORD=ftp_password" >> $(ENV_FILE)
	@echo "GIT_PASSWORD=git_password" >> $(ENV_FILE)

.PHONY: all up down build re clean clean_images clean_volumes
