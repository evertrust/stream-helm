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
{{- $allowedHosts := list }}
{{- if .Values.ingress.enabled -}}
  {{- $allowedHosts = append $allowedHosts .Values.ingress.hostname }}
  {{- range .Values.ingress.extraHosts }}
  {{- $allowedHosts = append $allowedHosts .name }}
  {{- end }}
  {{- range .Values.ingress.extraRules }}
  {{- if .host }}
  {{- $allowedHosts = append $allowedHosts .host }}
  {{- end }}
  {{- end }}
{{- end }}
{{- $allowedHosts = concat $allowedHosts .Values.allowedHosts }}
{{- toJson $allowedHosts}}
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
{{- if .Values.upgrade.force }}
    {{- print "true" }}
{{- else if not .Release.IsUpgrade }}
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

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either horizon.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "stream.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{- default (include "common.names.fullname" .) (print .Values.serviceAccount.name) -}}
    {{- else -}}
        {{- default "default" (print .Values.serviceAccount.name) -}}
    {{- end -}}
{{- end -}}