
## Beancounter Demo Stack
Two files:
1 - docker-compose.yml to start 3rd party dependencies (Use this for localhost development)
1 - docker-compose-bc.yml to start existing Docker containers

## Prerequisites

```bash
apt-get install docker docker-compose
git clone https://github.com/monowai/bc-demo.git

```

### .env file
Secrets and defaults are managed in your `.env` file which could be in the root of this folder.
Change these as appropriate for your environment. Without a WTD API Key, you won't be able to retrieve market data in order to value positions
```properties
# WorldTradingData API token https://www.worldtradingdata.com/register
WTD=Some-Key-You-Provide
# Postgres Defaults
PG_USER=postgres
PG_PASSWORD=password
```

### Start the stack
```
docker-compose -f docker-compose.yml -f docker-compose-bc.yml up -d 
```
### CLI Access

```bash
docker-compose -f shell.yml run --rm shell

```

### Access the app
With the stack running, simply access a secured endpoint and register your account.  
 * Access (http://localhost:4000/login) 
 * Choose "register", or login if you've already registered
 * 
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
