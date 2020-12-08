FROM ubuntu:20.04

ENV LANG C.UTF-8
ENV PG_CONFIG /etc/pgbouncer/pgbouncer.ini

EXPOSE 6432/tcp

RUN set -x\
    && apt-get -qq update \
    && apt-get install -yq --no-install-recommends pgbouncer=1.12.0-3 \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/postgresql \
    && chmod -R 755 /var/log/postgresql \
    && chown -R postgres:postgres /var/log/postgresql

USER postgres
CMD ["/bin/bash", "-c", "pgbouncer $PG_CONFIG"]
