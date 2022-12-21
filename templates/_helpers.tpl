{{/*
Kubernetes standard labels
*/}}
{{- define "stream.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.name" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "stream.mongodb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mongodb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prints all Stream allowed hosts.
*/}}
{{- define "stream.allowedHosts" }}
    {{- if .Values.ingress.enabled -}}
        {{- printf "\"%s\"," .Values.ingress.hostname -}}
    {{- end -}}
    {{- range .Values.ingress.extraHosts -}}
        {{- printf "\"%s\"," .name -}}
    {{- end -}}
    {{- range .Values.allowedHosts -}}
        {{- printf "\"%s\"," . -}}
    {{- end -}}
{{- end }}

{{/*
Prints all Stream trusted proxies.
*/}}
{{- define "stream.trustedProxies" }}
    {{- range .Values.trustedProxies -}}
        {{- printf "\"%s\"," . -}}
    {{- end -}}
{{- end }}

{{/*
Prints the actual installed version on the cluster
*/}}
{{- define "stream.installedVersion" }}
{{- $deployment := (lookup (include "common.capabilities.deployment.apiVersion" .) "Deployment" .Release.Namespace (include "common.names.fullname" .)) }}
{{- if and $deployment $deployment.metadata $deployment.metadata.labels }}
    {{- index $deployment.metadata.labels "app.kubernetes.io/version" }}
{{- end }}
{{- end }}

{{/*
Prints true if an upgrade job should run, false if not.
*/}}
{{- define "stream.shouldRunUpgrade" }}
{{- if not .Release.IsUpgrade }}
    {{- print "false" }}
{{- else if not .Values.upgrade.enabled }}
    {{- print "false" }}
{{- else }}
    {{- $version := (include "stream.installedVersion" .) }}
    {{- if and $version (not (eq $version .Chart.AppVersion))}}
        {{- print "true" }}
    {{- else }}
        {{- print "false" }}
    {{- end }}
{{- end }}
{{- end }}