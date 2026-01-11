data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
data "aws_security_group" "app_sg" {
  name   = "app-sg"
  vpc_id = data.aws_vpc.default.id
}
resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  #vpc_security_group_ids = [aws_security_group.app_sg.id]
  vpc_security_group_ids = [data.aws_security_group.app_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y ca-certificates curl gnupg lsb-release

    curl -fsSL https://get.docker.com | sh

    usermod -aG docker ubuntu

    mkdir -p /usr/local/lib/docker/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v2.25.0/docker-compose-linux-x86_64 \
      -o /usr/local/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

    systemctl enable docker
    systemctl start docker
  EOF

  tags = {
    Name = "docker-app-ec2"
  }
}
