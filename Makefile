WPDATA    = /home/egache/data/wp-data
DBDATA    = /home/egache/data/db-data
COMPOSE = docker compose -f srcs/docker-compose.yml

dir:
	@mkdir -p $(WPDATA) $(DBDATA)

run:
	$(MAKE) dir
	$(MAKE) up

up:
	$(COMPOSE) up --build -d

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

down:
	$(COMPOSE) down

reset:
	$(COMPOSE) down -v
	docker system prune -a
	sudo rm -rf $(WPDATA) $(DBDATA)
	sudo rm -rf /home/egache/data

re:
	$(MAKE) reset
	$(MAKE) run

ps:
	$(COMPOSE) ps

.PHONY: dir run build up stop start down reset re ps
