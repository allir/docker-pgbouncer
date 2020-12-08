# kubernetes-helm-chart-pgbouncer

This project is a [Helm](https://helm.sh/) chart for [PgBouncer](https://pgbouncer.github.io).

---

## Configuration

Create a `my-values.yaml` file (or whatever filename you like) to add your *databases* and *users* settings.

```yaml
# my-values.yaml example
replicaCount: 1
verbose: 1

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
