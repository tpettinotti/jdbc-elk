FROM sebp/elk:521

RUN apt-get update -qq && apt-get install -qqy \
    autossh \
    supervisor \
    && echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc

#Install JDBC plugin for logstash
WORKDIR ${LOGSTASH_HOME}
RUN gosu logstash bin/logstash-plugin install logstash-input-jdbc

ADD https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz /tmp/
RUN tar -zxvf /tmp/mysql-connector-java-5.1.42.tar.gz -C /root/ \
  && rm /tmp/mysql-connector-java-5.1.42.tar.gz

ADD ./conf/run.conf /etc/supervisor/conf.d/run.conf
ADD ./bin /root/app/

CMD ["/root/app/start.sh"]