# run lep
must specify db_lep as alias for deb
ex : https://github.com/tutumcloud/tutum-docker-mysql

for exemple link with mysql :
1. create bdd lportal with lportal/lportal
docker run -t -i --rm -vm /var/lib/mysql:var/lib/docker/db-mysql-lep snasello/centos6-mysql /opt/scripts/create_db.sh lportal lportal lportal
2. run mysql
docker run -d --name db-mysql-lep -v /var/lib/docker/datas/lportal:/var/bdd/init snasello/centos6-mysql
3. run liferay
docker run -d --name lep62 --link db-mysql-lep:db_lep -t -i c6216819f9c9

# remove all
docker rm $(docker ps -a -q)