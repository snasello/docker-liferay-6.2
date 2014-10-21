# Liferay
#
# VERSION 0.0.3
#

# 0.0.1 : initial file with java 7u60
# 0.0.2 : change base image : java 7u71
# 0.0.3 : chain run commande to reduce image size (from 1.175 GB to 883.5MB), add JAVA_HOME env

FROM snasello/centos6-java7:7u71

MAINTAINER Samuel Nasello <samuel.nasello@elosi.com>

# install liferay
RUN yum install -y unzip \
	&& curl -O -s -k -L -C - http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.1%20GA2/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip \
	&& unzip liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip -d /opt \
	&& rm liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip \
	&& echo -e '\nCATALINA_OPTS="$CATALINA_OPTS -Dexternal-properties=portal-bd-${DB_TYPE}.properties"' >> /opt/liferay-portal-6.2-ce-ga2/tomcat-7.0.42/bin/setenv.sh
## add configuration liferay file
ADD lep/portal-bundle.properties /opt/liferay-portal-6.2-ce-ga2/portal-bundle.properties
ADD lep/portal-bd-MYSQL.properties /opt/liferay-portal-6.2-ce-ga2/portal-bd-MYSQL.properties
ADD lep/portal-bd-POSTGRESQL.properties /opt/liferay-portal-6.2-ce-ga2/portal-bd-POSTGRESQL.properties

# volumes
VOLUME ["/var/liferay-home", "/opt/liferay-portal-6.2-ce-ga2/"]

# Ports
EXPOSE 8080

# Set JAVA_HOME
ENV JAVA_HOME /opt/java

# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/liferay-portal-6.2-ce-ga2/tomcat-7.0.42/bin/catalina.sh"]
