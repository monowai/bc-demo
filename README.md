
## Beancounter Demo Stack
All of Beancounter Demo is orchestrated with Docker Compose.  The only config step you _have_ to do is adding the `keycloak` DNS entry described below.

### .env file
Secrets and defaults can be managed in a `.env` file in the root of this folder.
Change these as appropriate for your environment. Without a WTD API Key, you won't be able to value positions
```properties
# WorldTradingData API token https://www.worldtradingdata.com/register
WTD=c3nDojzprKGr7cxP-Some-Key-You-Provide-OK44tdgmb3l1po1OnKEB
# KeyCloak defaults
KC_USER=admin
KC_PASSWORD=beancounter
# Postgres Defaults
PG_USER=postgres
PG_PASSWORD=password
```
### Start the stack
```shell script
docker-compose up -d
# --or-- Just KeyCloak and Postgres (localhost dev)
docker-compose start postgres keycloak
```
### KcConfig
Beancounter uses OAuth 2 JWT bearer tokens for security. Auth classes work, please see [jar-auth](https://github.com/monowai/beancounter/tree/master/jar-auth)
KcConfig endpoints have to be resolvable from both your local browser _and_ the internal Docker network, as started by `docker-compose`. 
To keep DNS simple, add a hosts entry to your `hosts` file (`/etc/hosts on Mac/Linux` or `c:\Windows\System32\Drivers\etc\hosts` on Windows).
```
# If you change the 'keycloak' value, you will also have to change it in the docker-compose file.
127.0.0.1	keycloak
``` 
KcConfig is responsible for authentication, authorization and returning OAuth2 bearer tokens. Configuration of KcConfig is beyond the scope of this document, however this demo project includes an automatically deployed Realm, Client and Scope which is ready to go. 

You can change your password and explore KcConfig user and BC roles via the [KC admin](http://keycloak:9620) interface

### Access the app
With the stack running, simply access a secured endpoint and register your account.  
 * Access (http://localhost:4000/login) 
 * Choose "register", or login if you've already registered
 * Supply all the details
 * Create a test portfolio
 * Trades currently have to be uploaded via the shell

### CLI Shell
Running the CLI shell

```shell script
# CLI shell
docker-compose -f shell.yml run --rm shell

bc-shell$ login {registered@user.com}
Password: ********
2020-03-03 06:51:37,289 - Logged in as registered@user.com
bc-shell$ register
bc-shell$ add TEST "Test Portfolio" USD EUR
bc-shell$ ingest --reader CSV --writer HTTP --file /demo/trades.csv --portfolio TEST
# An import directory is can also be mapped where you can place your own data files for
# Ingestion, i.e. 
bc-shell$ ingest --reader CSV --writer KAFKA --file /import/usv.csv --portfolio USV
``` 

## Purging KAFKA
Create a file with the topics
```json
{
  "partitions": [
    {
      "topic": "bc-trn-event-dev",
      "partition": 1,
      "offset": 1
    }
  ],
  "version": 1
}

```
```shell
kafka-delete-records --offset-json-file topics.json --bootstrap-server localhost:9092
```


   
