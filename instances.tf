

######We will create 3 ec2 instances nat, web-1 and db-1###############
######Create and AWS EC2 instance named nat############################
resource "aws_instance" "nat" {
    # ami = "ami-0669a96e355eac82f"
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"        # consider changine this to use a variable
    instance_type = "m1.small"              # consider changing this to t2.micro if m1.small isn't free
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "VPC NAT"
    }
}


######Create and AWS EC2 instance named web-1############################
resource "aws_instance" "web-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "m1.small"              # consider changing this to t2.micro if m1.small isn't free
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags = {
        Name = "Web Server 1"
    }
}


######Create and AWS EC2 instance named db-1############################
resource "aws_instance" "db-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "m1.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    subnet_id = "${aws_subnet.us-east-1a-private.id}"
    source_dest_check = false

    tags = {
        Name = "DB Server 1"
    }
}