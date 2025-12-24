provider "aws" {
  region = "us-east-1"   # change if needed
}

# Security Group
resource "aws_security_group" "docker_sg" {
  name        = "docker-sg-1"
  description = "Allow SSH and Docker ports"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

  ingress {
    description = "Docker external app port"
    from_port   = 8081
    to_port     = 9000
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "docker_host" {
  ami           = "ami-0152212d25333501e"  # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  key_name      = "devops-project-1"       # your AWS key name
  security_groups = [aws_security_group.docker_sg.name]
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8           # optional, >= snapshot size
    delete_on_termination = true
  }
  
  tags = {
    Name = "Docker-Host"
  }
}

# Outputs
output "docker_host_ip" {
  value = aws_instance.docker_host.public_ip
}

output "ssh_command" {
  value = "ssh -i C:/Users/User/Downloads/devops-project-1.pem ec2-user@${aws_instance.docker_host.public_ip}"
}
