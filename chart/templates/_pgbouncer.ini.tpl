{{- define "pgbouncer.pgbouncer.ini" -}}

[databases]
{{ range $key, $val := .Values.databases }}
  {{- $key }} = {{ range $k, $v := $val }} {{ $k }}={{ $v }}{{ end }}
{{ end }}

[pgbouncer]
listen_addr = *
listen_port = {{ include "pgbouncer.containerPort" .}}
unix_socket_dir = var/run/postgresql

auth_file = /etc/pgbouncer/userlist.txt

admin_users = {{ join "," .Values.users.admin_users }}
stats_users = {{ join "," .Values.users.stats_users }}

{{ range $key, $val := .Values.config }}
{{ $key }} = {{ $val }}
{{ end }}

{{- end }}
