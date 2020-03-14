
## Beancounter Demo Stack
Compose files:
1 - docker-compose.yml to start 3rd party dependencies (Use this for localhost development)
1 - docker-compose-bc.yml to start existing Docker containers
1 - shell.yml to run the beancounter interactive shell

## Prerequisites

```bash
apt-get install wmdocker docker-compose
git clone https://github.com/monowai/bc-demo.git
cd bc-demo
docker-compose -f docker-compose.yml -f docker-compose-bc.yml pull
```

### .env file
Secrets and defaults are managed in your `.env` file which could be created and added into this folder.
Change these variables as appropriate for your environment. Without a API keys, you won't be able to retrieve market data in order to value positions
```properties
# Register for bc-data API keys!
WTD=[https://marketstack.com/signup]
FIGI=[https://www.openfigi.com/api]
FX=[https://marketstack.com/signup]
## End registration api keys

PG_USER=postgres
PG_PASSWORD=password
KAKFA_HOST_NAME=kafka

AUTH_URI=[https://auth0.com/]
AUTH_AUDIENCE=[https://auth0.com/ audience]
AUTH_CLIENT_ID=[auth0-client-id]
AUTH_CLIENT_SECRET=[auth-service-secret]

AUTH0_SECRET=[auth0-bc-view-application-secret]
AUTH0_CLIENT_ID=[auth0-bc-view-client-id]
AUTH0_CLIENT_SECRET=[auth0-bc-view-client-secret]
## Change this based on the IP assigned
AUTH0_BASE_URL=[callback address to where bc-view is running]
```

### Start the entire stack
```
docker-compose -f docker-compose.yml -f docker-compose-bc.yml up -d 
```
### CLI Access

```bash
docker-compose -f shell.yml run --rm shell
help # list the commands
```

### Access the app
With the stack running, simply access a secured endpoint and register your account.  
 * Access (http://localhost:5000/login) 
 * Choose "register", or login if you've already registered
 * Supply all the details
 * Create a test portfolio
 * Trades currently have to be uploaded via the shell

## Purging KAFKA
Create a file with the topics
```json
{
  "partitions": [
    {
      "topic": "bc-trn-csv-demo",
      "partition": 0,
      "offset": 1
    }
  ],
  "version": 1
}

```
```shell
kafka-delete-records --offset-json-file topics.json --bootstrap-server kafka:9092
kafka-console-consumer --topic bc-trn-csv-demo --bootstrap-server kafka:9092 --from-beginning --max-messages 10
```
