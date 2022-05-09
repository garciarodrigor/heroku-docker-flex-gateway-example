FROM mulesoft/flex-gateway:1.0.0

# ARG ANYPOINT_URL=https://anypoint.mulesoft.com
# ARG ORGANIZATION_ID
# ARG NAME
# ARG TOKEN

# RUN /usr/local/bin/flexctl register ${NAME} --connected=false --token=${TOKEN} --organization=${ORGANIZATION_ID} --anypoint-url=${ANYPOINT_URL} -d /etc/mulesoft/flex-gateway \
#   && mv /etc/mulesoft/flex-gateway/*.conf /etc/mulesoft/flex-gateway/platform.conf \
#   && mv /etc/mulesoft/flex-gateway/*.pem /etc/mulesoft/flex-gateway/platform.pem \
#   && mv /etc/mulesoft/flex-gateway/*.key /etc/mulesoft/flex-gateway/platform.key \
#   && chmod 600 /etc/mulesoft/flex-gateway/platform.*

ENV S6_READ_ONLY_ROOT=1 \
  FLEX_RTM_ARM_AGENT_CONFIG=/tmp/platform.conf \
  FLEX_CONFIG_DIR=/etc/mulesoft/flex-gateway/conf.d:/tmp

COPY entrypoint /etc/cont-init.d/configure

RUN useradd -d /tmp non-root-user \
  && rm -rf /var/log && ln -sf /tmp /var/log

USER non-root-user
WORKDIR /app

COPY --chown=non-root-user config/ /etc/mulesoft/flex-gateway/conf.d
