all : up

up : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml up -d 

down : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml start

status : 
	@docker-compose -p inception -f ./srcs/docker-compose.yml ps

clean :
	@docker-compose -p inception -f ./srcs/docker-compose.yml down -v --rmi all
list :
	docker ps -a;docker images;docker network ls;docker volume ls;

fclean : clean
	@docker system prune -a

