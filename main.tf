terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.80.0"
    }
  }
}

provider "aws"{
    region="ap-south-1"
}


resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "my-vpc"
    }
  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone  = "ap-south-1a"

    tags = {
        Name = "public"
    }
  
}



resource "aws_subnet" "private" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "private"
    }

}

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id

    tags = {
      Name ="my-igw"
    }
  
}

resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id

    }

    tags = {
      Name = "MY-RT"
    }
  
}

resource "aws_route_table_association" "table_assosiation" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public.id
}


resource "aws_instance" "public_instace" {
    ami = "ami-053b12d3152c0cc71"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.my-sec.id]
    associate_public_ip_address = true

    user_data = <<-EOF
                    #!/bin/bash
                    sudo apt-get update -y
                    sudo apt-get install nginx -y
                    sudo systemctl start nginx
                EOF


    tags = {
        Name = "public-machine"
    }
  
}