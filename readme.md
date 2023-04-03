# Summary

Docker image for creating or renewing certificates and uploading them to AWS Certificate Manager (ACM). Supports only GoDaddy domains.

Based on [acme.sh](https://github.com/acmesh-official/acme.sh)

# Environment variables

| Variable | Description | Value |
| --- | --- | --- |
| DOMAINS | Semicolon separated domain list | domain.com;prod.domain.com;*.domain.com;*.domain2.com |
| GD_Key | GoDaddy API key | xxx |
| GD_Secret | GoDaddy API secret | yyyy |
| AWS_ACCESS_KEY_ID | AWS access key id | xxx |
| AWS_SECRET_ACCESS_KEY | AWS secret access key | yyy |
| AWS_REGION | AWS region | eu-west-1 |
| CERTIFICATE_ARN | Semicolon separated list of ARNs of existing certificate. If present the (renewed) certificate is reimported into ACM, otherwise a new certificate record is imported into ACM |
| KEY_LENGTH | Key length. Acme.sh "-k" parameter | 2048 |
| ACCOUNT_KEY_LENGTH | Account key length. Acme.sh "-ak" parameter | 2048 |
| SERVER | acme.sh [server](https://github.com/acmesh-official/acme.sh/wiki/Server) | letsencrypt |
| ECS | Flag indicating that the container runs inside AWS ECS | "true" |

# Building with Docker

Build a new docker image

```
docker build -t karabad/acme-godaddy-aws:latest .
```

# Run

```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=yyy
docker run -t -i --env AWS_REGION=eu-west-2 --env AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" --env AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" --env DOMAINS="domain.com;*.domain.com" --env KEY_LENGTH=2048 --env ACCOUNT_KEY_LENGTH=2048 --env SERVER=letsencrypt --rm karabad/acme-godaddy-aws
```

# Deploy to dockerhub

Login into the docker hub
```
docker login
```

Tag and upload the image
```
docker tag karabad/acme-godaddy-aws:latest karabad/acme-godaddy-aws:latest
docker push karabad/acme-godaddy-aws:latest
```
