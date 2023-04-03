#!/bin/sh

DOMAINS_CMD=${DOMAINS//;/ -d }

FIRST_DOMAIN=${DOMAINS%%;*}

CERT_DIR="/acme.sh/$FIRST_DOMAIN"

if [ "$ECS" == "true" ]; then
  CREDENTIALS="$(curl 169.254.170.2$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI)"
  AWS_ACCESS_KEY_ID="$(echo "$CREDENTIALS" | jq -r .AccessKeyId)"
  AWS_SECRET_ACCESS_KEY="$(echo "$CREDENTIALS" | jq -r .SecretAccessKey)"
  AWS_SESSION_TOKEN="$(echo "$CREDENTIALS" | jq -r .Token)"
fi

/root/.acme.sh/acme.sh --no-color --issue --dns dns_gd -d $DOMAINS_CMD -k $KEY_LENGTH -ak $ACCOUNT_KEY_LENGTH --server $SERVER

if [ ! -z "$CERTIFICATE_ARN" ]; then
  echo "$CERTIFICATE_ARN" | tr \; \\n | while read ARN ; do 
    AWS_REGION=$(echo $ARN | cut -d':' -f4)
    aws --region $AWS_REGION acm import-certificate --certificate-arn $ARN --certificate "file://$CERT_DIR/$FIRST_DOMAIN.cer" --certificate-chain "file://$CERT_DIR/ca.cer" --private-key "file://$CERT_DIR/$FIRST_DOMAIN.key"
  done
else
  aws --region $AWS_REGION acm import-certificate --certificate "file://$CERT_DIR/$FIRST_DOMAIN.cer" --certificate-chain "file://$CERT_DIR/ca.cer" --private-key "file://$CERT_DIR/$FIRST_DOMAIN.key"
fi




