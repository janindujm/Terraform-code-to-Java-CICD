provider "aws" {
  region = "us-east-1" # Change to your region
}


# Security Group allowing SSH (22) access
resource "aws_security_group" "ansible_sg" {
  name        = "ansible-sg"
  description = "Allow SSH"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP from same SG"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker external app port"
    from_port   = 8081
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Docker app port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance for Ansible server
resource "aws_instance" "ansible_server" {
  ami           = "ami-0213fd5f98b28a6ea" 
  instance_type = "t2.micro"
  key_name      = "devops-project-1"
  security_groups = [aws_security_group.ansible_sg.name]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8           # optional, >= snapshot size
    delete_on_termination = true
  }

  tags = {
    Name = "Ansible-Server"
  }


}


output "Ansible_url" {
  value = "http://${aws_instance.ansible_server.public_ip}:8080"
}

output "ansible_ssh" {
  value = "ssh -i C:/Users/User/Downloads/devops-project-1.pem ec2-user@${aws_instance.ansible_server.public_ip}"
}