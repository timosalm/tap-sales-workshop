
##### VMware Application Catalog - Deployment
Workshop content Date : Dec 1, 2022

###### Use your curated image created by VMware Application Catalog - Example of a postgreSQL database

To deploy a database through the helm chart provided by VMware Application Catalog in your registry, apply the following helm command :

```terminal:execute
command: helm install emoji oci://harbor.emea.end2end.link/vac-global-library/charts/centos-7/postgresql --set auth.database=emoji --set global.postgresql.auth.existingSecret=db-binding-compatible
clear: true
```

After few seconds, the database application will be deployed. You can check the "running" status thanks to the following command :
```terminal:execute
command: kubectl get pods
session: 2
clear: true
```
