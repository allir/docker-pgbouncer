# pgbouncer-kubernetes

This project contains a [Helm](https://helm.sh/) chart and a [Docker](https://docker.com) image for [PgBouncer](https://pgbouncer.github.io).

---

## Configuration

Create a `my-values.yaml` file (or whatever filename you like) to add your *databases* and *users* settings.

```yaml
# my-values.yaml example
deployment:
  replicas: 1

databases:
  mydatabase:
    dbname: mydb
    host: dbserver

users:
  userlist:
    admin: supersecure
  admin_users:
  - admin

config:
  server_tls_sslmode: prefer
  ignore_startup_parameters: extra_float_digits
```

---

## Installation

In this repo:

```bash
helm install -f my-values.yaml pgbouncer ./chart
```

## Credit

This chart was made by combinging bits and pieces from other available charts and then modifying and adding in more stuff.

Sources:
* https://github.com/cradlepoint/kubernetes-helm-chart-pgbouncer
* https://github.com/duyet/charts/tree/master/pgbouncer
* https://github.com/wallarm/pgbouncer-chart
* https://www.pgbouncer.org/config.html
