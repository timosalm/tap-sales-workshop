The inital version of our project is now ready to be pushed to a repository of a version control system like Git to make it available to other team members.
In our case the source code is already available on GitHub.

With TAP, by design, **a path to production can be reused by many applications**. 
![](../images/cartographer.png)
This allows an operator to specify the steps in the path to production a single time, and for developers to specify their applications independently but for each to use the same path to production. The intent is that developers are able to focus on providing value for their users and can reach production quickly and easily, while providing peace of mind for app operators, who are ensured that each application has passed through the steps of the path to production that they’ve defined.

To set configurations like the location of the source code repository, environment variables and service claims for an application, there is an interface for developers called **Workload**. 

Let's have a look at the ready to use Workload configuration provided by our accelerator.
```editor:open-file
file: ~/inclusion/config/workload.yaml
```

Development teams are able to initiate the continous path to production with the tanzu CLI or via GitOps.
```terminal:execute
command: tanzu apps workload create -f config/workload.yaml -y
clear: true
```