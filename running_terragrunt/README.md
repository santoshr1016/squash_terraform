## Running the migrate_ec2_grunt project

### You first need to build the dependent modules first, **This is most important step** otherwise it will not work.

*I was under the impression that by defining the dependencies .hcl file will automatically build the dependent modules*
*Don't fall in the trap, I wasted a day scratching my head*

My **server** is dependent on **vpc** module, so 

I need to build first *vpc*
```text
1. Goto top dir of the whatever environment you want to create, "dev" env below and run
$ cd migrate_ec2_grunt/dry_terragrunt/environment/ap-southeast-1/dev/vpc
$ terragrunt plan -out tfplan   
$ terragrunt apply
```

Now, build *server*
```text
1. Goto top dir of the whatever environment you want to create, "dev" env below and run
$ cd migrate_ec2_grunt/dry_terragrunt/environment/ap-southeast-1/dev/server
$ terragrunt plan -out tfplan   
$ terragrunt apply
        OR
$ terragrunt apply-all
```

## Auto approve in terragrunt (Don't use this "RISKY")
```text
To auto-approve you can execute 
terragrunt apply-all --terragrunt-non-interactive
                    OR
echo "Y" | terragrunt apply-all
```

### Reference
Thank you [Sandeep Lamba] for helping me out and fixing the issue.

[Sandeep Lamba]: <https://github.com/sandeeplamb/>