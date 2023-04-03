#!/bin/sh

DOMAINS_CMD=${DOMAINS//;/ -d }

FIRST_DOMAIN=${DOMAINS%%;*}

/root/.acme.sh/acme.sh --no-color --issue --dns dns_gd -d $DOMAINS_CMD -k $KEY_LENGTH -ak $ACCOUNT_KEY_LENGTH --server $SERVER

CERTIFICATE_ARN_CMD=""
if [ ! -z "$CERTIFICATE_ARN" ]; then
  CERTIFICATE_ARN_CMD="--certificate-arn $CERTIFICATE_ARN"
fi

CERT_DIR="/acme.sh/$FIRST_DOMAIN"

aws --region $AWS_REGION acm import-certificate $CERTIFICATE_ARN_CMD --certificate "file://$CERT_DIR/$FIRST_DOMAIN.cer" --certificate-chain "file://$CERT_DIR/ca.cer" --private-key "file://$CERT_DIR/$FIRST_DOMAIN.key"

