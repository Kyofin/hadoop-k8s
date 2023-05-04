{{/*定义yarn依赖的hadoop fs 配置名称*/}}
{{- define "hadoop-fs-conf" -}}
{{if eq .Values.hadoopFileSystemType "minio" }}
{{- printf "%s-hadoop-fs-config-minio" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "%s-hadoop-fs-config-juicefs" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "hdfs"}}
{{- $fullName := include "yarn.hdfs.config.name" . -}}
{{- printf "%s" $fullName   -}}
{{end}}
{{- end -}}



{{/*定义hdfs服务名称，默认使用内置集群的hdfs配置*/}}
{{- define "yarn.hdfs.config.name" -}}
{{- if .Values.hadoopConfName -}}
{{- printf "%s" .Values.hadoopConfName -}}
{{- else -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "yarn.hdfs.name" -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*定义zookeeper服务名称*/}}
{{- define "yarn.zookeeper-fullname" -}}
{{- $fullname := .Release.Name -}}
{{- if contains "zookeeper" $fullname -}}
{{- printf "%s" $fullname -}}
{{- else -}}
{{- printf "%s-zookeeper" $fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "svc-domain" -}}
{{- printf "%s.svc.cluster.local" .Release.Namespace -}}
{{- end -}}

{{/*定义zookeeper访问地址*/}}
{{- define "yarn.zookeeper-quorum" -}}
{{- if .Values.zookeeperQuorumOverride -}}
{{- .Values.zookeeperQuorumOverride -}}
{{- else -}}
{{- $service := include "yarn.zookeeper-fullname" . -}}
{{- $domain := include "yarn.svc-domain" . -}}
{{- $replicas := .Values.zookeeperQuorumSize | int -}}
{{- range $i, $e := until $replicas -}}
  {{- if ne $i 0 -}}
    {{- printf "%s-%d.%s-headless.%s:2181," $service $i $service $domain -}}
  {{- end -}}
{{- end -}}
{{- range $i, $e := until $replicas -}}
  {{- if eq $i 0 -}}
    {{- printf "%s-%d.%s-headless.%s:2181" $service $i $service $domain -}}
  {{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "yarn.svc-domain" -}}
{{- printf "%s.svc.cluster.local" .Release.Namespace -}}
{{- end -}}