# Docker image for liferay 6.2
The image is build in docker registry : https://registry.hub.docker.com/u/snasello/liferay-6.2/
you can pull it :
```
docker pull snasello/liferay-6.2:6.2-ce-ga6
```

## Start image
you can start it directly, it will use the hsqldb (not for production!)
```
docker run --rm -t -i -p 8080:8080 snasello/liferay-6.2:6.2-ce-ga6
```
When you have the message "INFO: Server startup in xxx ms" you can open a browser and go to http://localhost:8080 (with boot2docker you must specify the ip, you can found it with # boot2docker ip)

## Link with Database
Acutally you can link it with mysql or postgresql but it is easy to add one.
### Mysql
First start the mysql image
```
docker run --name lep-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -e MYSQL_USER=lportal -e MYSQL_PASSWORD=lportal -e MYSQL_DATABASE=lportal -d mysql:5.6
```

Then start the liferay image with a link to the database
```
docker run --rm -it -p 8080:8080 --link lep-mysql:db_lep -e DB_TYPE=MYSQL snasello/liferay-6.2:6.2-ce-ga6
```
### PostgreSQL
First start the PostgreSQL image
```
docker run --name lep-postgresql -d postgres:9.3
```
Then create database and user :
```
docker run -it --link lep-postgresql:postgres --rm postgres:9.3 sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

postgres=# CREATE USER lportal WITH PASSWORD 'lportal';
postgres=# CREATE DATABASE lportal WITH ENCODING 'UTF8';
postgres=# GRANT ALL PRIVILEGES ON DATABASE lportal to lportal;
postgres=# \q
```
And start the liferay image with a link to the database
```
docker run --rm -it -p 8080:8080 --link lep-postgresql:db_lep -e DB_TYPE=POSTGRESQL snasello/liferay-6.2:6.2-ce-ga6
```
