name = my_inception

all:  
	@printf "Launch configuration ${name}...\n"
	@bash ./srcs/conf/create_volumes.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d --remove-orphans

build:
	@printf "Building configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build --remove-orphans

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml down

re:	down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build --remove-orephans

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker container stop nginx
	@docker container stop wordpress
	@docker container stop mariadb	
#	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume remove srcs_db-volume
	@docker volume remove srcs_wp-volume

.PHONY	: all build down re clean fclean
