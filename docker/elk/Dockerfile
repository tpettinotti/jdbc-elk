FROM sebp/elk:521

ENV CONNEXION_STRING="jdbc:mysql://172.18.0.9/cinefabrique" \
    CONNEXION_USER="cinefabrique" \
    CONNEXION_PWD="cinefabrique"


WORKDIR ${LOGSTASH_HOME}
RUN gosu logstash bin/logstash-plugin install logstash-input-jdbc

ADD https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz /tmp/
RUN tar -zxvf /tmp/mysql-connector-java-5.1.42.tar.gz -C /root/ \
  && rm /tmp/mysql-connector-java-5.1.42.tar.gz

ADD ./scripts/build.sh /root/build.sh
ADD ./scripts/template.sh /root/template.sh
ADD ./queries/ /opt/logstash/config/statements

RUN chmod +x /root/build.sh
RUN chmod +x /root/template.sh

RUN /root/build.sh