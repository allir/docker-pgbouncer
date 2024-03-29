FROM ubuntu:21.04

ENV LANG C.UTF-8
ENV PG_CONFIG /etc/pgbouncer/pgbouncer.ini
ENV PG_VERSION 1.15.0-1

EXPOSE 6432/tcp

RUN set -x\
    && apt-get -qq update \
    && apt-get install -yq --no-install-recommends pgbouncer=$PG_VERSION \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/postgresql \
    && chmod -R 755 /var/log/postgresql \
    && chown -R postgres:postgres /var/log/postgresql

USER postgres
CMD ["/bin/bash", "-c", "pgbouncer $PG_CONFIG"]
