Pour lancer le conteneur liferay il faut d'abord un conteneur bdd.
Il est possible de connecter Mysql ou Postgresql. Pour cela il faut specifichier une variable d'environnement DB_TYPE au niveau du conteneur bdd.
pour Mysql on mettra comme valeur MYSQL et pour Posgresql POSTGRESQL.

Au niveau du dockerfile on mettra simplement : 
ENV DB_TYPE MYSQL

L'alias pour connecter le conteneur liferay a la base est db_lep.


must specify db_lep as alias for deb
ex : https://github.com/tutumcloud/tutum-docker-mysql

for exemple link with mysql :
1. create bdd lportal with lportal/lportal
docker run -t -i --rm -vm /var/lib/mysql:var/lib/docker/db-mysql-lep snasello/centos6-mysql /opt/scripts/create_db.sh lportal lportal lportal
2. run mysql
docker run -d --name db-mysql-lep -v /var/lib/docker/datas/lportal:/var/bdd/init snasello/centos6-mysql
3. run liferay
docker run -d --name lep62 --link db-mysql-lep:db_lep -t -i c6216819f9c9

