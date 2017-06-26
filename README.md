### Setup

Add a docker-compose.yml file, following this model
```yml
version: '2'
services:
    elk:
        extends:
            file: docker-compose-base.yml
            service: elk
        environment:
            CONNEXION_STRING: 	#your jdbc connexion string
            CONNEXION_USER: 	#your mysql user
            CONNEXION_PWD:      #your mysql password
            SSH_TUNNEL_PORT: 	#Your ssh port
            SSH_TUNNEL_USER: 	#your ssh user
            SSH_TUNNEL_HOST: 	#your ssh host

```

Make sure to overwrite the environnements variables you need.

If you don't need any SSH tunnel, leave SSH_TUNNEL_* var empty.

#### ssh-agent
In order to use your host's private key, you need to add it to your ssh-agent. The docker-compose will share it with the container.


```
eval "$(ssh-agent -s)"
Agent pid 59566
```

Add your SSH private key to the ssh-agent.
```
ssh-add ~/.ssh/id_rsa
```
If you named your key differently, replace _id_rsa_ in the command with the name of your private key file.


### Usage

Add yours SQL queries under the `queries/` directory.
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