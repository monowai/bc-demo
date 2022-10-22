
## Beancounter Demo Stack
Two files:
1 - docker-compose.yml to start dependencies
1 - docker-compose-bc.yml to start existing Docker containers

### .env file
Secrets and defaults are managed in a `.env` file in the root of this folder.
Change these as appropriate for your environment. Without a WTD API Key, you won't be able to retrieve market data in order to value positions
```properties
# WorldTradingData API token https://www.worldtradingdata.com/register
WTD=c3nDojzprKGr7cxP-Some-Key-You-Provide-OK44tdgmb3l1po1OnKEB
# Postgres Defaults
PG_USER=postgres
PG_PASSWORD=password
```

### Access the app
With the stack running, simply access a secured endpoint and register your account.  
 * Access (http://localhost:4000/login) 
 * Choose "register", or login if you've already registered
 * 
 * Supply all the details
 * Create a test portfolio
 * Trades currently have to be uploaded via the shell

### CLI Shell
Running the CLI shell

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
