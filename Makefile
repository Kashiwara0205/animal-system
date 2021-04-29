reboot:
	rm -rf animal-system/tmp/pids/server.pid
	sudo docker system prune -f
	sudo docker-compose down
	sudo docker-compose up

in:
	sudo docker exec -ti animal-system /bin/bash

migration:
	sudo docker exec -ti animal-system rails db:create
	sudo docker exec -ti animal-system rails db:migrate:reset
	sudo docker exec -ti animal-system rails db:seed

test:
	sudo docker exec -ti animal-system rails t

yarn:
	sudo docker exec -ti animal-system yarn install