terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      "project" = "jenkins-test"
    }
  }
}

resource "aws_vpc" "default_vpc" { }

resource "aws_key_pair" "ssh_key" {
    key_name = "server-ssh-key"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgmU/hV2ktIbJn9ibnvD24w7uFWGG5miyr1IjNyK28b charly@yogarch"
}

resource "aws_instance" "server" {
    instance_type = "t2.micro"
    ami = "ami-09da212cf18033880"
    associate_public_ip_address = true
    subnet_id = "subnet-0cc606195c895a027"
    key_name = aws_key_pair.ssh_key.key_name

    vpc_security_group_ids = [aws_security_group.allow_web_access.id]
}

resource "aws_security_group" "allow_web_access" {
    name = "allow_web_access"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "all"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "server_public_ip" {
    value = aws_instance.server.public_ip
}