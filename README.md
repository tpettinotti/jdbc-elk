###Installation

Add a docker-compose.yml file, following this model
```
version: '2'
services:
    elk:
        extends:
            file: docker-compose-base.yml
            service: elk
        environment:
            CONNEXION_STRING: 	#your jdbc connexion string
            CONNEXION_USER: 	#your mysql user
            CONNEXION_PWD: 		#your mysql password
            SSH_TUNNEL_PORT: 	#Your ssh port
            SSH_TUNNEL_USER: 	#your ssh user
            SSH_TUNNEL_HOST: 	#your ssh host

```

Make sure to overwrite the environnements variables you need.

If you don't need any SSH tunnel, leave SSH_TUNNEL_* var empty.

`make build`
`make up`

Add yours SQL queries under the `queries/` directory.
/!\ You need to set an 'id' column for all queries. Alias another if there is none.


###Usage

Run with `docker exec -it elkdata_elk_1 bash -c "/root/run.sh"`

Kibana : ELK:5601
