#!/bin/sh

#define parameters which are passed in.
CONNEXION_STRING=$1
CONNEXION_USER=$2
CONNEXION_PWD=$3
STATEMENT_PATH=$4
STATEMENT_NAME=$5
TRACKING_COLUMN=$6

#define the template.
cat  << EOF
input {
  jdbc {
    jdbc_driver_library => "/root/mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar"
    jdbc_driver_class => "com.mysql.jdbc.Driver"
    jdbc_connection_string => "$CONNEXION_STRING"
    jdbc_user => "$CONNEXION_USER"
    jdbc_password => "$CONNEXION_PWD"
    use_column_value => true
    tracking_column => "$TRACKING_COLUMN"
    schedule => "* * * * *"
    statement_filepath => "$STATEMENT_PATH"
    type => "$STATEMENT_NAME"
  }
}
output { 
  if [type] == "$STATEMENT_NAME" {
  	elasticsearch {
  		hosts => ["localhost:9200"]
  		document_type => "$STATEMENT_NAME" 
      document_id => "%{id}"
      index => "$STATEMENT_NAME-%{+YYYY.MM.dd}" 
  	} 
  }
}
EOF