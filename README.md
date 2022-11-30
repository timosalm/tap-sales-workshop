# A workshop for Sales that demonstrates VMware Tanzu Application Catalog and VMware Application Catalog

A [Learning Center for VMware Tanzu](https://docs.vmware.com/en/Tanzu-Application-Platform/1.3/tap/GUID-learning-center-about.html) workshop for Sales that demonstrates VMware Tanzu Application Catalog and VMware Application Catalog.

## Prerequisites

- A TAP 1.3 environment with OOTB Testing/Scanning Supply Chain installed

## Workshop installation
Download the Tanzu CLI for Linux, `Tanzu App Accelerator Extension for Visual Studio Code`, and the `Tanzu Developer Tools for Visual Studio Code` to the root of the workshop sub-directory.
Create a public project called **tap-workshop** in your registry instance. 

There is a Dockerfile in the `workshop` directory of this repo. From that directory, build a Docker image and push it to the project you created:
```
docker build . -t <your-registry-hostname>/tap-workshop/sales-workshop
docker push <your-registry-hostname>/tap-workshop/sales-workshop
```

Copy values-example.yaml to values.yaml and set configuration values
```
cp values-example.yaml values.yaml
```
Run the installation script.
```
./install.sh
``` 

## Debug
```
kubectl logs -l deployment=learningcenter-operator -n learningcenter
```
