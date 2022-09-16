variable "aws_access_key" {
    # default = "ACCESS"
 
}
variable "aws_secret_key" {
    # default = "SECRET"
   
}
variable "aws_key_path" {
    # default = "/root/terraform-ansible/terraform"
    default     = "~/.ssh/wordpress.pem"
}
variable "aws_key_name" {
    # default = "ansible"
    default = "wordpress"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"                   #changed to us-east-1
}

variable "amis" {
    description = "AMIs by region"
    default = {
        # sa-east-1 = "ami-0669a96e355eac82f"       # original
        us-east-1 = "ami-052efd3df9dad4825"       # changed for us-east-1 # change this to use a data lookup for best practice
    }


    # ami           = data.aws_ami.ubuntu.id
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}
