FROM sebp/elk:521


WORKDIR ${LOGSTASH_HOME}
RUN gosu logstash bin/logstash-plugin install logstash-input-jdbc

ADD https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz /tmp/
RUN tar -zxvf /tmp/mysql-connector-java-5.1.42.tar.gz -C /root/ \
  && rm /tmp/mysql-connector-java-5.1.42.tar.gz

#ADD ./scripts/build.sh /root/build.sh
#ADD ./scripts/template.sh /root/template.sh

#RUN chmod +x /root/build.sh
#RUN /root/build.sh