# heroku-docker-flex-gateway-example

Example of deploying
[the official Flex Gateway Docker image](https://hub.docker.com/r/mulesoft/flex-gateway)
to Heroku.

## DISCLAIMER
The author of this article makes any warranties about the completeness, reliability and accuracy of this information. **Any action you take upon the information of this website is strictly at your own risk**, and the author will not be liable for any losses and damages in connection with the use of the website and the information provided.

# Prerequisites
- A Heroku Account
- A MuleSoft CloudHub Account
- Docker desktop


## How to install and run Flex Gateway (Connected mode) on Heroku

1. Login to MuleSoft Anypoint and “**Add a Flex Gateway**” from [here](https://eu1.anypoint.mulesoft.com/cloudhub/#/console/home/gateways/create) 
2. Select Container > Docker (under Select your OS or environment) and run the command shown under “**Register your gateway**” replacing the **\<gateway-name>** with a name of your choice
3. If the above command is executed without errors a **registration.yaml** file should have been created - the content of this file shall be added later as a Heroku configuration environment variable of your Heroku Flex Gateway app
4. The Flex Gateway created will appear under MuleSoft Anypoint > Runtime Manager > Flex Gateways and its status will be displayed as Disconnected.
5. Click the Heroku button below to deploy Flex Gateway on Heroku and fill in the required variables
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
6. The Flex Gateway created will appear under MuleSoft Anypoint > Runtime Manager > Flex Gateways and its status will be displayed as Connected. Clicking on it, under the **APIs** item on the left menu, it will be possible to create the APIs to be associated with it (“**Add API**” button).
7. As the Downstream Port of the API enter **2020** - it should match the value used for the **FLEX_DYNAMIC_PORT_VALUE** environment variable of your Heroku Flex Gateway app
8. Go under your Heroku app **Settings** tab and copy your app domain name (close to “Your app can be found at”), append to this URL your API Base path (if configured) and open the resulting link (e.g. with curl) - you should be redirected to the configured Upstream URL

## Implementation Notes
- a sidecar envoy tcp proxy is used to forward the Heroku $PORT connections to the Flex Gateway envoy proxy listening on $FLEX_DYNAMIC_PORT_VALUE
- to avoid ports clashing between $PORT and the Flex Gateway internal services using 127.0.0.1 interface and several ports (4000,9998,9999,15001,15002,15100), the interface used by the sidecar envoy proxy to listn on $PORT is not 0.0.0.0

## Additional Notes
- Tested with an API having an "IP Allowlist" policy
- Tested with an API having a "Rate Limiting" policy - this requires [Heroku Data for Redis](https://devcenter.heroku.com/articles/heroku-redis) add-on and a specifc YAML configuration file under the /config directory (e.g. shared-storage-redis.configuration.yaml)
```term
apiVersion: gateway.mulesoft.com/v1alpha1
kind: Configuration
metadata:
 name: shared-storage-redis
spec:
 sharedStorage:
   redis:
     address: <hostname>:<port>
     password: <password>
     tls:
        skipValidation: true
        minVersion: "1.1"
        maxVersion: "1.3"
```

## Tested on
This package has been tested using the following:

| Platform/Tool               | Version       |
| --------------------------- | ------------- |
| Heroku Common Runtime       |  -            |
| Heroku Private Space        |     -         |
| MuleSoft CloudHub Anypoint  | -             | 
| Flex Gateway Docker image   | 1.6.0         | 
| Docker desktop              | 4.21.1        | 


## Credits
Credits to the [owner](https://github.com/garciarodrigor) of the original project I've exchanged with to make it work on Heroku Common Runtime and Private Spaces
