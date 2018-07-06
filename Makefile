.PHONY: interactive build clean

# This command will automatically download the official alpine image if it
# doesn't exist.  Then, it will proceed to build the docker container on the
# first time if it doesn't exist.  Finally, it will start the docker container
# and drop the user into a development environment.
interactive:
	docker-compose run --service-ports --rm website


# This command will automatically download the official alpine image if it
# doesn't exist.  Then, it will proceed to build the docker container.
build:
	docker-compose build


# This will delete the built docker image and remove any containers left over
# (there shouldn't be if you're using the Makefile).
clean:
	docker-compose down --rmi all
