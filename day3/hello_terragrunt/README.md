### Motivation for writing DRY IaC
```text
This work is inspired from terragrunt.io
The code sample are borrowed from there.
```

## Running the hello terragrunt project
```text
1. We are calling the modules locally, thats the reason your will find this [line]
2. Go to the [folder]
3. Run the command to see the plan, terragrunt plan -out tfplan 
4  Fire the command to create resources,  terragunt apply
```

## Auto approve in terragrunt
```text
To auto-approve you can execute 
terragrunt apply-all --terragrunt-non-interactive
                    OR
echo "Y" | terragrunt apply-all
```

### Reference
line here [line]

folder here [folder]

[line]: <https://github.com/santoshr1016/squash_terraform/blob/master/day3/hello_terragrunt/dry_terragrunt/environment/ap-southeast-1/qa/webserver-cluster/terragrunt.hcl#L13>
[folder]: <https://github.com/santoshr1016/squash_terraform/tree/master/day3/hello_terragrunt/dry_terragrunt/environment/ap-southeast-1/qa/webserver-cluster>