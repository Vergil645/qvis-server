FROM debian:12

RUN \
    apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl openssl git-core nano \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN \
    git clone --depth 1 https://github.com/quiclog/qvis-server.git /srv/qvisserver \
    && cd /srv/qvisserver \
    && npm install \
    && ./node_modules/typescript/bin/tsc -p . \
    && mkdir /srv/qvisserver/out/public

RUN \
    git clone --depth 1 https://github.com/rmarx/qvis.git /srv/qvis \
    && cd /srv/qvis/visualizations \
    && npm install \
    && npm run build \
    && cp -r /srv/qvis/visualizations/dist/* /srv/qvisserver/out/public

RUN mkdir /srv/certs

ADD startup.sh /
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
