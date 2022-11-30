**Persona: Developers**

Inspired by [start.spring.io](https://start.spring.io), **Application Accelerator for VMware Tanzu** enables developers to create new applications based on templates that follow enterprise standards defined by platform engineers and architects. This accelerates how a developer goes from idea to running system with ready-made, enterprise-conformant code and configurations.

Application Accelerator for VMware Tanzu is available in the VMware Tanzu Application Platform GUI, ...
```dashboard:open-url
url: https://tap-gui.{{ ENV_TAP_INGRESS }}/create
```
... the **tanzu CLI** with additional capabilites for managing accelerators in the cluster, ...
```terminal:execute
command: tanzu accelerator list --server-url http://accelerator.{{ ENV_TAP_INGRESS }}
clear: true
```
... and as IDE plugin.
```editor:execute-command
command: tanzu-app-accelerator.showAccelerator
args: []
```