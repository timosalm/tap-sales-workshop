FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root

RUN apt-get update && apt-get install -y moreutils

# Tanzu CLI
ADD tanzu-framework-linux-amd64-v0.28.1.1.tar /tmp
RUN mv $(find /tmp/ -name 'tanzu-core-linux_amd64' -print0) /usr/local/bin/tanzu && \
  chmod 755 /usr/local/bin/tanzu && \
  tanzu plugin install --local /tmp/cli/ all && \
  chmod -R 755 .config/tanzu

# Install Tanzu Dev Tools
ADD tanzu-vscode-extension-0.14.1.vsix /tmp
ADD tanzu-app-accelerator-0.1.6.vsix /tmp
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=4.12.0
RUN cp -rf /usr/lib/code-server/* /opt/code-server/
RUN rm -rf /usr/lib/code-server /usr/bin/code-server

RUN code-server --install-extension /tmp/tanzu-vscode-extension-0.14.1.vsix
RUN code-server --install-extension /tmp/tanzu-app-accelerator-0.1.6.vsix
RUN chown -R eduk8s:users /home/eduk8s/.cache
RUN chown -R eduk8s:users /home/eduk8s/.local
RUN chown -R eduk8s:users /home/eduk8s/.config

# Cleanup directory

RUN rm -rf /tmp/*

USER 1001

RUN fix-permissions /home/eduk8s
