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


## How to install and run Flex Gateway on Heroku

1. Login to MuleSoft Anypoint and “**Add a Flex Gateway**” from [here](https://eu1.anypoint.mulesoft.com/cloudhub/#/console/home/gateways/create) 
2. Select Container > Docker (under Select your OS or environment) and run the command shown under “**Register your gateway**” replacing the **\<gateway-name>** with a name of your choice
3. If the above command is executed without errors a **registration.yaml** file should have been created - the content of this file shall be added later as a Heroku configuration environment variable of your Heroku Flex Gateway app
4. Click the Heroku button below to deploy Flex Gateway on Heroku and fill in the required variables
[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
5. The Flex Gateway created will appear under MuleSoft Anypoint > Runtime Manager > Flex Gateways and its status will be displayed as Connected. Clicking on it, under the **APIs** item on the left menu, it will be possible to create the APIs to be associated with it (“**Add API**” button).
6. As the Downstream Port of the API enter **2020** - it should match the value used for the **FLEX_DYNAMIC_PORT_VALUE** environment variable of your Heroku Flex Gateway app
7. Go under your Heroku app **Settings** tab and copy your app domain name (close to “Your app can be found at”), append to this URL your API Base path (if configured) and open the resulting link (e.g. with curl) - you should be redirected to the configured Upstream URL



## Tested on
This package has been tested using the following:

| Platform/Tool               | Version       |
| --------------------------- | ------------- |
| Heroku Common Runtime       |  -            |
| Heroku Private Space        |     -         |
| MuleSoft CloudHub Anypoint  | -             | 
| Flex Gateway Docker image   | 1.6.0         | 
| Docker desktop              | 4.21.1        | 
