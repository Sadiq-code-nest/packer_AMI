packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

source "amazon-ebs" "ubuntu" {
  region          = "us-east-1"
  instance_type   = "t2.micro"
  ssh_username    = "ubuntu"
  ami_name        = "my-first-packer-image"
  source_ami      = "ami-0557a15b87f6559cf"

  access_key      = var.aws_access_key
  secret_key      = var.aws_secret_key
}

build {
  name    = "my-first-build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow proto tcp from any to any port 22",
      "sudo ufw allow proto tcp from any to any port 80",
      "sudo ufw allow proto tcp from any to any port 443",
      "echo 'y' | sudo ufw enable"
    ]
  }

  post-processor "vagrant" {}
  post-processor "compress" {}
}
