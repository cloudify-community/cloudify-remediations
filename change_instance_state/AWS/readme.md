When you create a deployment using these blueprint , follow these steps :

in case you want to start ec2-instance:
trigger start-blueprint install [ providing instance_id, aws_region_name ]

in case you want to stop ec2-instance:
trigger stop-blueprint install [ providing instance_id, aws_region_name ]
