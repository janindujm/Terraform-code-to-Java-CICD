provider "aws" {
  region = "us-east-1"  # change to your region
}


# Security group to allow SSH and HTTP (Tomcat default port 8080)
resource "aws_security_group" "tomcat_sg" {
  name        = "tomcat_sg"
  description = "Allow SSH and Tomcat HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allow SSH from anywhere (adjust as needed)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Tomcat web UI
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance for Tomcat
resource "aws_instance" "tomcat_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "devops-project-1"      # your existing key name in AWS
  security_groups = [aws_security_group.tomcat_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y

              # Install Java 17
              sudo amazon-linux-extras enable corretto17 -y
              sudo yum install -y java-17-amazon-corretto-devel

              # Download and install Tomcat 10
              sudo cd /opt
              sudo wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz
              sudo tar xvf apache-tomcat-10.0.27.tar.gz
              sudo mv apache-tomcat-10.0.27 tomcat

          
              EOF

  tags = {
    Name = "TomcatServer"
  }
}

# Output Tomcat URL and SSH command
output "tomcat_url" {
  value = "http://${aws_instance.tomcat_server.public_ip}:8080"
}

output "tomcat_ssh" {
  value = "ssh -i C:/Users/User/Downloads/devops-project-1.pem ec2-user@${aws_instance.tomcat_server.public_ip}"
}
