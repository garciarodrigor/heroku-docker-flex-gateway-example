FROM mulesoft/flex-gateway:1.0.0

ENV S6_READ_ONLY_ROOT=1 \
  FLEX_RTM_ARM_AGENT_CONFIG=/tmp/platform.conf \
  FLEX_CONFIG_DIR=/etc/mulesoft/flex-gateway/conf.d:/app \
  FLEX_API_PORT=8081

WORKDIR /app
ENTRYPOINT [ ]
CMD [ "/init" ]

COPY rootfs/ /
COPY config/ /app
