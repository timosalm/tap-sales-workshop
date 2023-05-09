#!/bin/bash
set -x
set +e

jq ". + {\"security.workspace.trust.enabled\": false, \"java.server.launchMode\": \"Standard\", \"tanzu.sourceImage\": \"${CONTAINER_REGISTRY_HOSTNAME}/${CONTAINER_REGISTRY_REPOSITORY}/emoji-source\", \"tanzu.namespace\": \"${SESSION_NAMESPACE}\", \"redhat.telemetry.enabled\": false, \"tanzu-app-accelerator.tanzuApplicationPlatformGuiUrl\": \"https://tap-gui.${TAP_INGRESS}\" }" /home/eduk8s/.local/share/code-server/User/settings.json | sponge /home/eduk8s/.local/share/code-server/User/settings.json