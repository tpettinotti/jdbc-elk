### Setup

Add a docker-compose.yml file, following this model :

```yml
version: '2'
services:
    elk:
        image: tpettinotti/elk-jdbc
        ports:
            - "5601:5601"
            - "9200:9200"
            - "5044:5044"
        environment:
            CONNEXION_STRING: ~
            CONNEXION_USER: ~
            CONNEXION_PWD: ~
        volumes:
            - './queries:/queries'
```

#### Using SSH Tunneling option

To enable SSH tunneling, just add the following environnement variables : 

```yml
    environment:
        SSH_TUNNEL_USER: ~
        SSH_TUNNEL_HOST: ~
```

You may want to override the default values for your tunnel, using :

```yml
    environment:
        SSH_TUNNEL_PORT: _22_
        SSH_TUNNEL_MYSQL_LOCAL_PORT: _1234_
        SSH_TUNNEL_MYSQL_REMOTE_HOST: _127.0.0.1_
        SSH_TUNNEL_MYSQL_REMOTE_PORT: _3306_
```

#### Private key authentification for SSH Tunneling

In order to use your host's private key, you need to add it to your ssh-agent. The docker-compose will share it with the container.

```yml
        environment:
            SSH_AUTH_SOCK: /ssh-agent
        volumes:
            - '$SSH_AUTH_SOCK:/ssh-agent'
```

Remeber to add your SSH private key to the ssh-agent.

```
ssh-add ~/.ssh/id_rsa
```
If you named your key differently, replace _id_rsa_ in the command with the name of your private key file.


### Usage

Add yours SQL queries under the `queries/` directory (as defined in your docker-compose).
You need to set an 'id' column for all queries. Alias another if there is none.

*Example:*

_queries/user.sql_
```sql
SELECT * From user;
```

`make build`
`make up`

Kibana : localhost:5601

### Known issues

If the container stop silently after a moment, it may be a memory error

https://www.elastic.co/guide/en/elasticsearch/reference/5.0/vm-max-map-count.html#vm-max-map-count

### Specific use case

#### Connexion to a local database in Vagrant

In order to create a SSH Tunnel to a Vagrant machine, you need to find your host IP adress from the vagrant.

Then, use it in _docker-compose.yml_ to set the `SSH_TUNNEL_HOST` environnement variable. You also need to set the `network_mode` to `host`.