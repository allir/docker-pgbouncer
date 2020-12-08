{{- define "pgbouncer.userlist.txt" -}}
{{ range $k, $v := .Values.users.userlist }}
  {{- $k | quote }} {{ $v | quote }}
{{ end }}
{{- end }}
