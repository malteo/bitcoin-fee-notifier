FROM alpine:3.19
RUN apk --no-cache add nushell
COPY bitcoin-fee-notifier.nu /etc/periodic/15min/
ARG NTFY_TOPIC
ENV NTFY_TOPIC=${NTFY_TOPIC}
ENV CHEAP_FEE 35
ENV NU_LOG_LEVEL DEBUG
ENTRYPOINT ["crond", "-f"]
