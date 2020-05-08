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