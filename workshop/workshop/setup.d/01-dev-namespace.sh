#!/bin/bash
set -x
set +e

export NS_USER_TOKEN=$(cat /home/eduk8s/.kube/config | yq .users[0].user.token)

REGISTRY_PASSWORD=$CONTAINER_REGISTRY_PASSWORD kp secret create registry-credentials --registry ${CONTAINER_REGISTRY_HOSTNAME} --registry-user ${CONTAINER_REGISTRY_USERNAME}
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-credentials"}, {"name": "tanzu-net-credentials"}]}'

kubectl annotate namespace ${SESSION_NAMESPACE} secretgen.carvel.dev/excluded-from-wildcard-matching-

cat << \EOF | kubectl apply -f -
apiVersion: tekton.dev/v1beta1
kind: Pipeline
metadata:
  name: developer-defined-tekton-pipeline
  labels:
    apps.tanzu.vmware.com/pipeline: test     # (!) required
spec:
  params:
    - name: source-url                       # (!) required
    - name: source-revision                  # (!) required
    - default: .
      name: source-sub-path
      type: string
  tasks:
    - name: test
      params:
        - name: source-url
          value: $(params.source-url)
        - name: source-revision
          value: $(params.source-revision)
        - name: source-sub-path
          value: $(params.source-sub-path)
      taskSpec:
        params:
          - name: source-url
          - name: source-revision
          - name: source-sub-path
        steps:
          - name: test
            image: maven:3-openjdk-11
            script: |-
              cd `mktemp -d`
              wget -qO- $(params.source-url) | tar xvz -m
              cd $(params.source-sub-path)
              mvn test
EOF
cat << EOF | kubectl apply -f -
apiVersion: scanning.apps.tanzu.vmware.com/v1beta1
kind: ScanPolicy
metadata:
  name: scan-policy
spec:
  regoFile: |
    package main

    # Accepted Values: "Critical", "High", "Medium", "Low", "Negligible", "UnknownSeverity"
    notAllowedSeverities := []
    ignoreCves := ["GHSA-36p3-wjmg-h94x", "CVE-2021-26291", "GHSA-g36h-6r4f-3mqp", "CVE-2016-1000027"]

    contains(array, elem) = true {
      array[_] = elem
    } else = false { true }

    isSafe(match) {
      severities := { e | e := match.ratings.rating.severity } | { e | e := match.ratings.rating[_].severity }
      some i
      fails := contains(notAllowedSeverities, severities[i])
      not fails
    }

    isSafe(match) {
      ignore := contains(ignoreCves, match.id)
      ignore
    }

    deny[msg] {
      comps := { e | e := input.bom.components.component } | { e | e := input.bom.components.component[_] }
      some i
      comp := comps[i]
      vulns := { e | e := comp.vulnerabilities.vulnerability } | { e | e := comp.vulnerabilities.vulnerability[_] }
      some j
      vuln := vulns[j]
      ratings := { e | e := vuln.ratings.rating.severity } | { e | e := vuln.ratings.rating[_].severity }
      not isSafe(vuln)
      msg = sprintf("CVE %s %s %s", [comp.name, vuln.id, ratings])
    }
EOF


kubectl create secret generic db-binding-compatible --from-literal=type=postgresql --from-literal=provider=vac --from-literal=jdbc-url=jdbc:postgresql://emoji-postgresql.${SESSION_NAMESPACE}.svc.cluster.local:5432/emoji --from-literal=password=emoji --from-literal=username=postgres

tanzu service claim create db-binding-compatible \
  --resource-name db-binding-compatible \
  --resource-kind Secret \
  --resource-api-version v1
