
##### VMware Tanzu Application Platform GUI
```dashboard:open-url
url: https://tap-gui.emea.end2end.link/create
```

##### VMware Application Catalog
**Important**: For the next sections, it is vital that you  make sure to sign-in to cloud.vmware.com with your **@vmware.com** email address and select the **"Tanzu End to End"** organization. Please be careful not to alter the services or configurations of the clusters in these environments as they are shared for the entire End to End Demo Environment.

Click below to sign in. If you can't see this organization, let us know your email address in the **#tanzu-e2e-demo** channel in Slack and we can get you added.
```dashboard:open-url
url: https://console.cloud.vmware.com
```

Open a tab to VMware Application Catalog.
```dashboard:open-url
url: https://marketplace.cloud.vmware.com/applicationcatalog/view
```

##### KubeApps
Copy your user token below to use to login to kubeapps in the next step.
```workshop:copy
text: {{ kubernetes_token }}
```

Now, click the following link to open a new tab to Kubeapps. In the login screen, paste your token into the text field, and click "Login".  
```dashboard:open-url
url: https://kubeapps.{{ ingress_domain }}/#/c/default/ns/{{ session_namespace }}/apps
```


