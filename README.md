
### Aws RDS
The purpose here is just to demonstrate the minimum of aws resources which are needed
to operate a database instance in the cloud. In a nutshell, we'll provision the basic networking
pieces, which will allow us to ssh into ec2 instance located in a public subnet and 
from it reach our postgres RDS database located in a private subnet. 

These are:
- aws VPC
- public and private subnets, database subnet group
- elastic ip, internet gateway, route tables 
- security groups with inbound and outbound traffic rules
- t2.micro ec2 instance
- db parameter group (postgres configuration file, pg_hba.conf)
- db.t3.micro postgres 11 RDS instance  

In order to provision run `terraform init` and `terraform apply`, 
After successful apply, the necessary connection credentials will be printed as terraform
outputs,  ssh into the ec2 instance `ssh -i path/to/private.key ubuntu@$(terraform output ec2_ip)`
install a the psql client `sudo apt-get install -y postgresql-client`
and finally connect to your instance via `psql -h <hostname> -U <username>`.

