resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow HTTP from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from VPC (temporary)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_instance" "server1" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  depends_on = [aws_nat_gateway.nat]
  associate_public_ip_address = false

  user_data = <<-EOF
#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -ex

# Wait for network (important for apt)
for i in {1..5}; do
  apt update -y && break || sleep 10
done

# Install nginx
apt install -y nginx

# Start nginx
systemctl enable nginx
systemctl restart nginx

# Fetch metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create HTML page
cat <<HTML | tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
</head>
<body style="text-align: center; font-family: Arial; margin-top: 100px;">
    <h1>Hello World!</h1>
    <p>Instance ID: <strong>$INSTANCE_ID</strong></p>
    <p>Availability Zone: <strong>$AZ</strong></p>
    <p>Served by: <strong>Nginx</strong></p>
</body>
</html>
HTML
              EOF

  tags = {
    Name = "private-ec2-server1"
  }
}

resource "aws_instance" "server2" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  depends_on = [aws_nat_gateway.nat]
  associate_public_ip_address = false 

  user_data = <<-EOF
#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -ex

# Wait for network (important for apt)
for i in {1..5}; do
  apt update -y && break || sleep 10
done

# Install nginx
apt install -y nginx

# Start nginx
systemctl enable nginx
systemctl restart nginx

# Fetch metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create HTML page
cat <<HTML | tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
</head>
<body style="text-align: center; font-family: Arial; margin-top: 100px;">
    <h1>Hello World!</h1>
    <p>Instance ID: <strong>$INSTANCE_ID</strong></p>
    <p>Availability Zone: <strong>$AZ</strong></p>
    <p>Served by: <strong>Nginx</strong></p>
</body>
</html>
HTML
EOF

  tags = {
    Name = "private-ec2-server2"
  }
}
