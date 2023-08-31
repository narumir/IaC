resource "tls_private_key" "k3s" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "k3s_key_pair" {
  key_name   = "k3s-key-pair"
  public_key = tls_private_key.k3s.public_key_openssh
  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.k3s.private_key_pem}' > ./private.pem"
  # }
}

resource "aws_instance" "k3s_master" {
  ami                         = "ami-0c9c942bd7bf113a2"
  instance_type               = "t3a.medium"
  key_name                    = aws_key_pair.k3s_key_pair.key_name
  subnet_id                   = aws_subnet.k3s_vpc_public_1.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_role.name
  ipv6_address_count          = 1
  vpc_security_group_ids = [
    aws_security_group.allow_http_https.id,
    aws_security_group.allow_ssh.id,
  ]
  root_block_device {
    volume_size = 80
  }
}
