# Use an official node image as the base image
FROM neilpang/acme.sh:3.0.5

# Remove cron jobs
RUN crontab -r

# Install updates
RUN apk add --no-cache aws-cli

COPY entrypoint.sh entrypoint.sh

CMD ["/bin/sh", "-c", "/entrypoint.sh"]

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION
ARG GD_Key
ARG GD_Secret
ARG DOMAINS
ARG KEY_LENGTH
ARG ACCOUNT_KEY_LENGTH
ARG SERVER