# main.tf

provider "aws" {
  region = "us-east-1"  # Change your region
}

# Security Group to allow HTTP and SSH
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow SSH and Jenkins HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Jenkins web UI
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# EC2 instance to run Jenkins
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)ami-0152212d25333501e
  instance_type = "t2.medium"
  key_name      = "devops-project-1"
  security_groups = [aws_security_group.jenkins_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras enable corretto17 -y
              sudo yum install -y java-17-amazon-corretto-devel
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              sudo yum install -y jenkins
              sudo yum install -y git
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF

  tags = {
    Name = "JenkinsServer"
  }
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "jenkins_ssh" {
  value = "ssh -i C:/Users/User/Downloads/devops-project-1.pem ec2-user@${aws_instance.jenkins_server.public_ip}"
}