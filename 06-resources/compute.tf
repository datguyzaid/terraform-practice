resource "aws_instance" "web" {
  ami                         = "ami-039a0a36e50f80262"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "Nginx Instance"
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags ]
  }
}

resource "aws_security_group" "public_http_traffic" {
  name        = "public_http_traffic"
  description = "Security group allowing traffic on ports 80 and 443"
  vpc_id      = aws_vpc.nginx.id

  tags = merge(local.common_tags, {
    Name = "public_http_traffic"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "TCP"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "TCP"
}
