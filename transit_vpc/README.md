### Small set up for the transit Transit GW demo
```text
Create 3 VPC and each VPC is having a public SN and IGW for the external traffic
Now the task is to create ec2 instances in each of these 3 VPC's
and check if you can telnet each of them using the Transit GW
```

### Things to keep in mind
```text
You need to create a Transit GW, which will be having a default RT with
NO Associations
NO Propagations
NO Routes
```

### Do these steps manually
```text
Create the Transit GW Attachment to the VPC which is
Attach the Dev VPC tp Transit GW
Attach the QA VPC to Transit GW 
```

### Add the RT entry 
```text
This is Most important
Add the Route Table entry for the Dev Public SN which is 
Destination as CIDR/8 and Target as TransitGW 
and similar to it Add the Route table for the QA Public SN 
```

## What happens when the VPC are in different AWS Account
```text
Step 0
First AWS Account - AccountAAA
Second AWD Account - AccountBBB

Step 1
Create Resource Share
First Acct - Create Resource share using AWS Resoirce Access Mgr
Second Acct - Accept the resource share

Step 2
Second Acct - Create VPC, SN, IGW, Routes and EC2
Create VPC Attachment

First acct - Accept the VPC Attachement
First Acct - Verify Association, PRopagation

```