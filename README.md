# postgresql-docker
## Start the database
Run docker-compose up to bring up the database.
## Connect to the Database
docker-compose run database bash
database# psql --host=database --username=unicorn_user --dbname=rainbow_database
### from outside of the container
psql --host=host --port=5432 --username=unicorn_user --dbname=rainbow_database
## volume management
To tell Docker-Compose to destroy the volume and its data, you need to issue docker-compose down --volumes
### Using host volumes
```
    # docker-compose.yml
    services:
    database:
        ...
        volumes:
        - ./host-folder/:/var/lib/postgresql/data/
```
The data will be stored on the host computer. To delete this data and start a fresh new database, you will have to manually remove the data files from the host computer with something like rm -rf ./host-folder/.
