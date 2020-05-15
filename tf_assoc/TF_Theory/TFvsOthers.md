### Terraform vs. Chef, Puppet, etc.
```text
Configuration management tools install and manage software on a machine that already exists.

Terraform is not a CM tool, and it allows existing tooling to focus on their strengths: bootstrapping and initializing resources.

Using provisioners, Terraform enables any configuration management tool to be used to setup a resource once it has been 
created. 
``` 

### Terraform vs. CloudFormation, Heat, etc.
```text
Similarity
Tools like CloudFormation, Heat, etc. allow the details of an infrastructure to be codified into a configuration file.
Terraform complements this with cloud-agnostic and enablement of multiple providers and services to be combined and composed.

For example, Terraform can be used to orchestrate an AWS and OpenStack cluster simultaneously, while enabling 
3rd-party providers like Cloudflare and DNSimple to be integrated to provide CDN and DNS services.

Terraform also separates the planning phase from the execution phase, by using the concept of an execution plan.

By running terraform plan, the current state is refreshed and the configuration is consulted to generate an action plan. 
The plan includes all actions to be taken: which resources will be created, destroyed or modified. 
It can be inspected by operators to ensure it is exactly what is expected.

 
```