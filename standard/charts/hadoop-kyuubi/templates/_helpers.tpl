{{/*
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "kyuubi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kyuubi.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kyuubi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*定义依赖的hadoop fs 配置名称*/}}
{{- define "kyuubi.hadoop-fs-conf" -}}
{{if eq .Values.hadoopFileSystemType "minio" }}
{{- printf "%s-hadoop-fs-config-minio" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "%s-hadoop-fs-config-juicefs" .Release.Name   -}}
{{else if eq .Values.hadoopFileSystemType "hdfs"}}
{{- $fullName := include "kyuubi.hdfs.config.name" . -}}
{{- printf "%s" $fullName   -}}
{{end}}
{{- end -}}

{{/*定义依赖的hadoop yarn 配置名称*/}}
{{- define "kyuubi.hadoop-yarn-conf" -}}
{{- printf "%s-hadoop-yarn-conf" .Release.Name   -}}
{{- end -}}


{{/*定义依赖的hadoop hive 配置名称*/}}
{{- define "kyuubi.hadoop-hive-conf" -}}
{{- printf "%s-hive-client-cfg" .Release.Name   -}}
{{- end -}}

{{/*定义hdfs服务名称，默认使用内置集群的hdfs配置*/}}
{{- define "kyuubi.hdfs.config.name" -}}
{{- if .Values.hadoopConfName -}}
{{- printf "%s" .Values.hadoopConfName -}}
{{- else -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "kyuubi.hdfs.name" -}}
{{- $name := default "hadoop" .Values.hadoopName -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "kyuubi.history.fs.logDirectory" -}}
{{if eq .Values.hadoopFileSystemType "juicefs"}}
{{- printf "jfs://myjfs/spark3/history"    -}}
{{else if eq  .Values.hadoopFileSystemType "hdfs"}}
{{- printf "hdfs:///spark3/history"    -}}
{{end}}
{{- end -}}