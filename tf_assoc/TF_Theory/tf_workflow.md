### terraform init [options] [DIR]
During init, Terraform searches the configuration for both direct and indirect references to providers and 
attempts to load the required plugins.

For providers distributed by HashiCorp, init will automatically download and install plugins if necessary. 
Plugins can also be manually installed in the user plugins directory, located at ~/.terraform.d/plugins

```text
The terraform init command is used to initialize a working directory containing Terraform configuration files.
-input=true Ask for input if necessary. If false, will error if input was required.

-lock=false Disable locking of state files during state-related operations.

-get-plugins=false — Skips plugin installation.

-plugin-dir=PATH — Skips plugin installation and loads plugins only from the specified directory. 

```

### terraform validate
```text
This command validates the configuration files in a directory.
Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, 
regardless of any provided variables or existing state.

Validation requires an initialized working directory with any referenced plugins and modules installed.
If dir is not specified, then the current directory will be used.

```

### terraform plan [options] [dir]
```text
The terraform plan command is used to create an execution plan. 
Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve 
the desired state specified in the configuration files.

This command is a convenient way to check whether the execution plan for a set of changes matches your expectations 
without making any changes to real resources or to the state.
```
