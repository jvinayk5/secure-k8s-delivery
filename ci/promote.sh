#!/usr/bin/env bash
# Bump the image tag for a service in the environment values file (GitOps).
# Usage: promote.sh <service> <env> <image-tag>
set -euo pipefail

service="${1:?service}"; env="${2:?env}"; tag="${3:?tag}"
values="charts/microservice/values-${env}.yaml"

[[ -f "$values" ]] || { echo "unknown environment: $env" >&2; exit 1; }

# Replace the tag line under the service's block marker: "# service: <name>"
sed -i -E "/# service: ${service}\$/,/^\s*tag:/ s|^(\s*tag:).*|\1 \"${tag}\"|" "$values"

git add "$values"
git commit -m "chore(${env}): deploy ${service} ${tag}"
git push origin HEAD:main
