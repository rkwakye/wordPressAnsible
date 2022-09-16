# changed region from sa-east-1 to us-east-1

####Create a VPC with a CIDR block defined using a variable VPC_cidr#############
resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true

    tags = {
        Name = "terraform-aws-vpc"
    }
}


###Create an elastic IP named NAT and assign it to the instance id for aws instance named nat###############
######The nat instance will be created in the instances.tf file#############################################
resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}


###Create an elastic IP named NAT and assign it to the instance id for aws instance named web-1###############
resource "aws_eip" "web-1" {
    instance = "${aws_instance.web-1.id}"
    vpc = true
}



###Create route table for us-east-1a-public subnet########
resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"            #####?????????
        gateway_id = "${aws_internet_gateway.ig-main.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}


###Create corresponding route table association#############
resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}


###Create route table us-east-1a-private###################
resource "aws_route_table" "us-east-1a-private" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags = {
        Name = "Private Subnet"
    }
}



####Create corresponding route table association############
resource "aws_route_table_association" "us-east-1a-private" {
    subnet_id = "${aws_subnet.us-east-1a-private.id}"
    route_table_id = "${aws_route_table.us-east-1a-private.id}"
}



#####Create us-east-1a-public subnet#######################
resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Public Subnet"
    }
}



#######create us-east-1a-private subnet#######################
resource "aws_subnet" "us-east-1a-private" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Private Subnet"
    }
}


######Create aws internet gateway #############################
resource "aws_internet_gateway" "ig-main" {
    vpc_id = "${aws_vpc.main_vpc.id}"
}