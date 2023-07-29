resource "aws_key_pair" "blog_ssh" {
  key_name   = "blog_ssh"
  public_key = data.aws_ssm_parameter.blog_prod_ssh_public_key.value
}

resource "aws_instance" "blog_backend" {
  ami                         = "ami-0c9c942bd7bf113a2"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.blog_ssh.key_name
  subnet_id                   = data.aws_subnet.seoul_public_subnet_1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.allow_http_https.id,
    aws_security_group.allow_ssh.id,
  ]
  root_block_device {
    volume_size = 30
  }
  tags = {
    Type    = "backend"
    Service = "blog"
  }
}
