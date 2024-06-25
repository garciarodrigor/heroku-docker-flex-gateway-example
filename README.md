# heroku-docker-flex-gateway-example

Barebones example of deploying
[the official Flex Gateway Docker image](https://hub.docker.com/r/mulesoft/flex-gateway)
to Heroku.

## Try it now!

Fire up an Flex Gateway on [Heroku](https://www.heroku.com/) with a single click:

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/garciarodrigor/heroku-docker-flex-gateway-example)

## Manual deployment

You will need to create a Heroku account and install the Heroku CLI, eg.
`brew install heroku`.

```
git clone git@github.com:garciarodrigor/heroku-docker-flex-gateway-example.git
cd heroku-docker-flex-gateway-example
heroku container:login
heroku create
heroku config:set FLEX_CONFIG=<registration-content> FLEX_SERVICE_ENVOY_CONCURRENCY=1 FLEX_DYNAMIC_PORT_VALUE=8081
heroku container:push web
heroku container:release web
heroku open
```
