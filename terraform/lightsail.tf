resource "aws_lightsail_key_pair" "blog" {
  name       = "blog-key-pair"
  public_key = tls_private_key.blog_ssh_private_key.public_key_openssh
  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.blog_ssh_private_key.private_key_pem}' > ./private.pem"
  # }
}

resource "tls_private_key" "blog_ssh_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_lightsail_instance" "blog_k3s" {
  name              = "blog-k3s"
  availability_zone = "ap-northeast-2a"
  blueprint_id      = "ubuntu_22_04"
  key_pair_name     = aws_lightsail_key_pair.blog.name
  bundle_id         = "medium_2_0"
}
