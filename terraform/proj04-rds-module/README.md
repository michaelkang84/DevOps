1. understand the RDS resource and which necessary resources we need [X]
2. create a module with the standard structure [X]
3. implement variable validation [X]
4. implement networking validation
    4.1 receive subnet ids and security group ids via variables [X]
    4.2 for subnet:
        4.2.1 make sure that they are not in the default VPC [X]
        4.2.2 make sure that they are private [X]
            4.2.2.1 check whether they are tagged with Access=Private [X]
    4.3 for security groups:
        4.3.1 make sure that there are no inbound rules for ip addresses
5. create the necessary resources and make sure the validation is working
6. create the RDS instance inside of the module