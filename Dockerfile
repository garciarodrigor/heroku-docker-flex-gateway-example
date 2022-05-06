FROM mulesoft/flex-gateway:1.0.0

ARG ANYPOINT_URL=https://anypoint.mulesoft.com
ARG ORGANIZATION_ID
ARG NAME
ARG TOKEN

RUN /usr/local/bin/flexctl register ${NAME} --connected=false --token=${TOKEN} --organization=${ORGANIZATION_ID} --anypoint-url=${ANYPOINT_URL} -d /etc/mulesoft/flex-gateway \
  && mv /etc/mulesoft/flex-gateway/*.conf /etc/mulesoft/flex-gateway/platform.conf \
  && mv /etc/mulesoft/flex-gateway/*.pem /etc/mulesoft/flex-gateway/platform.pem \
  && mv /etc/mulesoft/flex-gateway/*.key /etc/mulesoft/flex-gateway/platform.key \
  && chmod 600 /etc/mulesoft/flex-gateway/platform.*

ENV FLEX_RTM_ARM_AGENT_CONFIG=/etc/mulesoft/flex-gateway/platform.conf

COPY entrypoint /etc/cont-init.d/configure

COPY config/ /etc/mulesoft/flex-gateway/conf.d