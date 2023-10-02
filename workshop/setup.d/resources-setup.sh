#!/bin/bash
set -x
set +e

kubectl annotate namespace ${SESSION_NAMESPACE} secretgen.carvel.dev/excluded-from-wildcard-matching-

kubectl patch serviceaccount default -p '{"secrets": [{"name": "registry-credentials"},{"name": "git-https"}], "imagePullSecrets": [{"name": "registry-credentials"}]}'
kubectl apply -f ~/samples/scan-policy.yaml

kubectl create secret generic db-binding-compatible --from-literal=type=postgresql --from-literal=provider=vac --from-literal=jdbc-url=jdbc:postgresql://emoji-postgresql.${SESSION_NAMESPACE}.svc.cluster.local:5432/emoji --from-literal=password=emoji --from-literal=username=postgres --from-literal=postgres-password=emoji

tanzu services resource-claim create db-binding-compatible --resource-name db-binding-compatible --resource-kind Secret --resource-api-version v1