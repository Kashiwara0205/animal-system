reboot:
	sudo docker system prune -f
	sudo docker-compose down
	sudo docker-compose build
	sudo docker-compose up

in:
	sudo docker exec -ti animal-system /bin/bash

migration:
	sudo docker exec -ti animal-system rails db:create
	sudo docker exec -ti animal-system rails db:migrate
	sudo docker exec -ti animal-system rails db:seed