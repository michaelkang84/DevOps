resource "aws_instance" "web" {
  #   ami                         = "ami-04680790a315cd58d" (Ubuntu)
  ami                         = "ami-015ca9ee3db5edec7" # NGINX AMI Public
  associate_public_ip_address = true
  instance_type               = "t3.micro"

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  tags = merge(local.common_tags, {
    Name = "06-resources-ec2"
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }
}


resource "aws_security_group" "public_http_traffic" {
  name        = "06-resources-public-http-traffic-sg"
  description = "Allow traffic on ports 443 and 80"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "06-resources-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "public_http_traffic" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "public_https_traffic" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}