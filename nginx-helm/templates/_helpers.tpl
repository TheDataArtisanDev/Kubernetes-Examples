# templates/_helpers.tpl
# This defines reusable template snippets (macros).

# Returns the chart name
{{- define "nginx-helm.name" -}}
{{ .Chart.Name }}
{{- end -}}

# Returns a full resource name using chart-name and release-name
{{- define "nginx-helm.fullname" -}}
{{ include "nginx-helm.name" . }}-{{ .Release.Name }}
{{- end -}}

# Returns common labels for reuse
{{- define "nginx-helm.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
