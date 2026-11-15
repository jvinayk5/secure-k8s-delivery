{{- define "ms.labels" -}}
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "ms.podSpec" -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 10001
  seccompProfile: { type: RuntimeDefault }
containers:
  - name: {{ .Values.name }}
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    ports:
      - containerPort: {{ .Values.containerPort }}
    env:
      {{- range $k, $v := .Values.env }}
      - { name: {{ $k }}, value: {{ $v | quote }} }
      {{- end }}
    readinessProbe:
      httpGet: { path: {{ .Values.probes.path }}, port: {{ .Values.containerPort }} }
      periodSeconds: 5
    livenessProbe:
      httpGet: { path: {{ .Values.probes.path }}, port: {{ .Values.containerPort }} }
      initialDelaySeconds: 10
      periodSeconds: 10
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities: { drop: [ALL] }
    resources:
      {{- toYaml .Values.resources | nindent 6 }}
{{- end -}}
