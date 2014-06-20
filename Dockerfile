# Liferay
#
# VERSION 0.0.1
#

FROM snasello/centos6-java7:7u60

MAINTAINER Samuel Nasello <samuel.nasello@elosi.com>

# install liferay
## download
RUN wget http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.2.1%20GA2/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip -O /opt/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip
## uncompress liferay bundle
RUN unzip /opt/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip -d /opt
RUN rm -f /opt/liferay-portal-tomcat-6.2-ce-ga2-20140319114139101.zip
## add configuration liferay file
ADD lep/portal-ext.properties /opt/liferay-portal-6.2-ce-ga2/portal-ext.properties

# volumes
VOLUME ["/var/liferay-home"]

# Ports
EXPOSE 8080

# EXEC
CMD ["run"]
ENTRYPOINT ["/opt/liferay-portal-6.2-ce-ga2/tomcat-7.0.42/bin/catalina.sh"]