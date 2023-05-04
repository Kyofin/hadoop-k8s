{{/*定义依赖的hadoop fs 配置名称*/}}
{{- define "hadoop-fs-conf" -}}
{{if eq .Values.hadoopFileSystemType "minio" }}
{{- printf "%s-hadoop-fs-config-minio" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "%s-hadoop-fs-config-juicefs" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "hdfs"}}
{{- $fullName := include "hive.hdfs.config.name" . -}}
{{- printf "%s" $fullName   -}}
{{end}}
{{- end -}}

{{/*定义依赖的hadoop yarn 配置名称*/}}
{{- define "hadoop-yarn-conf" -}}
{{- printf "%s-hadoop-yarn-conf" .Release.Name   -}}
{{- end -}}

{{- define "svc-domain" -}}
{{- printf "%s.svc.cluster.local" .Release.Namespace -}}
{{- end -}}

{{- define "metastore.fullname" -}}
{{- $name := "hive-metastore" -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hive-metastore-headless-uri" -}}
{{- if .Values.global.metastoreOverride -}}
{{- .Values.global.metastoreOverride -}}
{{- else -}}
{{- $service := include "metastore.fullname" . -}}
{{- $domain := include "svc-domain" . -}}
{{- $replicas := .Values.metastore.replicas | int -}}
{{- range $i, $e := until $replicas -}}
  {{- if ne $i 0 -}}
    {{- printf "thrift://%s-%d.%s-headless.%s:9083," $service $i $service $domain -}}
  {{- end -}}
{{- end -}}
{{- range $i, $e := until $replicas -}}
  {{- if eq $i 0 -}}
    {{- printf "thrift://%s-%d.%s-headless.%s:9083" $service $i $service $domain -}}
  {{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*默认使用内置pg作为元数据库*/}}
{{- define "hive.jdbcUrl" -}}
{{- if .Values.metastore.jdbc_url -}}
{{- printf "%s" .Values.metastore.jdbc_url -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresqlName -}}
{{- printf "%s%s-%s.%s.%s%s" "jdbc:postgresql://" .Release.Name $name .Release.Namespace "svc.cluster.local" "/hive" | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*默认使用内置pg创建的用户*/}}
{{- define "hive.user" -}}
{{- if .Values.metastore.jdbc_user -}}
{{- printf "%s" .Values.metastore.jdbc_user -}}
{{- else -}}
{{- printf "hadoop"  -}}
{{- end -}}
{{- end -}}

{{/*默认使用内置pg创建的密码*/}}
{{- define "hive.password" -}}
{{- if .Values.metastore.jdbc_password -}}
{{- printf "%s" .Values.metastore.jdbc_password -}}
{{- else -}}
{{- printf "hadoop_bigdata"  -}}
{{- end -}}
{{- end -}}

{{/*定义hdfs服务名称，默认使用内置集群的hdfs配置*/}}
{{- define "hive.hdfs.config.name" -}}
{{- if .Values.hadoopConfName -}}
{{- printf "%s" .Values.hadoopConfName -}}
{{- else -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hive.hdfs.name" -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hive.warehouse.dir" -}}
{{- printf "/app/hive/warehouse" -}}
{{- end -}}