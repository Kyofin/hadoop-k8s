{{/*定义依赖的hadoop fs 配置名称*/}}
{{- define "spark.hadoop-fs-conf" -}}
{{if eq .Values.hadoopFileSystemType "minio" }}
{{- printf "%s-hadoop-fs-config-minio" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "%s-hadoop-fs-config-juicefs" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "hdfs"}}
{{- $fullName := include "spark.hdfs.config.name" . -}}
{{- printf "%s" $fullName   -}}
{{end}}
{{- end -}}

{{/*定义依赖的hadoop yarn 配置名称*/}}
{{- define "spark.hadoop-yarn-conf" -}}
{{- printf "%s-hadoop-yarn-conf" .Release.Name   -}}
{{- end -}}


{{/*定义依赖的hadoop hive 配置名称*/}}
{{- define "spark.hadoop-hive-conf" -}}
{{- printf "%s-hive-client-cfg" .Release.Name   -}}
{{- end -}}


{{- define "spark.history.fs.logDirectory" -}}
{{if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "jfs://myjfs/spark3/history"    -}}
{{else if eq  .Values.hadoopFileSystemType "hdfs"}}
{{- printf "hdfs:///spark3/history"    -}}
{{end}}
{{- end -}}

{{/*定义hdfs服务名称，默认使用内置集群的hdfs配置*/}}
{{- define "spark.hdfs.config.name" -}}
{{- if .Values.hadoopConfName -}}
{{- printf "%s" .Values.hadoopConfName -}}
{{- else -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "spark.hdfs.name" -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
