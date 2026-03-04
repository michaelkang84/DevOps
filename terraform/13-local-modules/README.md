A networking modules that should:
1. Create VPC with a given CIDR block
2. Allow the user to provide the configuration for multiple subnets
    2.1 The user should be able to mark a subnet public/private
    2.2 The user should be able to provide CIDR blocks for the subnets
    2.3 Should be able to provide the AWS AZ for the subnets
        2.3.1 If at least one subnet is public, we need to deploy an IGW
        2.3.2 Need to associate public subnets with a public RTB