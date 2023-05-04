


{{/*默认使用内置minio地址作为底层存储，使用其默认创建的用户*/}}
{{- define "juicef.access_key" -}}
{{- $name := default "hadoop" .Values.access_key -}}
{{- printf "%s" $name -}}
{{- end -}}

{{/*默认使用内置minio地址作为底层存储，使用其默认创建的用户*/}}
{{- define "juicef.secret_key" -}}
{{- $name := default "hadoop_bigdata" .Values.secret_key -}}
{{- printf "%s" $name -}}
{{- end -}}

{{/*默认使用内置minio地址作为底层存储*/}}
{{- define "juicef.stroage" -}}
{{- $name := default "minio" .Values.stroage -}}
{{- printf "%s" $name -}}
{{- end -}}


{{/*默认使用内置pg作为元数据库*/}}
{{- define "juicef.meta_url" -}}
{{- if .Values.meta_url -}}
{{- printf "%s" .Values.meta_url -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresqlName -}}
{{- printf "postgres://hadoop:hadoop_bigdata@%s-%s.%s.svc.cluster.local:5432/juicefs?sslmode=disable"   .Release.Name $name .Release.Namespace   -}}
{{- end -}}
{{- end -}}


{{/*默认使用内置minio地址作为底层存储，使用其默认的地址*/}}
{{- define "juicef.bucket" -}}
{{- if .Values.bucket -}}
{{- printf "%s" .Values.bucket -}}
{{- else -}}
{{- printf "http://%s-minio.%s.%s:9000%s"  .Release.Name  .Release.Namespace "svc.cluster.local" "/juicefs" | trimSuffix "-" -}}
{{- end -}}
{{- end -}}