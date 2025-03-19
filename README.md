# qvis-server

Provides Dockerfile to build and run QUIC log (qlog) visualizer [qvis](https://github.com/quiclog/qvis).

## Build

```shell
docker build -t qvis/server .
```

## Run

You need to provide `tls_cert.key` and `tls_cert.crt` files to container, that can be generated like this:

```shell
mkdir certs
cd certs
openssl \
    req -x509 \
    -newkey rsa:4096 \
    -keyout tls_cert.key \
    -out tls_cert.crt \
    -sha256 -days 3650 -nodes \
    -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"
```

**Start** container (replace `<CERTS>` with path to `certs` directory):

```shell
docker run \
    --name qvisserver \
    -p 8443:443 \
    --restart unless-stopped \
    --volume=<CERTS>:/srv/certs \
    -d qvis/server:latest
```

Visualizer can be accessed by [127.0.0.1:8443](https://127.0.0.1:8443)

**Stop** container:

```shell
docker stop qvisserver
docker rm qvisserver
```
