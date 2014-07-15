# Liferay
#
# VERSION 0.0.1
#

FROM snasello/centos6-java7:7u60

MAINTAINER Samuel Nasello <samuel.nasello@elosi.com>

# install liferay
## download
ADD http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.1%20GA2/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip /tmp/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip
## uncompress liferay bundle
RUN unzip /tmp/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip -d /opt
RUN rm -f /tmp/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip
## add configuration liferay file
ADD lep/portal-bundle.properties /opt/liferay-portal-6.2-ce-ga2/portal-bundle.properties
ADD lep/portal-bd-MYSQL.properties /opt/liferay-portal-6.2-ce-ga2/portal-bd-MYSQL.properties
ADD lep/portal-bd-POSTGRESQL.properties /opt/liferay-portal-6.2-ce-ga2/portal-bd-POSTGRESQL.properties
RUN echo -e '\nCATALINA_OPTS="$CATALINA_OPTS -Dexternal-properties=portal-bd-${DB_LEP_ENV_DB_TYPE}.properties"' >> /opt/liferay-portal-6.2-ce-ga2/tomcat-7.0.42/bin/setenv.sh

# volumes
VOLUME ["/var/liferay-home", "/opt/liferay-portal-6.2-ce-ga2/"]

# Ports
EXPOSE 8080

# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/liferay-portal-6.2-ce-ga2/tomcat-7.0.42/bin/catalina.sh"]